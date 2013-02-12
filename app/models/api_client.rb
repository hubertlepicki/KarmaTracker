require 'net/https'
require 'uri'
require 'nori'

class ApiClient
  def get_user_by_email_and_password email, password
    response = get "me", email: email, password: password
    xml = xml_to_hash(response)
    xml["person"] if xml
  end

  def get_user_by_token token
    response = get "me", token
    xml = xml_to_hash(response)
    xml["person"] if xml
  end


  private

  def get path, token_or_credentials
    uri = URI.parse("https://www.pivotaltracker.com/services/v4/#{path}")
    http = Net::HTTP.new(uri.host, uri.port)
    http.use_ssl = true
    http.verify_mode = OpenSSL::SSL::VERIFY_NONE

    request = Net::HTTP::Get.new(uri.request_uri)
    if token_or_credentials.is_a?(String)
      request['X-TrackerToken'] = token_or_credentials
    else
      request.basic_auth token_or_credentials[:email], token_or_credentials[:password]
    end

    response = http.request(request)
    response.code.to_i == 200 ? response.body : nil
  end

  def xml_to_hash xml, parser = Nori.new
    parser.parse(xml) if xml
  end
end

