class SubredditsController < ApplicationController

  def index
    @subs = Sub.all
  end

  def stylesheet
    sub = Sub.find_by(name: params[:id])
    render text: sub.css, content_type: 'text/css', layout: false
  end

  def javascript
    sub = Sub.find_by(name: params[:id])
    render js: sub.js, layout: false
  end
end
