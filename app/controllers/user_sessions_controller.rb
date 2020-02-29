class UserSessionsController < ApplicationController
  # skip_before_action(:force_user_sign_in, { :only => [:new_session_form, :create_cookie] })

   def homepage
    @user = User.all.order({:created_at => :desc})
    render({ :template => "users/index.html.erb" })
  end

  def user_details
    the_id = params.fetch("username")
    @user = User.where({:username => the_id}).at(0)
   
    render ({:template => "users/user_details.html.erb"})
  end
  
  def new_session_form
    render({ :template => "user_sessions/sign_in.html.erb" })
  end

  def create_cookie
    user = User.where({ :email => params.fetch("query_email") }).at(0)
    
    the_supplied_password = params.fetch("query_password")
    
    if user != nil
      are_they_legit = user.authenticate(the_supplied_password)
    
      if are_they_legit == false
        redirect_to("/user_sign_in", { :alert => "Incorrect password." })
      else
        session.store(:user_id, user.id)
      
        redirect_to("/", { :notice => "Signed in successfully." })
      end
    else
      redirect_to("/user_sign_in", { :alert => "No user with that email address." })
    end
  end

  def destroy_cookies
    reset_session

    redirect_to("/", { :notice => "Signed out successfully." })
  end
 
end
