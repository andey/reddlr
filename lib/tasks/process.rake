task :process => :environment do
  Post.where(content_type_id: nil, whitelist_id: nil, garbage: nil).each do |post|

    # IF IN WHITELIST
    if whitelist = Whitelist.find_by(domain: post.json['domain'])

      if whitelist.url_match
        regex = Regexp.new whitelist.url_match
        regex.match(post.json['url']) ? post.update_attribute(:whitelist_id, whitelist.id) : post.update_attribute(:garbage, false)
      else
        post.update_attribute(:garbage, false)
      end

    # IF SELF POST
    elsif post.json['is_self'] == 'true' || post.json['is_self'] == true
      post.update_attribute(:garbage, true)

    # SEE IF URL MATCHES CONTENT TYPE
    else

      content_type = nil
      ContentType.all.each do |ct|
        puts post.json['url']
        regex = Regexp.new ct.url_match
        content_type = regex.match(post.json['url']) ? ct : nil
      end

      if content_type
        post.update_attribute(:content_type_id, content_type.id)
      else
        post.update_attribute(:garbage, false)
      end

    end
  end
end

#response = HTTParty.get([post.json['url']])
#puts response.headers.inspect