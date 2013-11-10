#== Reddit.com API library

class Reddit
  include HTTParty
  base_uri 'www.reddit.com'

  def get(path)
    options = {:format => 'json', :headers => {'User-Agent' => 'reddlr.com / andey@reddit.com'}}
    response = self.class.get(path, options)
    return response.code == 200 ? JSON.parse(response.body) : nil
  end

  def get_sub(sub)
    return Rails.env == 'test' ? nil : get("/r/#{sub}.json")
  end
end