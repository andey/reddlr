ActiveAdmin.register_page "Dashboard" do

  menu :priority => 1, :label => proc { I18n.t("active_admin.dashboard") }

  content :title => proc { I18n.t("active_admin.dashboard") } do
    columns do
      column do
        panel "Recent Posts" do
          table do
            tr do
              th nil
              th 'Total'
              th 'Today'
              th 'Yesterday'
              th 'Day Before'
            end
            tr do
              td 'Total Posts'
              td Post.count
              td Post.where('created_at > ?', Date.today).count
              td Post.where('created_at < ? and created_at > ?', Date.today, Date.today - 1.day).count
              td Post.where('created_at < ? and created_at > ?', Date.today - 1.day, Date.today - 2.day).count
            end
            tr do
              td 'Posts in Queue'
              td Post.queue.count
            end
            tr do
              td 'Successful Submits'
              td Post.where.not(tumblr_id: nil, submitted_at: nil).count
              td Post.where('submitted_at > ?', Date.today).where.not(tumblr_id: nil).count
              td Post.where('submitted_at < ? and submitted_at > ?', Date.today, Date.today - 1.day).where.not(tumblr_id: nil).count
              td Post.where('submitted_at < ? and submitted_at > ?', Date.today - 1.day, Date.today - 2.day).where.not(tumblr_id: nil).count
            end
            tr do
              td 'Failed Submits'
              td Post.where(tumblr_id: nil).where.not(submitted_at: nil).count
              td Post.where('submitted_at > ?', Date.today).where(tumblr_id: nil).count
              td Post.where('submitted_at < ? and submitted_at > ?', Date.today, Date.today - 1.day).where(tumblr_id: nil).count
              td Post.where('submitted_at < ? and submitted_at > ?', Date.today - 1.day, Date.today - 2.day).where(tumblr_id: nil).count
            end
            tr do
              td 'Garbage Posts'
              td Post.where(garbage: true).count
              td Post.where('created_at > ?', Date.today).where(garbage: true).count
              td Post.where('created_at < ? and created_at > ?', Date.today, Date.today - 1.day).where(garbage: true).count
              td Post.where('created_at < ? and created_at > ?', Date.today - 1.day, Date.today - 2.day).where(garbage: true).count
            end
          end
        end
      end
      column do
        panel "Subreddits" do
          table do
            tr do
              th nil
              th 'Total'
              th 'Today'
              th 'Yesterday'
              th '7 days'
            end
            Sub.all.each do |sub|
              tr do
                td sub.name
                td Post.where(sub_id: sub.id).count
                td Post.where('created_at > ?', Date.today).where(sub_id: sub.id).count
                td Post.where('created_at < ? and created_at > ?', Date.today, Date.today - 1.day).where(sub_id: sub.id).count
                td Post.where('created_at < ? and created_at > ?', Date.today, Date.today - 7.day).where(sub_id: sub.id).count
              end
            end
          end
        end
      end
    end
  end
end
