require 'rails_helper'

RSpec.describe SponsoredPostsController, type: :controller do
  let(:my_topic) { Topic.create!(name: RandomData.random_sentence, description: RandomData.random_paragraph) }
  let(:my_sponsoredPost) { my_topic.sponsoredPosts.create!(title: RandomData.random_sentence, body: RandomData.random_paragraph, price: RandomData.random_number) }

  describe 'GET #show' do
    it 'returns http success' do
      get :show, topic_id: my_topic.id, id: my_sponsoredPost.id
      expect(response).to have_http_status(:success)
    end

    it 'renders the #show view' do
      get :show, topic_id: my_topic.id, id: my_sponsoredPost.id
      expect(response).to render_template :show
    end

    it 'assigns my_sponsoredPost to @sponsoredPost' do
      get :show, topic_id: my_topic.id, id: my_sponsoredPost.id
      expect(assigns(:sponsoredPost)).to eq(my_sponsoredPost)
    end
  end

  describe 'GET new' do
    it 'returns http success' do
      get :new, topic_id: my_topic.id
      expect(response).to have_http_status(:success)
    end

    it 'renders the #new view' do
      get :new, topic_id: my_topic.id
      expect(response).to render_template :new
    end

    it 'instantiates @sponsoredPost' do
      get :new, topic_id: my_topic.id
      expect(assigns(:sponsoredPost)).not_to be_nil
    end
  end

  describe 'POST create' do
    it 'increases the number of SponsoredPost by 1' do
      expect { post :create, topic_id: my_topic.id, sponsored_post: { title: RandomData.random_sentence, body: RandomData.random_paragraph, price: RandomData.random_number } }.to change(SponsoredPost, :count).by(1)
    end

    it 'assigns the new sponsoredPost to @sponsoredPost' do
      post :create, topic_id: my_topic.id, sponsored_post: { title: RandomData.random_sentence, body: RandomData.random_paragraph, price: RandomData.random_number }
      expect(assigns(:sponsoredPost)).to eq SponsoredPost.last
    end

    it 'redirects to the new sponsoredPost' do
      post :create, topic_id: my_topic.id, sponsored_post: { title: RandomData.random_sentence, body: RandomData.random_paragraph, price: RandomData.random_number }
      expect(response).to redirect_to [my_topic, SponsoredPost.last]
    end
  end

  describe 'GET edit' do
    it 'returns http success' do
      get :edit, topic_id: my_topic.id, id: my_sponsoredPost.id
      expect(response).to have_http_status(:success)
    end

    it 'renders the #edit view' do
      get :edit, topic_id: my_topic.id, id: my_sponsoredPost.id
      expect(response).to render_template :edit
    end

    it 'assigns sponsoredPost to be updated to @sponsoredPost' do
      get :edit, topic_id: my_topic.id, id: my_sponsoredPost.id

      sponsoredPost_instance = assigns(:sponsoredPost)

      expect(sponsoredPost_instance.id).to eq my_sponsoredPost.id
      expect(sponsoredPost_instance.title).to eq my_sponsoredPost.title
      expect(sponsoredPost_instance.body).to eq my_sponsoredPost.body
    end
  end

  describe 'PUT update' do
    it 'updates sponsored post with expected attributes' do
      new_title = RandomData.random_sentence
      new_body = RandomData.random_paragraph
      new_price = RandomData.random_number

      put :update, topic_id: my_topic.id, id: my_sponsoredPost.id, sponsored_post: { title: new_title, body: new_body, price: new_price }

      updated_sponsoredPost = assigns(:sponsoredPost)
      expect(updated_sponsoredPost.id).to eq my_sponsoredPost.id
      expect(updated_sponsoredPost.title).to eq new_title
      expect(updated_sponsoredPost.body).to eq new_body
      expect(updated_sponsoredPost.price).to eq new_price
    end

    it 'redirects to the updated sponsored post' do
      new_title = RandomData.random_sentence
      new_body = RandomData.random_paragraph
      new_price = RandomData.random_number

      put :update, topic_id: my_topic.id, id: my_sponsoredPost.id, sponsored_post: { title: new_title, body: new_body, price: new_price }
      expect(response).to redirect_to [my_topic, my_sponsoredPost]
    end
  end

  describe 'DELETE destroy' do
    it 'deletes the post' do
      delete :destroy, topic_id: my_topic.id, id: my_sponsoredPost.id
      count = SponsoredPost.where(id: my_sponsoredPost.id).size
      expect(count).to eq 0
    end

    it 'redirects to topic show' do
      delete :destroy, topic_id: my_topic.id, id: my_sponsoredPost.id
      expect(response).to redirect_to my_topic
    end
  end
end
