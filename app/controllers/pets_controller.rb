class PetsController < ApplicationController

  get '/pets' do
    @pets = Pet.all
    erb :'/pets/index'
  end

  get '/pets/new' do
    erb :'/pets/new'
  end

  post '/pets' do
     @pet= Pet.create(params[:pet])
     if params[:pet][:owner_id]
       @pet.owner = Owner.find_by_id(params[:pet][:owner_id])
     end
     @pet.save
     if params[:owner][:name] != ""
       @pet.owner = Owner.create(name: params["owner"]["name"])
       @pet.save
     end
     redirect to "pets/#{@pet.id}"
   end

  get '/pets/:id' do
    @pet = Pet.find(params[:id])
    erb :'/pets/show'
  end

  get '/pets/:id/edit'
    @pet = Pet.find_by_id(params[:id])
    erb :'/pets/edit'

  patch '/pets/:id' do
    @pet = Pet.find_by_id(params[:id])
    @pet.update(params["pet"])
    @pet.owner = Owner.create(name: params["owner"]["name"]) if params["owner"]["name"] != ""
    @pet.save
    redirect to "pets/#{@pet.id}"
  end
end
