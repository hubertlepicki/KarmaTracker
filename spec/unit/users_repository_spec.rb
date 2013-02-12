require_relative '../../app/repositories/users_repository'
require 'facon'
require 'ostruct'

describe UsersRepository do
  before do
    @user_attrs = { id: 1, api_token: 'a', name: 'b', email: 'a@b.com'}
  end

  it 'should persist new User objects to database' do
    col = mock('Sequel::Postgres::Dataset')
    col.should_receive(:update).with(@user_attrs).and_return(0)
    col.should_receive(:insert).with(@user_attrs).and_return(1)

    repo = UsersRepository.new
    repo.collection = col

    repo.persist(OpenStruct.new(@user_attrs)).should.be.true
  end

  it 'should persist existing User objects' do
    col = mock('Sequel::Postgres::Dataset')
    col.should_receive(:update).with(@user_attrs).and_return(1)
    col.should_not_receive(:insert)

    repo = UsersRepository.new
    repo.collection = col

    repo.persist(OpenStruct.new(@user_attrs)).should.be.true
  end

  it 'should find user objects by id' do
    col = mock('Sequel::Postgres::Dataset')
    col.should_receive(:first).with(id: 1).and_return @user_attrs

    repo = UsersRepository.new
    repo.collection = col
    repo.factory_source = OpenStruct.public_method(:new)

    repo.find(1).should == OpenStruct.new(@user_attrs)
  end
end

