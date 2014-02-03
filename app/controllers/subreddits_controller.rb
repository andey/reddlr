class SubredditsController < ApplicationController
  layout false

  def stylesheet
    sub = Sub.find_by(name: params[:id])
    render text: sub.css, content_type: 'text/css'
  end

  def javascript
    sub = Sub.find_by(name: params[:id])
    render js: sub.js
  end
end
