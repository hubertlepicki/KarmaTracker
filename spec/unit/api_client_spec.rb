#encoding: utf-8

require_relative '../../app/models/api_client'
require_relative '../support/test_api_client'

describe ApiClient do
  before { @client = TestApiClient.new }

  it 'should be initiated with empty constructor' do
    ApiClient.new.should.be.instance_of?(ApiClient)
  end

  it 'should return user data when authorizing with token' do
    @client.get_user_by_token('sample_token').should == {
      "id" => 100,
      "email" => "hubert.lepicki@example.com",
      "name" => "Hubert Łępicki",
      "initials" => "HŁ",
      "token" => {
        "id" => 1,
        "guid" => "sample_token"
      }
    }
  end

  it 'should return nil when token is invalid' do
    @client.get_user_by_token('invalid_token').should.be.nil
  end

  it 'should return user data when authorizing with email and password' do
    @client.get_user_by_email_and_password('hubert.lepicki@example.com',
                                           'sample_password').should == {
      "id" => 100,
      "email" => "hubert.lepicki@example.com",
      "name" => "Hubert Łępicki",
      "initials" => "HŁ",
      "token" => {
        "id" => 1,
        "guid" => "sample_token"
      }
    }
  end
#
#  end
#  it 'should return nil when email or password is invalid'
end

