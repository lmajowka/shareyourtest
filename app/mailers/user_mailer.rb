class UserMailer < ActionMailer::Base

  def welcome(user)
    mail(
      :subject => 'Welcome to Share your Test',
      :to      => user.email,
      :from    => 'contact@shareyourtest.com',
      :tag     => 'my-tag'
    )
  end

end