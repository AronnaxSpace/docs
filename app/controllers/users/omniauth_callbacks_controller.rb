class Users::OmniauthCallbacksController < Devise::OmniauthCallbacksController
  def aronnax
    @user = User.from_omniauth(request.env['omniauth.auth'])

    if @user.persisted?
      @user.update_aronnax_credentials(request.env['omniauth.auth'])
      sign_in_and_redirect @user, event: :authentication
      set_flash_message(:notice, :success, kind: 'Aronnax') if is_navigational_format?
    else
      session['devise.aronnax_data'] = request.env['omniauth.auth']
      redirect_to root_path
    end
  end

  def failure
    redirect_to root_path
  end
end
