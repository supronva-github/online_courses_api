# frozen_string_literal: true

Doorkeeper.configure do
  orm :active_record
  grant_flows %w[password client_credentials]
  handle_auth_errors :raise unless Rails.env.production?

  resource_owner_from_credentials do |_routes|
    user = User.find_by(email: params[:email])
    user if user&.authenticate(params[:password])
  end
end
