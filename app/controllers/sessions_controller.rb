class SessionsController < ApplicationController
def create
if user = User.authenticate(params[:email], params[:password])
session[:user_id] = user.id
redirect_to root_path, :notice => "Logged in successfully"
else
flash.now[:alert] = "Invalid login/password combination"
render :action => 'new'
end
end
def destroy
reset_session
redirect_to root_path, :notice => "You successfully logged out"
end
end



# def create
#       user = User.find_by_email(params[:email].downcase)
#       if user && user.authenticate(params[:password])
#       if user.email_confirmed
#           sign_in user
#         redirect_back_or user
#       else
#         flash.now[:error] = 'Please activate your account by following the 
#         instructions in the account confirmation email you received to proceed'
#         render 'new'
#       end
#       else
#         flash.now[:error] = 'Invalid email/password combination' # Not quite right!
#         render 'new'
#       end
#   end