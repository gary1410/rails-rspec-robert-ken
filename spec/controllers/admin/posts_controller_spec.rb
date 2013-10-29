require 'spec_helper'

describe Admin::PostsController do
  describe "admin panel" do
    it "#index" do
      get :index
      expect(assigns(:posts)).to eq(Post.all)
      response.status.should eq 200
    end

    it "#new" do
      get :index
      response.status.should eq 200
    end

    context "#create" do
      it "creates a post with valid params" do
        expect {
          post :create, {:post => {:title => "Test Post", :content => "Test post content."}}
        }.to change(Post, :count).by(1)

      end
      it "doesn't create a post when params are invalid" do
         expect {
          post :create, {:post => {}}
        }.to_not change(Post, :count)

      end
    end

    context "#edit" do
      it "updates a post with valid params" do
        pending
      end
      it "doesn't update a post when params are invalid" do
        pending
      end
    end

    it "#destroy" do
      pending
    end
  end
end
