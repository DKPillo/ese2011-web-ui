def relative(path)
  File.join(File.expand_path(File.dirname(__FILE__)), path)
end
require 'rubygems'
require 'require_relative'
require 'sinatra/base'
require 'haml'
require 'sinatra/content_for'
require_relative('../models/module/user')

include Models

module Controllers
  class Creator < Sinatra::Base
    set :views, relative('../../app/views')
    helpers Sinatra::ContentFor

    post '/create' do
      if session['auth']
        user = session['user']
        User.get_user(user).create_item(params[:name], params[:price])
        redirect "/home/inactive"
      else
        redirect "/"
      end
    end

    get '/changestate/:id/setactive' do
      if session['auth']
        user = session['user']
        id = params[:id]
        User.get_user(user).get_item_by_id(id)[0].to_active
        redirect "/home/inactive"
      else
        redirect "/"
      end
    end

    get '/changestate/:id/setinactive' do
      if session['auth']
        user = session['user']
        id = params[:id]
        User.get_user(user).get_item_by_id(id)[0].to_inactive
        redirect "/home/active"
      else
        redirect "/"
      end
    end

  end
end