BASE_URL = "https://api.twitter.com/1.1/statuses/update.json"
CONSUMER_KEY = "remember to entet tokens"
CONSUMER_SECRET = "remember to entet tokens"

module OAuthClient


  def post(tweet)
    # create the HTTP post request
    uri = URI(BASE_URL)
    request = Net::HTTP::Post.new(uri)
    #hint - this request is going to need some form data (aka your tweet)
    request.set_form_data(tweet)
    # set the Authorization Header using the oauth helper
    request["Authorization"] = oauth_header(request)

    # connect to the server and send the request
    response = Net::HTTP.start(uri.hostname, uri.port, use_ssl:(uri.scheme == "https")) do |http|
      http.request(request)
    end

    return response
  end

  private
  def user_token
    self.token
  end

  def user_secret
    self.token_secret
  end

  def credentials
    @credentials ||= {consumer_key: CONSUMER_KEY,
                      consumer_secret: CONSUMER_SECRET,
                      token: user_token,
                      token_secret: user_secret}
  end
  # A helper method to generate the OAuth Authorization header given
  # an Net::HTTP::GenericRequest object and a Hash of params
  def oauth_header(request)
    SimpleOAuth::Header.new(request.method, request.uri, URI.decode_www_form(request.body), credentials).to_s
  end
end

# client.post("https://api.twitter.com/1.1/statuses/update.json").body
