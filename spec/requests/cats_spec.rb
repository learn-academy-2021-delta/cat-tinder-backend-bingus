require 'rails_helper'

RSpec.describe "Cats", type: :request do
  describe "GET /index" do
    it "gets a list of cats" do
      Cat.create name: 'Panini', age: 7, gender: 'Female', breed: 'striped shorthair', enjoys: 'leftover paninis'
      get '/cats'
      cat = JSON.parse(response.body)
      expect(response).to have_http_status(200)
      expect(cat.length).to eq 1
    end
  end

  describe "POST /create" do
    it "creates a cat" do
      cat_params = {
        cat: {
          name: 'Panini',
          age: 7,
          gender: 'Female',
          breed: 'striped shorthair',
          enjoys: 'leftover paninis'
        }
      }

      post '/cats', params: cat_params
      expect(response).to have_http_status(200)

      cat = Cat.first
      expect(cat.name).to eq 'Panini'
      expect(cat.age).to eq 7
      expect(cat.gender).to eq 'Female'
      expect(cat.breed).to eq 'striped shorthair'
      expect(cat.enjoys).to eq 'leftover paninis'
    end
  end

  describe "PATCH /update" do
    it "updates a cat" do
      cat_params = {
        cat: {
          name: 'Snuggle Beans',
          age: 1.5,
          gender: 'Male',
          breed: 'Ragdoll',
          enjoys: 'rubbing up against anything with a pulse'
        }
      }

      post '/cats', params: cat_params
      cat = Cat.first

      updated_cat_params = {
        cat: {
          name: 'Snuggle Beans',
          age: 2,
          gender: 'Male',
          breed: 'Ragdoll',
          enjoys: 'rubbing up against anything with a pulse'
        }
      }

      patch "/cats/#{cat.id}", params: updated_cat_params
      cat = Cat.first

      expect(response).to have_http_status(200)
      expect(cat.age).to eq 2
    end
  end

  describe "DELETE /destroy" do
    it 'deletes a cat' do
      cat_params = {
        cat:{
        name: 'Beef',
        age: 3,
        gender: 'Male',
        breed: 'alley cat',
        enjoys: 'Starting beef with everyone on his block'
        }
      }
      post '/cats', params: cat_params
      cat = Cat.first
      delete "/cats/#{cat.id}"
      expect(response).to have_http_status(200)
      cats = Cat.all
      expect(cats).to be_empty
    end
  end
end
