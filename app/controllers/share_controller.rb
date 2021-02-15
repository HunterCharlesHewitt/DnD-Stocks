class ShareController < ApplicationController
    skip_before_action :verify_authenticity_token
    def create
        wealth = User.find((params[:user_id]).to_i).uninvested_wealth
        puts("**************************")
        puts(wealth.to_i - (params[:buy_price]).to_i)
        if (wealth.to_i - (params[:buy_price]).to_i) < 0 
            redirect_to "/user/#{params[:user_id]}",alert: 'Not enough wealth to purchase'
            return
        end
        @share = Share.new(company_id: (params[:company_id]).to_i, user_id: (params[:user_id]).to_i,buy_price: (params[:buy_price]).to_i,rob_hum_elf: params[:rob_hum_elf])    
        @share.save()
        User.find((params[:user_id]).to_i).update_attribute(:uninvested_wealth, wealth.to_i-(params[:buy_price]).to_i)
        redirect_to "/user/#{params[:user_id]}"
    end

    def delete
        @share = Share.find(params[:id])
        wealth = User.find(@share.user_id).uninvested_wealth
        if @share.rob_hum_elf == 0
            curr = Company.find(@share.company_id).minute_stocks_robot[((((DateTime.now - 0.minutes)-DateTime.new(2021,01,8,00, 27, 00))*24*60)-360).to_i ]
        elsif @share.rob_hum_elf == 1
            curr = Company.find(@share.company_id).minute_stocks_human[((((DateTime.now - 0.minutes)-DateTime.new(2021,01,8,00, 27, 00))*24*60)-360).to_i ]
        else
            curr = Company.find(@share.company_id).minute_stocks_elf[((((DateTime.now - 0.minutes)-DateTime.new(2021,01,8,00, 27, 00))*24*60)-360).to_i ]
        end
        User.find(@share.user_id).update_attribute(:uninvested_wealth,wealth.to_i+curr.to_i)
        
        @share.destroy()
        redirect_back fallback_location: root_path
    end

    def boom
        Share.all.each do |share|
            comp = Company.find(share.company_id);
            new_rob = Marshal.load(Marshal.dump(comp.minute_stocks_robot)) 
            new_hum = Marshal.load(Marshal.dump(comp.minute_stocks_human)) 
            new_elf = Marshal.load(Marshal.dump(comp.minute_stocks_elf)) 
        
            new_rob2 = Marshal.load(Marshal.dump(comp.day_stocks_robot)) 
            new_hum2 = Marshal.load(Marshal.dump(comp.day_stocks_human)) 
            new_elf2 = Marshal.load(Marshal.dump(comp.day_stocks_elf)) 
            for i in 55658..84458
                is_boom = rand(100) >= 50 ? 1 : -1 
                if(share.rob_hum_elf == 0)
                    new_rob[i] = (new_rob[i-1].to_i + 1 + (is_boom)*rand(50)).to_s;
                elsif (share.rob_hum_elf == 1)
                    new_hum[i] = (new_hum[i-1].to_i + 1 + (is_boom)*rand(40)).to_s;
                else
                    new_elf[i] = (new_elf[i-1].to_i + 1 + (is_boom)*rand(30)).to_s;
                end  
            end     
            
            new_rob2[16] = new_rob[24445];
            new_hum2[16] = new_hum[24445];
            new_elf2[16] = new_elf[24445];
        
            comp.update_attribute(:minute_stocks_robot,new_rob);
            comp.update_attribute(:minute_stocks_elf,new_elf) ;
            comp.update_attribute(:minute_stocks_human,new_hum); 
            comp.update_attribute(:day_stocks_elf,new_elf2) ;
            comp.update_attribute(:day_stocks_human,new_hum2)  
            comp.update_attribute(:day_stocks_robot,new_rob2) ;
            
        end 
        puts("************************************************")
        puts(done)
        redirect_to "/stocks/#{Company.first.id}"
    end
end
