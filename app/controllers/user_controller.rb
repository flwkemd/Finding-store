class UserController < ApplicationController
  
  skip_before_filter :require_login, :only => [:login_form, :login, :new, :create, :verify, :forgot, :forgot_form, :forgot_change, :forgot_confirm]
  
  def login_form
    
  end

  def login
    _account = params[:account]
    _password = params[:password]
    
    user = User.find_by(account: _account)
    
    if user == nil
      flash[:error] = '존재하지 않는 계정입니다.'
      # flash[:warning] = '존재하지 않는 계정입니다.'
      redirect_to :back
      return
    end
    
    if user.password == Digest::SHA256.hexdigest(_password)
      if user.is_verified == false
        flash[:error] = "이메일 인증을 완료해주세요."
        redirect_to :back
        return
      end
      ## success
      session[:logined] = true
      session[:user] = user
      redirect_to controller: 'post', action: 'list'
    else
      ## failure
      redirect_to :back
    
    end
  end

  def logout
    reset_session
    
    redirect_to controller: 'post', action: 'list'
  end

  def new
  end

  def create
    _account = params[:account]
    _password = params[:password]
    _name = params[:name]
    _email = params[:email]
    
    if User.find_by(account: _account) != nil
      flash[:error] = '이미 존재하는 계정입니다.'
      redirect_to :back
      return
    end
    
    user = User.new
    user.account = _account
    user.password = Digest::SHA256.hexdigest(_password)
    user.name = _name
    user.email = _email
    user.is_verified = false
    user.save
    
    verification = Verification.new
    verification.user = user
    verification.is_active = true
    verification.is_verified = false
    verification.code = SecureRandom.hex(16)
    verification.save
    
    UserMailer.signup(user, verification).deliver
    
    flash[:success] = '이메일 인증을 완료해주세요.'
    redirect_to controller: 'post', action: 'list'
    
  end
  
  def verify
    _code = params[:code]
    
    verification = Verification.find_by(code: _code)
    
    if verification == nil or verification.is_active == false
      flash[:error] == "인증이 만료되었습니다."
      redirect_to '/'
      return
    end
  
    user = verification.user
    user.is_verified = true
    user.save
    
    verification.is_verified = true
    verification.is_active = false
    verification.save
    
    flash[:success] = '인증이 완료되었습니다. 로그인을 해주세요.'
    
    UserMailer.welcome(user).deliver
    
    redirect_to controller: 'user', action: 'login_form'
  end
  
  ### forgot
  def forgot_form
  end
  
  def forgot
    _email = params[:email]
    
    user = User.find_by(email: _email)
  
    if user == nil
      flash[:error] = '존재하지 않는 계정입니다.'
      redirect_to :back
      return
    end
    
    verification = Verification.new
    verification.is_verified = true
    verification.is_active = true
    verification.user = user
    verification.code = SecureRandom.hex(16)
    verification.save
    
    UserMailer.forgot(user, verification).deliver
    
    flash[:success] = '이메일을 확인해주세요.'
    redirect_to :back
  end
  
  def forgot_change
    _code = params[:code]
    
    verification = Verification.find_by(code: _code)
    
    if verification == nil or verification.is_active == false
      flash[:error] == "인증이 만료되었습니다."
      redirect_to '/'
      return
    end
    
    if verification.is_verified == false
            flash[:error] == "인증이 완료되지 않은 메일입니다."
      redirect_to '/'
      return
    end
    
    @code = _code
  end
  
  def forgot_confirm
      _code = params[:code]
      _password = params[:password]
    
    verification = Verification.find_by(code: _code)
    
    if verification == nil or verification.is_active == false
      flash[:error] == "인증이 만료되었습니다."
      redirect_to '/'
      return
    end
    
    if verification.is_verified == false
            flash[:error] == "인증이 완료되지 않은 메일입니다."
      redirect_to '/'
      return
    end
    
    user = verification.user
    user.password = Digest::SHA256.hexdigest(_password)
    user.save
    
    verification.is_active = false
    verification.save
    
    flash[:suceess] = '비밀번호가 변경되었습니다.'
    redirect_to controller: 'user', action: 'login_form'
    
  end  
end
