#encoding: utf-8
require_relative '../../app/models/user'

describe User do
  it 'should have getters and setters for id, email, name and api_token' do
    user = User.new.tap do |u|
      u.id = 100
      u.email = 'hubert.lepicki@example.com'
      u.name = 'Hubert Łępicki'
      u.api_token = 'sample_token'
    end
    user.id.should == 100
    user.email.should == 'hubert.lepicki@example.com'
    user.name.should == 'Hubert Łępicki'
    user.api_token.should == 'sample_token'
  end

  it 'should have a constructor that sets attributes' do
    user = User.new(id: 100, email: 'hubert.lepicki@example.com',
                    name: 'Hubert Łępicki', api_token: 'sample_token')
    user.id.should == 100
    user.email.should == 'hubert.lepicki@example.com'
    user.name.should == 'Hubert Łępicki'
    user.api_token.should == 'sample_token'
  end
end
