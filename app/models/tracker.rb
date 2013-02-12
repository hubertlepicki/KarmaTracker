class Tracker
  def self.from_token token, client = ApiClient.new,
                             factory = UsersFactory.new,
                             users_repo = UsersRepository.new

    new setup_user(client.get_user_by_token(token), factory, users_repo)
  end

  def self.from_email_and_password email, password,
                                   client = ApiClient.new,
                                   factory = UsersFactory.new,
                                   users_repo = UsersRepository.new


    new setup_user(client.get_user_by_email_and_password(email, password), factory, users_repo)
  end

  def self.setup_user(user_data, factory, users_repo)
    user = user_data ? factory.from_api_response(user_data) : (raise AccessDeniedError)
    user.tap { users_repo.persist user }
  end

  def self.from_id(id, users_repo = UsersRepository.new)
    new users_repo.find(id)
  end

  def initialize(user)
    @user = user
  end

  attr_reader :user
end
