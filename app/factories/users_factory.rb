class UsersFactory
  def from_api_response hash, users_source = User.public_method(:new)
    users_source.call.tap do |user|
      user.id = hash["id"]
      user.email = hash["email"]
      user.name = hash["name"]
      user.api_token = hash["token"]["guid"]
    end
  end
end
