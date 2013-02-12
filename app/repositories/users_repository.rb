class UsersRepository
  attr_writer :collection, :factory_source

  def persist(model)
    attrs = { id: model.id, email: model.email, api_token: model.api_token,
              name: model.name }

    if collection.update(attrs) != 1
      collection.insert(attrs) == 1
    else
      true
    end
  end

  def find(id)
    factorize collection.first(id: id)
  end

  private

  def collection
    @collection ||= DB[:users]
  end

  def factorize(attrs)
    factory_source.call(attrs)
  end

  def factory_source
    @factory_source ||= UsersFactory.new.public_method :from_hash
  end
end
