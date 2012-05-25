require 'spec_helper'
require File.dirname(__FILE__) + '/helpers/priority_control'

describe PostsController do
  include PriorityControl

  let(:postage) {Factory(:post)}

  context "not authenticated user" do
    it "should not allow user access'" do
      get :index
      should_deny_access

      get :new
      should_deny_access

      post :create, post: Factory.attributes_for(:post)
      should_deny_access

      get :edit, id: postage
      should_deny_access

      put :update, id: postage, post: postage.attributes.merge(name: "new name")
      should_deny_access

      delete :destroy, id: postage
      should_deny_access

      post :broadcast, id: postage
      should_deny_access

      get :search
      should_deny_access
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
        get :edit, id: postage
      end

      specify { response.should be_success }
      specify { assigns(:post).should == postage }
    end

    describe "Put 'update'" do

      it "should update post if valid" do
        put :update, id: postage, post: postage.attributes.merge(title: "new title")

        Post.find_by_id(postage).title.should == "new title"

        flash[:notice].should == 'Post was successfully updated.'
        response.should redirect_to post_path(assigns(:post))
      end

      it "should not update post if invalid" do
        put :update, id: postage, post: postage.attributes.merge(title: "")

        Post.find_by_id(postage).title.should == postage.title

        response.should render_template :edit
      end
    end

    describe "GET 'show'" do
      before :each do
        get :show, id: postage
      end

      specify { response.should be_success }
      specify { assigns(:post) == postage }
    end

    describe "Delete 'destroy'" do
      it "should destroy post" do
        postage = Factory(:post)
        Post.count.should == 1
        delete :destroy, id: postage
        Post.count.should == 0

        response.should redirect_to posts_path
      end
    end

    describe "Post 'broadcast'" do
      it "should send post as newsletter to followers" do
        mailer_obj = mock()
        NewsletterJob.should_receive(:new).with(postage).and_return(mailer_obj)
        Delayed::Job.should_receive(:enqueue).with(mailer_obj)

        post :broadcast, id: postage
        flash[:notice].should == 'Post is being emailed to subscribing customers.'
        response.should redirect_to post_path(postage)
      end
    end

    describe "GET 'search'" do
      it "should search posts" do
        page = '1'
        query = 'Half'

        search_collections = mock
        search_results = mock
        search_collections.should_receive(:results).and_return(search_results)
        Search::PostSearch.should_receive(:execute).with(query, page).and_return(search_collections)

        get :search, page: page, query: query

        assigns(:posts).should == search_results
      end
    end
  end
end
