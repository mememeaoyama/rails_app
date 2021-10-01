class TweetsController < ApplicationController

  before_action :authenticate_user!, only: [:new, :create]

  def index
    if params[:search] == nil
    @tweets = Tweet.all
  elsif params[:search] == ''
    @tweets= Tweet.all
  else
    @tweets = Tweet.where("body LIKE ? ",'%' + params[:search] + '%')
  end
  @tweets = @tweets.page(params[:page]).per(3)
  end

  def new
    @tweet = Tweet.new
  end

  def create
    tweet = Tweet.new(tweet_params)
    tweet.user_id = current_user.id

    url = params[:tweet][:youtube_url]
    url = url.last(11)
    @tweet.youtube_url = url

    respond_to do |format|
      if @tweet.save
        format.html { redirect_to @tweet, notice: 'Post was successfully created.' }
        format.json { render :show, status: :created, location: @tweet }
      else
        format.html { render :new }
        format.json { render json: @tweet.errors, status: :unprocessable_entity }
      end
    end

    if tweet.save
      redirect_to :action => "index"
    else
      redirect_to :action => "new"
    end


  end

  def show
    @tweet = Tweet.find(params[:id])
    @comments = @tweet.comments
        @comment = Comment.new
  end

  def edit
    @tweet = Tweet.find(params[:id])
  end

  def update
    tweet = Tweet.find(params[:id])
    if tweet.update(tweet_params)
      redirect_to :action => "show", :id => tweet.id
    else
      redirect_to :action => "new"
    end
  end

  def destroy
    tweet = Tweet.find(params[:id])
    tweet.destroy
    redirect_to action: :index
  end

  private
  def tweet_params
    params.require(:tweet).permit(:username, :body, :perform, :level_difficult, :level_popular, :youtube_url)
  
  end

  
end
