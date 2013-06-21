require 'open-uri'
require 'base64'
require 'json'

class TabController < ApplicationController
  def index
    redirect_to "/preferidos"
=begin
    if !session[:userFB].nil?
      puts "USER IN SESSION"
      redirectPreferidos
    else
      puts "USER NOT IN SESSION"
      code = params[:code]
      if code.nil?
        puts "CODE NIL"
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

        if payload_obj["oauth_token"].nil?
          puts "OAUTH EMPTY"
          redirect_to "https://www.facebook.com/dialog/oauth?client_id=542124329158664&redirect_uri=https://dev-machine.com:3000/tab/"
        else

          conn2 = open("https://graph.facebook.com/me?fields=name,gender,birthday,first_name,last_name&oauth_token=#{payload_obj["oauth_token"]}")
          data = conn2.read
          user = ActiveSupport::JSON.decode(data)
          session[:accessToken] = payload_obj["oauth_token"]
          session[:userFB] = user
          redirectPreferidos
        end
      else
        puts "CODE IN PARAMS"
        redirectLogin
      end
    end
=end
  end

  def redirectLogin
    conn = open("https://graph.facebook.com/oauth/access_token?client_id=542124329158664&redirect_uri=https://dev-machine.com:3000/tab/&client_secret=a0cf5a76e83c806a73d86f29c039c1f4&code=#{code}")
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
    redirect_to "https://www.facebook.com/trendytamexico/app_542124329158664"
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
    redirect_to "/preferidos"
  end
end
