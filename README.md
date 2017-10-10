# Car Rental Application 

This project has been developed as part of our course Object Oriented Design and Development.
It serves as our submission to Program 2.
Our project based on Ruby on Rails and fulfills all the requirements as specified in the documentation.


The application has three forms of users - customers, admins and superadmins.
The customer can rent a car by selecting his preferences and based on the availablilty of that model.
The admin and superadmin monitor the renting and returning of cars.


## Deployment
This application has been deployed on [Heroku](http://rentonecar.herokuapp.com/) 


## Site Navigation

_**While reviewing the website, do not delete these default login ID's to test the delete functionality, as this effects other reviews which we receive.**_

1. Superadmin
Login with superadmin credentials (Ex: email: 'super@super.com', password: 'super123')


2. Admin
Login with admin credentials (Ex: email: 'admin@admin.com', password: 'admin123')


3. Customer
Login with customer credentials (Ex: email: 'customer@customer.com', password: 'customer123')

CUSTOMER FUNCTIONALITIES WORK FLOW:

**Login functionality:**
1) Enter username
2) Enter password
3) Click on Sign-in

The landing page will be the user's profile. There are 4 buttons.

The Edit profile button is available for the user to edit his profile.

**Search for a Car:**
1) Click on Search for a Car button.
2) The landing page is the search_cars landing page,where you can search by Location, Manufacturer, Style, etc. The search is case sensitive.
3) To view car deatils, click on "Car details" button.
4) If the car is available for reservation,click on "Reserve".

**Reserve a Car (after searching for it):**
1) The reserve_car URL is launched, where you can enter the checkout time and return time. 
2) If the checkout time or return time is invalid, error messages will be thrown accordingly.
3) Click on reserve. If the reservation is successful, the same gets reflected in the database and will be 
displayed to you in the car_reserved view.

**View Checkout History:**
1) Click on my profile button in the above view.
2) Click on Checkout History button.
3) The checkout_history view opens, the details of the car that your reserved is seen.

**Cancel reservation:**
1) Navigate to "My Profile".
2) Click on cancel reservation button.
3) The cancellation will be successful. Nagivate to checkout history and verify if the status of your
reservation is cancelled.

**Suggest Car:**
1) To suggest a car, click on "Suggest Car" button in my profile.
2) Enter location , manufacturer,model,style.
3) Click on "create suggestion"
4) Thank you for your suggestions will be displayed in the corresponding view.
5) An email notification will be sent to the user.
6) Login with admin credentials, UNAME:admin@admin.com, PWD: admin123
7) Click on "View/manage" suggestions.
8) Suggestions view opens where the admin can decide whether or not to accept the suggestion
by entering a License Number and rate.
9) If suggestion is accepted, verify if the car is available in the list of cars.


ADMIN FUNCTIONALITIES WORKFLOW:

1) View/Manage cars
  Admin can reserve available cars, or edit car details or destroy details 
2) View/Manage Customers
  Admin can view/edit/ remove customer records.
3) View/Manage admins
  To add new admins/modify existing ones.
4) View/manage rentals
 To manage and edit existing reservations.
5) View/Manage suggestions
 To accept/reject suggestions made by customer.
6) rserve on behalf of customer
 To make reservations on behalf os the customer.
7) Edit your profiles
 To edit his own profile.

## Team Members
1. Siddhant Shah (sshah15)
2. Tanay Kothari (tkothar)
3. Aishwarya Sundar (asundar)

