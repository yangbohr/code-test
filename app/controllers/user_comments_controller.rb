class UserCommentsController < ApplicationController
  before_action :set_user_comment, only: [:show, :edit, :update, :destroy]

  # GET /user_comments
  # GET /user_comments.json
  def index
    @user_comments = UserComment.where(include_keyword: true).order("score DESC")
    @percent = UserComment.where(include_keyword: true).count.to_f/UserComment.all.count.to_f
  end

  # GET /user_comments/1
  # GET /user_comments/1.json
  def show
  end

  def fetch_comments
    begin
      UserComment.fetch_comments(UserComment::URL)
    rescue => e
      puts e
      notice = 'Sorry Please Try Again'
    end
    redirect_to user_comments_path, notice: notice
  end

  def delete_all
    UserComment.delete_all
    redirect_to user_comments_path
  end

  # GET /user_comments/new
  def new
    @user_comment = UserComment.new
  end

  # GET /user_comments/1/edit
  def edit
  end

  # POST /user_comments
  # POST /user_comments.json
  def create
    @user_comment = UserComment.new(user_comment_params)

    respond_to do |format|
      if @user_comment.save
        format.html { redirect_to @user_comment, notice: 'User comment was successfully created.' }
        format.json { render action: 'show', status: :created, location: @user_comment }
      else
        format.html { render action: 'new' }
        format.json { render json: @user_comment.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /user_comments/1
  # PATCH/PUT /user_comments/1.json
  def update
    respond_to do |format|
      if @user_comment.update(user_comment_params)
        format.html { redirect_to @user_comment, notice: 'User comment was successfully updated.' }
        format.json { head :no_content }
      else
        format.html { render action: 'edit' }
        format.json { render json: @user_comment.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /user_comments/1
  # DELETE /user_comments/1.json
  def destroy
    @user_comment.destroy
    respond_to do |format|
      format.html { redirect_to user_comments_url }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_user_comment
      @user_comment = UserComment.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def user_comment_params
      params.require(:user_comment).permit(:handle, :user_id, :creation_time, :score, :follower)
    end
end
