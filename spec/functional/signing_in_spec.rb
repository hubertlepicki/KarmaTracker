require_relative './functional_helper'
require_relative '../support/test_api_client'

describe 'Signing in (internal API) to tracker' do
  it 'should authorize user by valid token' do
    tracker = Tracker.from_token 'sample_token', TestApiClient.new
    tracker.user.id.should == 100
    tracker.user.email.should == 'hubert.lepicki@example.com'
  end

  it 'should not authorize user by invalid token' do
    ->() {
      tracker = Tracker.from_token 'invalid_token'
    }.should.raise(AccessDeniedError)
  end

  it 'should authorize user by email and password' do
    tracker = Tracker.from_email_and_password 'hubert.lepicki@example.com',
                                              'sample_password',
                                              TestApiClient.new
    tracker.user.id.should == 100
    tracker.user.email.should == 'hubert.lepicki@example.com'
  end

  it 'should not authorize user by invalid email and/or password' do
    ->() {
      tracker = Tracker.from_email_and_password 'invalid_email', 'invalid_password'
    }.should.raise(AccessDeniedError)
  end

  it 'should persist authorized user record in database' do
    tracker = Tracker.from_token 'sample_token', TestApiClient.new

    DB[:users].count.should == 1
  end
end

