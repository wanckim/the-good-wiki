require 'rails_helper'

RSpec.describe WikisController, type: :controller do
  let(:my_user) {User.create!(email: "blochead@bloc.io", password: "password", password_confirmation: "password")}
  let(:my_wiki) {Wiki.create!(title:"New Wiki Title", body:"New Wiki Body For The Good Wiki", private:false, user: my_user)}

  describe "GET show" do
    it "returns http success" do
      get :show, params: {id: my_wiki.id}
      expect(response).to have_http_status(:success)
    end

    it "renders the #show view" do
      get :show, params: {id: my_wiki.id}
      expect(response).to render_template(:show)
    end

    it "assigns my_wiki to @wiki" do
      get :show, params: {id: my_wiki.id}
      expect(assigns(:wiki)).to eq(my_wiki)
    end
  end

  describe "GET new" do
    it "returns http success" do
      get :new
      expect(response).to have_http_status(:success)
    end

    it "renders the #new view" do
      get :new
      expect(response).to render_template(:new)
    end

    it "instantiates @wiki" do
      get :new
      expect(assigns(:wiki)).not_to be_nil
    end
  end

  describe "GET edit" do
    it "returns http success" do
      get :edit, params: {id: my_wiki.id}
      expect(response).to have_http_status(:success)
    end

    it "renders the #edit view" do
      get :edit, params: {id: my_wiki.id}
      expect(response).to render_template(:edit)
    end

    it "assigns wiki to be updated @wiki" do
      get :edit, params: {id: my_wiki.id}

      wiki_instance = assigns(:wiki)

      expect(wiki_instance.id).to eq(my_wiki.id)
      expect(wiki_instance.title).to eq(my_wiki.title)
      expect(wiki_instance.body).to eq(my_wiki.body)
    end
  end

end
