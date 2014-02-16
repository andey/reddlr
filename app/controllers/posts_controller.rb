require 'paypal-sdk-rest'
include PayPal::SDK::REST

class PostsController < ApplicationController
  def comments
    post = Post.find_by(tummblr_id: params[:id])
    redirect_to post.source
  end

  def removal
    @post = Post.find_by(tumblr_id: params[:id])
  end

  def execute
    @post = Post.find_by(tumblr_id: params[:id])
    payment = Payment.find(session[:payment_id])
    if payment.execute(:payer_id => params[:PayerID])
      @post.remove
      redirect_to removal_post_path(@post.tumblr_id)
    else
      puts '-------------'
      puts 'PAYMENT ERROR'
      puts payment.error.inspect
      redirect_to removal_post_path(@post.tumblr_id), notice: 'Payment did not go through'
    end
  end

  def pay
    @post = Post.find_by(tumblr_id: params[:id])
    @payment = Payment.new(
        {
            :intent => "sale",
            :payer => {
                :payment_method => "paypal"
            },
            :redirect_urls => {
                :return_url => execute_post_url(@post.tumblr_id), #"http://8nsl.t.proxylocal.com/posts/#{@post.tumblr_id}/execute"
                :cancel_url => remove_post_url(@post.tumblr_id)
            },
            :transactions => [
                {
                    :item_list => {
                        :items => [
                            {
                                :name => "item",
                                :sku => "item",
                                :price => "1",
                                :currency => "USD",
                                :quantity => 1
                            }
                        ]
                    },
                    :amount => {
                        :total => "1.00",
                        :currency => "USD"
                    },
                    :description => "Remove Tumblr Post ##{@post.tumblr_id}"
                }
            ]
        }
    )
    if @payment.create
      session[:payment_id] = @payment.id
      payment = Payment.find(@payment.id)
      redirect_to payment.links[1].href
    else
      redirect_to removal_post_path(@post.tumblr_id), notice: 'Something went wrong!'
    end
  end
end
