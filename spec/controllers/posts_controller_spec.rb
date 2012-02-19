require 'spec_helper'

describe PostsController do
  context "not authenticated user" do
    it "should not allow user access'" do
      get :index
      should_deny_access

      get :new
      should_deny_access

      post :create, post: Factory.attributes_for(:post)
      should_deny_access

      get :edit, id: Factory(:post)
      should_deny_access

      postage = Factory(:post)
      put :update, id: postage, post: postage.attributes.merge(name: "new name")
      should_deny_access
    end

    private

    def should_deny_access
      response.should redirect_to new_user_session_path
      flash[:alert].should == "You need to sign in or sign up before continuing."
    end
  end

  context "authenticated user" do
    before :each do
      user = Factory(:user)
      sign_in :user, user
    end

    describe "GET 'index'" do
      before :each do
        Factory(:post)
        get :index
      end

      specify { response.should be_success }
      specify { assigns(:posts).count.should == 1 }
    end

    describe "GET 'new'" do
      before :each do
        get :new
      end

      specify { response.should be_success }
      specify { assigns(:post).should be_kind_of(Post) }
    end

    describe "Post 'create'" do
      it "should save post if valid" do
        Post.count.should == 0
        post :create, post: Factory.build(:post).attributes
        Post.count.should == 1

        flash[:notice].should == 'Post was successfully created.'
        response.should redirect_to post_path(assigns(:post))
      end

      it "should not save post if invalid" do
        Post.count.should == 0
        post :create, post: Factory.build(:post, title: "").attributes
        Post.count.should == 0

        response.should render_template :new
      end
    end

    describe "GET 'edit'" do
      before :each do
        @post = Factory(:post)
        get :edit, id: @post
      end

      specify { response.should be_success }
      specify { assigns(:post).should == @post }
    end

    describe "Put 'update'" do
      before :each do
        @post = Factory(:post)
      end

      it "should update post if valid" do
        put :update, id: @post, post: @post.attributes.merge(title: "new title")

        Post.find_by_id(@post).title.should == "new title"

        flash[:notice].should == 'Post was successfully updated.'
        response.should redirect_to post_path(assigns(:post))
      end

      it "should not update post if invalid" do
        put :update, id: @post, post: @post.attributes.merge(title: "")

        Post.find_by_id(@post).title.should == @post.title

        response.should render_template :edit
      end
    end

    describe "GET 'show'" do
      before :each do
        @post = Factory(:post)
        get :show, id: @post
      end

      specify { response.should be_success }
      specify { assigns(:post) == @post }
    end

    describe "Delete 'destroy'" do
      it "should destroy post" do
        post = Factory(:post)
        Post.count.should == 1
        delete :destroy, id: post
        Post.count.should == 0

        response.should redirect_to posts_path
      end
    end
  end
end
