class FeedsController < ApplicationController
  before_action :set_feed, only: [:show, :edit, :update, :destroy]
  before_action :logged_in?

  def index
    @feeds = Feed.all
  end

  def show
  end

  def new
    if params[:back]
      @feed = Feed.new(feed_params)
    else
      @feed = Feed.new
    end
  end
  def confirm
    @feed = Feed.new(feed_params)
    @feed.user_id = current_user.id
    render :new if @feed.invalid?
  end

  def create
    @feed = Feed.new(feed_params)
    @feed.user_id = current_user.id
    if params[:back]
      render :new
    else
    if @feed.save
    redirect_to feeds_path, notice: "The photo has been posted!"
      else
    render :new
    end
  end
end

  def update
    if @feed.update(feed_params)
      redirect_to feeds_path, notice: "I edited the blog!"
    else
      render :edit
    end
  end

  def destroy
    @feed.destroy
    redirect_to feeds_path, notice: "I deleted the blog!"
  end

  private
    def set_feed
      @feed = Feed.find(params[:id])
    end

    def feed_params
      params.require(:feed).permit(:image, :image_cache, :user_id, :content)
    end
end
