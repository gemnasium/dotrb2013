require 'spec_helper'

describe SubscriptionsController do

  describe "GET #index" do
    it "responds successfully"
    it "loads @subscriptions"
    it "renders the index template"
  end

  describe "POST #create" do
    it "adds subscription for given pull request URL"
    it "redirects to index"
  end

  describe "DELETE #destroy" do
    it "removes subscription for given model id"
    it "redirects to index"
  end

end
