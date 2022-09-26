class ApplicationController < ActionController::Base
  before_action :authenticate_user!

  private

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
