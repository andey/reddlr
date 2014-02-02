class PostsController < ApplicationController
  def comments
    post = Post.find_by(reddit_id: params[:id])
    redirect_to 'http://reddit.com' + post.json['permalink']
  end
end
