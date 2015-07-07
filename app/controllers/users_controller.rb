class UsersController < ApplicationController

  def signup
    passhash = password_encryption(params[:password])
    user_params = { username: params[:username],
                    email: params[:email], 
                    password: passhash, 
                    first_name: params[:first_name],
                    last_name: params[:last_name],
                    avatar: params[:avatar] }
    @user = User.new(user_params)
    if @user.save
      render json: @user
    else 
      render json: { errors: @user.errors.full_messages },
      status: :unprocessable_entity
    end
  end

  def login
    passhash = password_encryption(params[:password])
    @user = User.find_by(username: params[:username], password: passhash)
    if @user
      render json: @user
    else 
      render json: { message: 'The username or password you supplied is incorrect.' },
        status: :unprocessable_entity
    end
  end

  def delete
    passhash = password_encryption(params[:password])
    if passhash == current_user.password
      current_user.destroy
      render json: { message: 'User has been deleted'},
        status: :ok
    else
      render json: { message: 'Password you supplied is not correct' }
    end
  end

  def show
    @user = current_user
    render json: @user
  end

  def update
    user_params = { email: params[:email], 
                    first_name: params[:first_name],
                    last_name: params[:last_name],
                    avatar: params[:avatar] }
    current_user.update(user_params)
    render json: @user
  end

  private
  def password_encryption(password)
    if !password.nil? && password != ""
      result = Digest::SHA1.hexdigest(password)
    else
      result = nil
    end
    result
  end

end