# frozen_string_literal: true

class ApplicationController < ActionController::Base
  include Pundit::Authorization

  rescue_from Pundit::NotAuthorizedError, with: :user_not_authorized

  before_action :authenticate_user!

  private

  def user_not_authorized
    flash[:alert] = 'You are not authorized to perform this action.'
    redirect_to(request.referrer || root_path)
  end

  def aronnax_oauth_client
    @aronnax_oauth_client ||= OAuth2::Client.new(
      ENV.fetch('ARONNAX_APP_ID'),
      ENV.fetch('ARONNAX_APP_SECRET'),
      site: ENV.fetch('ARONNAX_APP_URL')
    )
  end

  def aronnax_access_token
    @aronnax_access_token ||=
      if current_user
        OAuth2::AccessToken.new(
          aronnax_oauth_client, current_user.aronnax_access_token
        )
      end
  end
end
