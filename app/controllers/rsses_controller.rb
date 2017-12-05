class RssesController < ApplicationController
	before_action :all_rss
  before_action :set_rss, only: [:edit, :update, :destroy]
  respond_to :html, :js

  def new
    @rss = Rss.new
  end

  def create
    @rss  = Rss.create(rss_params)
    FeedWorker.perform_async(@rss.id)
  end

  def update
    @rss.update_attributes(rss_params)
    FeedWorker.perform_async(@rss.id)
  end

  def destroy
    @rss.destroy
  end

  def feeds
    @feeds = Feed.all.sort_by(&:published_at).reverse!
  end

  private

  def all_rss
    @all_rss = Rss.all
  end

  def set_rss
    @rss = Rss.find(params[:id])
  end

  def rss_params
    params.require(:rss).permit(:rss_url)
  end
end
