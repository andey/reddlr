require 'api/reddit'
task :enqueue => :environment do
  reddit = Reddit.new
  response = reddit.get_sub(Sub.order(:updated_at).first.name)
  response["data"]["children"].each do |item|
    Post.create(title: item['data']['title'], reddit_id: item['data']['id'], sub_id: Sub.find_or_create_by(name: item['data']['subreddit']).id, json: item['data'])
  end
end