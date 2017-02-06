class EntriesController < ApplicationController
  before_action :set_entry, only: [:show, :edit, :update, :destroy]
  # GET /entries
  # GET /entries.json

  #before_filter :activate_license
  def index
    @blogger = current_blogger
    #@entries = Entry.where("blogger_id=?",@blogger.id).latest
    puts "current blogger is----->"+@blogger.to_s+"email is---------------->"+@blogger.email.to_s

    @entries = Entry.all.paginate(:page=>params[:page],:per_page=>5)

    respond_to do |format|
      format.html # index.html.erb
      format.json { render json: @entries }
    end
  end

  # GET /entries/1
  # GET /entries/1.json
  def show
    @blogger = current_blogger
    @entry = Entry.find(params[:id])

    #这里开始使用will_paginate
    @comments_page = @entry.comments.paginate(:page=>params[:page],:per_page=>5)
    #@comments_page = Comment.paginate(:page=>params[:page],:per_page=>5)

    #Add this line
    @blogger_id = @blogger.id

    #Add previous direction
    @prev_direction = "entries"

    respond_to do |format|
      format.html # show.html.erb
      format.json { render json: @entry }
    end
  end

  # GET /entries/new
  # GET /entries/new.json
  def new
    @blogger = current_blogger
    @entry = Entry.new

    respond_to do |format|
      format.html # new.html.erb
      format.json { render json: @entry }
    end
  end

  # GET /entries/1/edit
  def edit
    @entry = Entry.find(params[:id])
    @blogger = current_blogger
    #这里设置简单的权限
    if @blogger.id!=@entry.blogger.id
        redirect_to entries_path, notice: '对不起，您没有这个权限'
    end
  end

  # POST /entries
  # POST /entries.json
  def create
    #@entry = Entry.new(params[:entry])
    @entry = Entry.new(entry_params)
    @blogger = current_blogger
    @entry.blogger_id = @blogger.id

    respond_to do |format|
      if @entry.save
        format.html { redirect_to @entry, notice: 'Entry was successfully created.' }
        format.json { render json: @entry, status: :created, location: @entry }
      else
        format.html { render action: "new" }
        format.json { render json: @entry.errors, status: :unprocessable_entity }
      end
    end
  end

  # PUT /entries/1
  # PUT /entries/1.json
  def update
    @blogger = current_blogger
    if(params[:id]==nil)
        puts "-----------------------------nil"
    else
        puts "id----------------------->"+params[:id].to_s
    end
    @entry = Entry.find(params[:id])

    respond_to do |format|
      if @entry.update_attributes(entry_params)
        format.html { redirect_to @entry, notice: 'Entry was successfully updated.' }
        format.json { head :no_content }
      else
        format.html { render action: "edit" }
        format.json { render json: @entry.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /entries/1
  # DELETE /entries/1.json
  def destroy
    @entry = Entry.find(params[:id])
    
    @blogger = current_blogger
    #这里设置简单的权限
    if @blogger.id!=@entry.blogger.id
        redirect_to entries_path, notice: '对不起，您没有这个权限'
    else
    	@entry.destroy

    	respond_to do |format|
    		format.html { redirect_to entries_url }
    		format.json { head :no_content }
    	end
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_entry
      @entry = Entry.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def entry_params
      params.require(:entry).permit(:title, :body, :public_flag, :point, :image)
    end

    #def advert_params
     # params.require(:entry).permit(:title,:body, :public_flag, :point, :image)
   # end
end
