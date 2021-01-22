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
end
