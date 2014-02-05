task :reset => :environment do
  puts '-------------'
  puts 'Reset Count'
  ApiKey.update_all(day_count: 0, reset_at: Time.now)
end