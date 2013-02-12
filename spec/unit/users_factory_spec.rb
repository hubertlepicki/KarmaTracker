#encoding: utf-8
require_relative '../../app/factories/users_factory'
require 'ostruct'

describe UsersFactory do
  it 'should initiate user record from PT API generated hash' do
    user = UsersFactory.new.from_api_response({
      "id" => 100,
      "email" => "hubert.lepicki@example.com",
      "name" => "Hubert Łępicki",
      "initials" => "HŁ",
      "token" => {
        "id" => 1,
        "guid" => "sample_token"
      }
    }, OpenStruct.public_method(:new))

    user.id.should == 100
    user.email.should == 'hubert.lepicki@example.com'
    user.name.should == 'Hubert Łępicki'
    user.api_token.should == 'sample_token'
  end

  it 'should initiate user record from a hash of attributes' do
    user = UsersFactory.new.from_hash({
      id: 100,
      email: "hubert.lepicki@example.com",
      name: "Hubert Łępicki",
      api_token: "sample_token"
    }, OpenStruct.public_method(:new))

    user.id.should == 100
    user.email.should == 'hubert.lepicki@example.com'
    user.name.should == 'Hubert Łępicki'
    user.api_token.should == 'sample_token'
  end
end
