# encoding: utf-8

require_relative '../../app/models/tracker'
require_relative '../../app/exceptions/access_denied_error'
require 'facon'
require 'nullobject'

describe Tracker do
  before do
    @api_response =  {
      "id" => 100,
      "email" => "hubert.lepicki@example.com",
      "name" => "Hubert Łępicki",
      "initials" => "HŁ",
      "token" => {
        "id" => 1,
        "guid" => "sample_token"
      }
    }

    @nullobject = Null::Object.instance
  end

  it 'should initiate tracker with user from token' do
    user = mock('User')

    client = mock('ApiClient')
    client.should_receive(:get_user_by_token).with('foo').and_return @api_response

    factory = mock('UsersFactory')
    factory.should_receive(:from_api_response).with(@api_response).and_return(user)

    tracker = Tracker.from_token 'foo', client, factory, @nullobject
    tracker.user.should == user
  end

  it 'should initiate tracker with user from email/password' do
    user = mock('User')

    client = mock('ApiClient')
    client.should_receive(:get_user_by_email_and_password).with('a@b.com', 'f').and_return @api_response

    factory = mock('UsersFactory')
    factory.should_receive(:from_api_response).with(@api_response).and_return(user)

    tracker = Tracker.from_email_and_password 'a@b.com', 'f', client, factory, @nullobject
    tracker.user.should == user

  end

  it 'should raise AccessDeniedError when cannot find user' do
    ->() {
      client = mock('ApiClient')
      client.should_receive(:get_user_by_email_and_password).with('a@b.com', 'f').and_return nil
      tracker = Tracker.from_email_and_password 'a@b.com', 'f', client, nil
    }.should.raise(AccessDeniedError)
  end
end
