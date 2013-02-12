class TestApiClient < ApiClient

  private

  def get path, token_or_credentials
    filename = if token_or_credentials.is_a?(String)
      "spec/fixtures/api/#{token_or_credentials}/#{path}"
    else
      "spec/fixtures/api/#{token_or_credentials[:email]}/#{token_or_credentials[:password]}/#{path}"
    end

    File.exist?(filename) ? File.read(filename) : nil
  end
end

