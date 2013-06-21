require 'open-uri'
require 'base64'
require 'json'

class TabController < ApplicationController
  FB_APP_ID = '542124329158664'
  FB_CLIENT_SECRET = 'a0cf5a76e83c806a73d86f29c039c1f4'
  CANCEL_PAGE = 'https://www.facebook.com/trendytamexico'
  FB_APP_PAGE = 'https://www.facebook.com/trendytamexico/app_542124329158664'
  FB_REDIRECT_URI = 'https://dev-machine.com:3000/tab/'
  def index
    puts "\nPARAMS"
    puts FB_APP_ID
    puts params
    if !params["error"].nil? && params["error"] == "access_denied"
      redirect_to CANCEL_PAGE
    else
      if session[:userDB].nil?
        if !params["code"].nil? && !params["code"].empty?
          redirectLogin params["code"]
          redirectPreferidos
        else
          signed_request = params[:signed_request]
          split_sr = signed_request.split(".")
          signature = Base64.decode64(split_sr[0])
          payload = Base64.decode64(split_sr[1])
          begin
            payload_obj = JSON.parse(payload)
          rescue JSON::ParserError
            begin
              payload_obj = JSON.parse(payload+'"}')
            rescue JSON::ParserError
              payload_obj = JSON.parse(payload+'}')
            end
          end

          puts "PAYLOAD: "
          puts payload_obj
          if payload_obj["user_id"].nil?
            puts "LOGIN REDIRECT"
            render 'login' , :layout => 'login'
          else
            puts "USERID:"
            puts payload_obj["user_id"]
            redirect_to '/preferidos'
          end
        end
      else
        redirect_to '/preferidos'
      end
    end
  end

  def redirectLogin code
    conn = open("https://graph.facebook.com/oauth/access_token?client_id=#{FB_APP_ID}&redirect_uri=#{FB_REDIRECT_URI}&client_secret=#{FB_CLIENT_SECRET}&code=#{code}")
    data = conn.read
    dataparsed = CGI::parse(data)
    accessToken = dataparsed["access_token"][0]
    session[:accessToken] = accessToken
    session[:remember_token] = accessToken
    cookies.permanent.signed[:remember_token] = accessToken

    conn2 = open("https://graph.facebook.com/me?fields=name,gender,birthday,first_name,last_name&access_token=#{accessToken}")
    data = conn2.read
    user = ActiveSupport::JSON.decode(data)
    session[:userFB] = user
  #render "preferidos"
  #redirect_to "https://www.facebook.com/trendytamexico/app_542124329158664"
  end

  def redirectPreferidos
    userFB = session[:userFB]
    user = User.find_by_fb_id(userFB["id"])
    if user.nil?
      user = User.new
      user.fb_id = userFB["id"]
      user.fb_name = userFB["name"]
      user.fb_gender = userFB["gender"]
      user.fb_birthday = userFB["birthday"]
      user.fb_token = session[:accessToken]
    user.save
    end
    session[:userDB] = user
    redirect_to FB_APP_PAGE
  end
  
  def app_redirect
    render 'redirect_app' , :layout => 'application'
  end
end
