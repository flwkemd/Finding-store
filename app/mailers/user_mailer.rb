class UserMailer < ApplicationMailer

  # Subject can be set in your I18n file at config/locales/en.yml
  # with the following lookup:
  #
  #   en.user_mailer.signup.subject
  #
  def signup(user, verification)
    @user = user
    @verification = verification
    @host = ActionMailer::Base.default_url_options[:host]

    mail to: @user.email, subject: "[사이트명] 인증을 해주세요."
  end

  # Subject can be set in your I18n file at config/locales/en.yml
  # with the following lookup:
  #
  #   en.user_mailer.forgot.subject
  #
  def forgot(user, verification)
    @user = user
    @verification = verification
    @host = ActionMailer::Base.default_url_options[:host]
    mail to: @user.email, subject: "[사이트명] 비밀번호 찾기 이메일입니다."
  end

  # Subject can be set in your I18n file at config/locales/en.yml
  # with the following lookup:
  #
  #   en.user_mailer.welcome.subject
  #
  def welcome(user)
    @user = user

    mail to: @user.email, subject: "[사이트명] 회원가입을 환영합니니다."
  end
end
