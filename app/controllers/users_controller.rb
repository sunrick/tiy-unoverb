class UsersController < ApplicationController

  def signup
    user_params = { username: params[:username],
                    email: params[:email], 
                    password: params[:password], 
                    first_name: params[:first_name],
                    last_name: params[:last_name],
                    avatar: params[:avatar] }

    @user = User.create(user_params)
    render json: @user
  end

  def login

  end

  def delete
    
  end

  def show

  end

  def update

  end

end