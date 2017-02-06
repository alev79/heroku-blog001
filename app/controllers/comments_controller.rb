class CommentsController < ApplicationController
   skip_before_filter :verify_authenticity_token, :only=>[:create]
   def new
   end

   def create
	entry = Entry.find params[:entry_id]
        #@created_comment = entry.comments.create params[:comment]
        @created_comment = entry.comments.create comment_params
        if (@created_comment)
	    #@comment = Comment.find :last
            @comment = Comment.last
   	    @comment = @created_comment
 	end

        #render :update do |page|
	#	page.insert_html :top,"comment_list",:partial=>"comment_list"
	#	page.visual_effect  :highlight,"comment_list",:duration=>1
	#end

        @blogger = Blogger.find(params[:blogger_id])
        @entry = Entry.find(params[:entry_id])

   end

   private 
   def comment_params
        params.require(:comment).permit(:body,:name,:title)
   end
end
