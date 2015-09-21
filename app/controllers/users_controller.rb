class UsersController < ApplicationController
before_action :authenticate, only: [:edit, :update]
before_action :set_user, only: [:show, :edit, :update, :destroy]
 
def new
@user = User.new
end
 
 
def create
@user = User.new(user_params)
if @user.save
Notifier.registration_confirmation(@user).deliver
redirect_to root_url, notice: 'User successfully added.'
else
render action: 'new'
end
end

def confirm_email
    user = User.find_by_confirm_token(params[:id])
    if user
      user.email_activate
      flash[:success] = "Welcome to the Sample App! Your email has been confirmed.
      Please sign in to continue."
      redirect_to root_url
    else
      flash[:error] = "Sorry. User does not exist"
      redirect_to root_url
    end
end


# def create
#         @user = User.new(user_params)    
#       if @user.save
#         UserMailer.registration_confirmation(@user).deliver
#         flash[:success] = "Please confirm your email address to continue"
#         redirect_to root_url
#       else
#         flash[:error] = "Ooooppss, something went wrong!"
#         render 'new'
#       end
#   end


 
def edit
@user = current_user
end
 
def update
@user = current_user
if @user.update(user_params)
redirect_to articles_path, notice: 'Updated user information successfully.'
else
render action: 'edit'
end
end
 
private
def set_user
@user = current_user
end
 
def user_params
params.require(:user).permit(:email, :password, :password_confirmation)
end
end