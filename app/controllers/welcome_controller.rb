class WelcomeController < ApplicationController
  skip_before_action :verify_authenticity_token
  def index
  end

  def create_session
    user = User.find_by(name: params[:name])
    if user
      session[:user_id] = user.id
    else
      session[:user_id] = nil
    end
    
    redirect_to "/scan/"
  end

  def getNeg(goodness)
      rando = rand(1..100);
      return rando < goodness ? 1 : -1
  end

  def set_company
    comp=Company.find(params[:id].to_i)
    new_rob = Marshal.load(Marshal.dump(comp.minute_stocks_robot)) 
    new_hum = Marshal.load(Marshal.dump(comp.minute_stocks_human)) 
    new_elf = Marshal.load(Marshal.dump(comp.minute_stocks_elf)) 

    new_rob2 = Marshal.load(Marshal.dump(comp.day_stocks_robot)) 
    new_hum2 = Marshal.load(Marshal.dump(comp.day_stocks_human)) 
    new_elf2 = Marshal.load(Marshal.dump(comp.day_stocks_elf)) 

    time = (((((DateTime.now -  0.minutes)-DateTime.new(2021,01,8,00, 27, 00))*24*60)-360).to_i)
    if(params[:rob_hum_elf].to_i == 0)
      val = new_rob[time].to_i
    elsif(params[:rob_hum_elf].to_i == 1)
      val = new_hum[time].to_i
    else
      val = new_elf[time].to_i
    end
    val = val.to_i
    for i in time..(time+20000)
      val += (rand(params[:volatility].to_i).to_i * getNeg(params[:goodness].to_i)).to_i
      if(val < 0) 
        val = 0 
      end
      if(params[:rob_hum_elf].to_i == 0)
        if(i < new_rob.size)
          new_rob[i] = val
        else 
          new_rob << val
        end
      elsif(params[:rob_hum_elf].to_i == 1)
        if(i < new_hum.size)
          new_hum[i] = val
        else
          new_hum << val
        end
      else
        if(i < new_elf.size)
          new_elf[i] = val
        else 
          new_elf << val
        end
      end
        
      if(i % 1440 == 0)
        if(params[:rob_hum_elf].to_i == 0)
          new_rob2[i/1440] = val
        elsif(params[:rob_hum_elf].to_i == 1)
          new_hum2[i/1440] = val
        else
          new_elf2[i/1440] = val
        end
      end
    end

      comp.update_attribute(:minute_stocks_robot,new_rob);
      comp.update_attribute(:minute_stocks_elf,new_elf) ;
      comp.update_attribute(:minute_stocks_human,new_hum); 
      comp.update_attribute(:day_stocks_elf,new_elf2) ;
      comp.update_attribute(:day_stocks_human,new_hum2)  
      comp.update_attribute(:day_stocks_robot,new_rob2) ;
      puts("**********************************************")
      puts("done")
      puts("**********************************************")
      redirect_to "/stocks/#{params[:id]}"
  end
  
  
end
