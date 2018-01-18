class UsersController < ApplicationController
  protect_from_forgery only: %i[create update destroy]
  before_action :find_user, only: %i[show edit update destroy]

  def index
    @users = User.all
    respond_to do |format|
      format.html
      format.json { render json: { message: 'Loaded users', users: @users }, status: :ok }
    end
  end

  def login
    @user = User.where(email: user_params[:email], password: user_params[:password]).first
    respond_to do |format|
      if @user
        session[:current_user_id] = @user.id
        session[:is_admin] = true if @user.name.eql?('admin')
        format.html { redirect_to items_path }
        format.json { render json: { message: 'Correct email or password' }, status: :ok }
      else
        format.html { redirect_to users_path, notice: 'Wrong email or password' }
        format.json { render json: { message: 'Wrong email or password' }, status: :unprocessable_entity }
      end
    end
  end

  def logout
    reset_session
    redirect_to root_path
  end

  def show
    respond_to do |format|
      format.html
      format.json { render json: { message: 'Loaded user', user: @user }, status: :ok }
    end
  end

  def new
    @user = User.new
  end

  def edit; end

  def create
    @user = User.create(user_params)
    respond_to do |format|
      if @user.save
        format.html { redirect_to @user, notice: 'User was successfully created.' }
        format.json { render json: { message: 'Created user', user: @user }, status: :ok }
      else
        format.html { render :new }
        format.json { render json: { message: @user.errors }, status: :unprocessable_entity }
      end
    end
  end

  def update
    respond_to do |format|
      if @user.update(user_params)
        format.html { redirect_to @user, notice: 'User was successfully updated.' }
        format.json { render json: { message: 'Updated user', user: @user }, status: :ok }
      else
        format.html { render :edit }
        format.json { render json: { message: @user.errors }, status: :unprocessable_entity }
      end
    end
  end

  def destroy
    respond_to do |format|
      @user.destroy
      format.html { redirect_to users_url, notice: 'User was successfully destroyed.' }
      format.json { render json: { message: 'Deleted user', user: nil }, status: :ok }
    end
  end

  private

  def find_user
    @user = User.find(params[:id])
  rescue ActiveRecord::RecordNotFound
    respond_to do |format|
      format.html { redirect_to users_path }
      format.json { render json: { message: 'Not found' }, status: :not_found }
    end
  end

  def user_params
    params.require(:user).permit(:name, :email, :password, :phone, :address)
  end
end
