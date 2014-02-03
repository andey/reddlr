require 'api/reddit'
require 'open-uri'

task :submit => :environment do
  puts '-------------'
  puts 'Stating Submit'

  if post = Post.queue.first

    puts post.title
    puts post.url
    puts post.sub.tag_list.join(', ')
    client = ApiKey.find(2).tumblr_client

    begin
      puts "Tumblr Type: #{post.content_type.tumblr_type_id}"
      case post.content_type.tumblr_type_id
        when 1
          puts "Post Hotlink"
          response = client.photo(post.tumblr_subdomain, {caption: post.post_title, tags: post.sub.tag_list, source: post.url})
          post.update_attributes(tumblr_id: response['id'])
        when 2
          puts "Post Downloaded Photo"
          response = client.photo(post.tumblr_subdomain, {caption: post.post_title, tags: post.sub.tag_list, data: [open(post.url).path]})
          post.update_attributes(tumblr_id: response['id'])
        else
          puts "Do something Special"
      end
    ensure
      post.touch(:submitted_at)
    end
  end
end