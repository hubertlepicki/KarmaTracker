class User
  attr_accessor :id, :email, :name, :api_token

  def initialize attrs = {}
    attrs.each do |k,v|
      send "#{k}=", v
    end
  end
end
