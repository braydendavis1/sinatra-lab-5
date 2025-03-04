class UsersController < ApplicationController
    get '/users/new' do
        email = session[:sign_up_email] || ""
        session[:sign_up_email] = nil
        erb :"users/new.html", locals: {email: email}
    end

    post '/users' do
        user = User.new(email: params[:email], password: params[:password], password_confirmation: params[:password_confirmation])
        session[:sign_up_email] = nil
        if user.save
            session[:sign_up_email] = params[:email]
            flash[:notice] = "Thanks for signing up! You may now log in!"
            redirect "/sessions/new"
        else
            @email = params[:email]
            flash.now[:errors] = user.errors.full_messages.join("; ")
            erb :"users/new.html"
        end
    end
end