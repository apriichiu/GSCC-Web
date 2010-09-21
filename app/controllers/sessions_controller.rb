class SessionsController < ApplicationController


  def create
    if Digest::SHA256.hexdigest(params[:password]) == "0f06bb7d50077b038be79b69ca6f37b271ee3ff4c6e7a790ba7d40473729a646"
      session[:password] = "7ba44afcb856df9ff8152cff1752a2eb69da845edfa57d328bbb1050f2caee60"
      flash[:notice] = "Successfully logged in"
      redirect_to params[:redirect]
    else
      session[:password] = ""
      flash[:notice] = "Incorrect password"
      redirect_to params[:redirect]
    end

  end

  def destroy
    reset_session
    flash[:notice] = "Successfully logged out"
    redirect_to request.referer
  end

end
