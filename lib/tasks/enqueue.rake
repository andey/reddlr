require 'api/reddit'
task :enqueue => :environment do
  reddit = Reddit.new
  subreddit = Sub.enabled.order(:updated_at).first
  subreddit.touch()
  response = reddit.get_sub(subreddit.name)

  puts '------'
  puts 'Starting Enqueue'
  puts subreddit.name

  response["data"]["children"].each do |item|
    Post.create(title: item['data']['title'], reddit_id: item['data']['id'], sub_id: Sub.find_or_create_by(name: item['data']['subreddit']).id, json: item['data'])
  end
end