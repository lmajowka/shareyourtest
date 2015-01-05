class UserMailer < ActionMailer::Base

  def welcome(user)
    mail(
      :subject => 'Welcome to Share your Test',
      :to      => user.email,
      :from    => 'contact@shareyourtest.com',
      :tag     => 'my-tag'
    )
  end

  def purchase_thankyou(user,test)
    @test = test
    mail(
      :subject => 'Thankyou for your purchase',
      :to      => user.email,
      :from    => 'contact@shareyourtest.com',
      :tag     => 'my-tag'
    )
  end

end