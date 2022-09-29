# frozen_string_literal: true

module Users
  class OmniauthCallbacksController < Devise::OmniauthCallbacksController
    def aronnax
      @user = User.from_omniauth(request.env['omniauth.auth'])

      return authenticate_user if user.persisted?

      session['devise.aronnax_data'] = request.env['omniauth.auth']
      redirect_to root_path
    end

    def failure
      redirect_to root_path
    end

    private

    def user
      @user ||= User.from_omniauth(request.env['omniauth.auth'])
    end

    def authenticate_user
      user.update_aronnax_credentials(request.env['omniauth.auth'])
      sign_in_and_redirect @user, event: :authentication
      set_flash_message(:notice, :success, kind: 'Aronnax') if is_navigational_format?
    end
  end
end
