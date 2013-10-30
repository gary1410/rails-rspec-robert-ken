require 'spec_helper'

describe Admin::PostsController do
  describe "admin panel" do
    it "#index" do
      get :index
      response.status.should eq 200
    end

    it "#new" do
      get :new
      response.status.should eq 200
    end

    context "#create" do
      it "creates a post with valid params" do
        expect{
          post :create, post: {:title => "Hello", :content => "YOLO"}
        }.to change(Post,:count).by(1)
      end
      it "doesn't create a post when params are invalid" do
        expect{
          post :create, post: {:content => "YOLO"}
        }.to_not change(Post,:count)
      end
    end

    context "#update" do
      # let(:post) { Post.create(:title => "Nello", :content => "Chello") }
      before(:each) do
        @post = Post.create(:title => "Nello", :content => "Chello")
      end
      it "updates a post with valid params" do
        put :update, id: @post, post: {:title => "Hello", :content => "Fellow"}
        expect(@post.reload.title).to eq("Hello")
      end
      it "doesn't update a post when params are invalid" do
        put :update, id: @post, post: {:title => ""}
        expect(@post.reload.title).to eq("Nello")
      end
    end

    it "#destroy" do
       @post = Post.create(:title => "Ryan is Dabomb.com", :content => "Explains why he's dabomb.com")
      expect {
        delete :destroy, id: @post
      }.to change(Post, :count).by(-1)
    end
  end
end