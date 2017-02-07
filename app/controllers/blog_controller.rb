class BlogController < ApplicationController
  def index
     begin
       @blogger = Blogger.find(params[:id])
       @current_user_email = @blogger.email
       #@entries = Entry.where("blogger_id=?",@blogger.id).public_entries.latest
       @entries = Entry.where("blogger_id=?",@blogger.id)
     rescue ActiveRecord::RecordNotFound=>e
     
     end
  end

  def show
      @blogger = Blogger.find(params[:id])
      @entry = Entry.find(params[:entry_id])

      #add this line to the following:
      @blogger_id = params[:id]

      #add previous direction
      @prev_direction = "blog"

      #这里开始使用will_paginate
      @comments_page = @entry.comments.paginate(:page=>params[:page],:per_page=>5)
      #@comments_page = Comment.paginate(:page=>params[:page],:per_page=>5)

      respond_to do |format|
         format.html
         format.xml { render :xml=> @entry}
      end
  end
end
