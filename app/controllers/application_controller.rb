class ApplicationController < ActionController::Base
  include SessionsHelper

  private

    # ユーザーのログインを確認する
    def logged_in_user
      return if logged_in?

      flash[:danger] = 'Please log in.'
      store_location
      redirect_to(login_url)
    end

end
