require 'api/reddit'
require 'open-uri'

task :submit => :environment do
  puts '-------------'
  puts 'Stating Submit'

  if post = Post.queue.first

    puts post.title
    puts post.url
    puts post.sub.tag_list.join(', ')
    api_key = ApiKey.where(enabled: true).order(:updated_at).first
    client = api_key.tumblr_client

    begin
      puts "Tumblr Type: #{post.content_type.tumblr_type_id}"
      case post.content_type.tumblr_type_id
        when 1
          puts "Post Hotlink"
          response = client.photo(post.tumblr_subdomain, {caption: post.post_title, tags: post.sub.tag_list, source: post.url})
          puts response
          post.update_attributes(tumblr_id: response['id'], response: response)
        when 2
          puts "Post Downloaded Photo"
          response = client.photo(post.tumblr_subdomain, {caption: post.post_title, tags: post.sub.tag_list, data: [open(post.url).path]})
          puts response
          post.update_attributes(tumblr_id: response['id'], response: response)
        else
          puts "Do something Special"
      end
    ensure
      api_key.update_attributes(day_count: api_key.day_count + 1, historical_count: api_key.historical_count + 1)
      post.touch(:submitted_at)
    end
  end
end