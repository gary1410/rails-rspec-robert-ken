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

    context "#update" do
      let!(:new_post) { Post.create({:title => "old title", :content => "old content"})}

      it "updates a post with valid params" do
        expect {
          put :update, :id => new_post.id, post: {:title => "new title"}
        }.to change {Post.last.title}.to eq("New Title")
      end
      it "doesn't update a post when params are invalid" do
        expect {
          put :update, :id => new_post.id, post: {}
        }.to_not change {Post.last.title}.to eq("Old Title")
      end
    end

    let!(:favorite_post) { Post.create({:title => "old title", :content => "old content"})}
    it "#destroy" do

      expect {
        delete :destroy, :id => favorite_post.id #why do we need to have :id...?
      }.to change(Post, :count).by(-1)
    end
  end
end
