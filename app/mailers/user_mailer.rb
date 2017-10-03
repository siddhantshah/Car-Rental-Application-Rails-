class UserMailer < ApplicationMailer

  # Subject can be set in your I18n file at config/locales/en.yml
  # with the following lookup:
  # en.user_mailer.signup_confirmation.subject

default from: "carrentalapplication@gmail.com"
  def signup_confirmation(customer)
    @customer = customer
    mail to: customer.email, subject: "You have signed up for our app", body: "Hello Customer"
  end

  def notify(email,car)
    @car = car
    @customer = Customer.where(:email => email)[0]
    mail to: email, subject: "Car Available", body: "Hello " << @customer.name << " , Your car with license " << @car.license << " is available."
  end

end
