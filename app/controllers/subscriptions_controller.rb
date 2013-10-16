class SubscriptionsController < ApplicationController

  def index
    @subscriptions = subscription_manager.list
  end

  def create
    subscription_manager.add_url params[:url]
    flash[:notice] = "Subscription added."
    redirect_to subscriptions_url
  rescue PullRequestHtmlUrl::ParsingError
    flash[:alert] = "Cannot add pull request: URL is invalid."
    redirect_to subscriptions_url
  rescue SubscriptionManager::AlreadySubscribed
    flash[:alert] = "Cannot add pull request: you have already subscribed!"
    redirect_to subscriptions_url
  end

  def destroy
    subscription_manager.remove_id params[:id]
    flash[:notice] = "Subscription removed."
    redirect_to subscriptions_url
  end

  private

  def subscription_manager
    SubscriptionManager.new(current_user)
  end

end
