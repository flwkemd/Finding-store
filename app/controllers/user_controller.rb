class UserController < ApplicationController
  def login_form
    
  end

  def login
  end

  def logout
  end

  def new
  end

  def create
    _account = params[:account]
    _password = params[:password]
    _name = params[:name]
    
    if User.find_by(account: _account) != nil
      redirect_to :back
      return
    end
    
    user = User.new
    user.account = _account
    user.password = Digest::SHA256.hexdigest(_password)
    user.name = _name
    user.save
    
    redirect_to controller: 'post', action: 'list'
    
  end
end
