task :process => :environment do
  puts "Processing Posts"
  Post.where(processed_at: nil).each do |post|
    begin

      # PRINT OUT STUFF
      puts '----'
      puts post.title
      puts post.json['url']

    rescue
      puts 'SOMETHING WENT WRONG'
      puts post.id
    ensure
      post.update_attribute(:processed_at, Time.now)
    end
  end
end