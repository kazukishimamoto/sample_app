class SessionsController < ApplicationController

  def new
  end

  # rubocop:disable Metrics/AbcSize
  def create
    @user = User.find_by(email: params[:session][:email].downcase)
    if @user&.authenticate(params[:session][:password])
      log_in @user
      params[:session][:remember_me] == '1' ? remember(@user) : forget(@user)
      # ↑の行これでよくね：remember(@user) if params[:session][:remember_me] == '1'
      redirect_back_or @user
    else
      flash.now[:danger] = 'Invalid email/password combination' # 本当は正しくない
      render 'new'
    end
  end
  # rubocop:enable Metrics/AbcSize

  def destroy
    log_out if logged_in?
    redirect_to root_url
  end
end
