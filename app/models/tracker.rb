class Tracker
  def self.from_token token, client = ApiClient.new,
                             factory = UsersFactory.new

    user_data = client.get_user_by_token(token)
    user_data ? new(factory.from_api_response(user_data)) : (raise AccessDeniedError)
  end

  def self.from_email_and_password email, password,
                                   client = ApiClient.new,
                                   factory = UsersFactory.new

    user_data = client.get_user_by_email_and_password(email, password)
    user_data ? new(factory.from_api_response(user_data)) : (raise AccessDeniedError)
  end

  def initialize(user)
    @user = user
  end

  attr_reader :user
end
