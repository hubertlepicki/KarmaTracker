#encoding: utf-8

def factorize(resource, custom_attributes = {})
  if resource == :user
    DB[:users].insert(
      id: 1,
      email: 'hubert.lepicki@example.com',
      api_token: 'sample_token',
      name: 'Hubert Łępicki'
    )
  end
end
