require 'rails_helper'

RSpec.describe "Cats", type: :request do
  describe "GET /index" do
    it 'gets a list of cats' do
      Cat.create name: 'Panini', age: 7, gender: 'Female', breed: 'striped shorthair', enjoys: 'leftover paninis'
      get '/cats'
      cat = JSON.parse(response.body)
      expect(response).to have_http_status(200)
      expect(cat.length).to eq 1
    end
  end

  describe "POST /create" do
    it 'creates a cat' do
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
    it 'updates a cat' do
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
    describe 'cat validation error codes' do
    it 'does not create a cat without a name' do
      cat_params = {
        cat:{
          age: 3,
          gender: 'Male',
          breed: 'alley cat',
          enjoys: 'Starting beef with everyone on his block'
          }
      }
      post '/cats', params: cat_params
      expect(response).to have_http_status(422)
      cat = JSON.parse(response.body)
      expect(cat['name']).to include "can't be blank"
    end

    it 'does not create a cat without an age' do
      cat_params = {
        cat:{
          name: 'Beef',
          gender: 'Male',
          breed: 'alley cat',
          enjoys: 'Starting beef with everyone on his block'
          }
      }
      post '/cats', params: cat_params
      expect(response).to have_http_status(422)
      cat = JSON.parse(response.body)
      expect(cat['age']).to include "can't be blank"
    end

    it 'does not create a cat without an gender' do
      cat_params = {
        cat:{
          name: 'Beef',
          age: 3,
          breed: 'alley cat',
          enjoys: 'Starting beef with everyone on his block'
          }
      }
      post '/cats', params: cat_params
      expect(response).to have_http_status(422)
      cat = JSON.parse(response.body)
      expect(cat['gender']).to include "can't be blank"
    end

    it 'does not create a cat without an breed' do
      cat_params = {
        cat:{
          name: 'Beef',
          age: 3,
          gender: 'Male',
          enjoys: 'Starting beef with everyone on his block'
          }
      }
      post '/cats', params: cat_params
      expect(response).to have_http_status(422)
      cat = JSON.parse(response.body)
      expect(cat['breed']).to include "can't be blank"
    end

    it 'does not create a cat without an enjoys' do
      cat_params = {
        cat:{
          name: 'Beef',
          age: 3,
          gender: 'Male',
          breed: 'alley cat'
          }
      }
      post '/cats', params: cat_params
      expect(response).to have_http_status(422)
      cat = JSON.parse(response.body)
      expect(cat['enjoys']).to include "can't be blank"
    end
  end
  describe 'cannot update a cat without valid attributes' do
    it 'cannot update a cat without a name' do
      cat_params = {
        cat: {
          name: 'Beef',
          age: 3,
          gender: 'Male',
          breed: 'alley cat',
          enjoys: 'Starting beef with everyone on his block'
        }
      }
      post '/cats', params: cat_params
      cat = Cat.first
      cat_params ={
        cat: {
          name: '',
          age: 4,
          gender: 'Male',
          breed: 'alley cat',
          enjoys: 'Starting beef with everyone on his block'
        }
      }
      patch "/cats/#{cat.id}", params: cat_params
      cat = JSON.parse(response.body)
      expect(response).to have_http_status(422)
      expect(cat['name']).to include "can't be blank"
    end

    it 'cannot update a cat without an age' do
      cat_params = {
        cat: {
          name: 'Beef',
          age: 3,
          gender: 'Male',
          breed: 'alley cat',
          enjoys: 'Starting beef with everyone on his block'
        }
      }
      post '/cats', params: cat_params
      cat = Cat.first
      cat_params ={
        cat: {
          name: 'Beef',
          age: '',
          gender: 'Male',
          breed: 'alley cat',
          enjoys: 'Starting beef with everyone on his block'
        }
      }
      patch "/cats/#{cat.id}", params: cat_params
      cat = JSON.parse(response.body)
      expect(response).to have_http_status(422)
      expect(cat['age']).to include "can't be blank"
    end

    it 'cannot update a cat without a gender' do
      cat_params = {
        cat: {
          name: 'Beef',
          age: 3,
          gender: 'Male',
          breed: 'alley cat',
          enjoys: 'Starting beef with everyone on his block'
        }
      }
      post '/cats', params: cat_params
      cat = Cat.first
      cat_params ={
        cat: {
          name: 'Beef',
          age: 4,
          gender: '',
          breed: 'alley cat',
          enjoys: 'Starting beef with everyone on his block'
        }
      }
      patch "/cats/#{cat.id}", params: cat_params
      cat = JSON.parse(response.body)
      expect(response).to have_http_status(422)
      expect(cat['gender']).to include "can't be blank"
    end

    it 'cannot update a cat without a breed' do
      cat_params = {
        cat: {
          name: 'Beef',
          age: 3,
          gender: 'Male',
          breed: 'alley cat',
          enjoys: 'Starting beef with everyone on his block'
        }
      }
      post '/cats', params: cat_params
      cat = Cat.first
      cat_params ={
        cat: {
          name: 'Beef',
          age: 4,
          gender: 'Male',
          breed: '',
          enjoys: 'Starting beef with everyone on his block'
        }
      }
      patch "/cats/#{cat.id}", params: cat_params
      cat = JSON.parse(response.body)
      expect(response).to have_http_status(422)
      expect(cat['breed']).to include "can't be blank"
    end

    it 'cannot update a cat without an enjoys' do
      cat_params = {
        cat: {
          name: 'Beef',
          age: 3,
          gender: 'Male',
          breed: 'alley cat',
          enjoys: 'Starting beef with everyone on his block'
        }
      }
      post '/cats', params: cat_params
      cat = Cat.first
      cat_params ={
        cat: {
          name: '',
          age: 4,
          gender: 'Male',
          breed: 'alley cat',
          enjoys: ''
        }
      }
      patch "/cats/#{cat.id}", params: cat_params
      cat = JSON.parse(response.body)
      expect(response).to have_http_status(422)
      expect(cat['enjoys']).to include "can't be blank"
    end
  end
end
