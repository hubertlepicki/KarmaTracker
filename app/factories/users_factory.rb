class UsersFactory
  def from_api_response hash, user_source = User.public_method(:new)
    user_source.call.tap do |user|
      user.id = hash["id"]
      user.email = hash["email"]
      user.name = hash["name"]
      user.api_token = hash["token"]["guid"]
    end
  end

  def from_hash hash, user_source = User.public_method(:new)
    user_source.call(hash)
  end
end

