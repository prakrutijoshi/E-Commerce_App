# **E-Commerce App**
*_made by <a href="https://github.com/prakrutijoshi">Prakruti Joshi</a>, <a href="https://github.com/Niraj-Vasani">Niraj Vasani</a>, <a href="https://github.com/hiren018">Hiren Sanghani</a>, <a href="https://github.com/rprajapati4889">Ravi Prajapati</a>_*

## Note
_The developed branch is with the final code of the executed project. The code here comes after accepting the merge request from the main branch._

## ***Abstract***

_A business where a variety of products are bought and sold through the electronics networks such as the internet is known as Electronic Commerce (E-Commerce). In such a fast-paced world where almost everyone is using smart mobile phones, having an application that could be used for shopping at finger-tips from wherever and whenever. A project with an idea to build one such E-commerce application is what you will find here. An Android Application that works for the User for buying products and Sellers for selling their business products._

## ***Enhance your E-Commerce Experience with following app features***

-### Overview 

_There are several ongoing famous online web stores and applications that have gained a huge popularity over time amongst people. Such online applications are beneficial to the customers and retailers. Customers could get whatever they wanted to buy at their doorstep and Retailers could sell their products all around the world._

- ### User Registration

_The E-Commerce App user can download the application and Register their account to enable the features. A User can register by user credentials via Email and password.Once registered, user needs to logIn which will navigate them to the Home Page of the application. All the credentials entered are store to the firebase with the help of Firebase Authentication._

- ### Retailer Registration

_The retailer/seller is someone who owns a business or wants to sell their products online via the E-Commerce Application. The seller needs to register to the seller side application by Email password.Once registered, seller can LogIn and add products to sell.  All the credentials entered are store to the firebase with the help of Firebase Authentication._

- ### SignIn

_The user or retailer can signIn to the application by the registered email id and password or Google Account (Gmail). The credential will be stored at the backend in the firebase authentication.

- ### Products

_The Products displayed on the user side module are the products that are added to sell by the retailers. The seller can add the product and its details whereas the user can see those product details,later order the products they want to buy.

_Products available right now in the application are linked with the firebase firestore Collections. There are four collection in the firestore which includes Products data, users data, orders data and sellers data.
```
Product details include following data:

- Title 
- Description 
- Price
- Images 

```
- ### Categories

_Products added or viewed are divided into seven categories which includes Electronics, Fashion, Grocery, Home adn Kitchen, Medicines, Vegetables and Fruits and Others section. The User can search for products or directly go through the particular categories for the desired product._

- ### WishList Or Cart

_Once the user views the products and likes it, they can wishlist the products and later add them to the cart or could direclty add them to the cart. The user can add as much products as they wish to the wishlist and cart. In the Cart Page the user can increase or decrease the quantity of the products and view the total price of the products added into the cart._

- ### Ordering and Payment

_Once the products are in the cart, the user can proceed further to order the desired products. This will navigate the user to the Checkout Page where the user will be able to see the actual total price of the cart along with the deduction of the discounts (if applicable) and addition of the Shipping charges. Other than that the user can add the address from the checkout page for the delivery. After which the user will be navigated to the payment options page where they are several options for the methods of payment ( For now Cash On Delivery is only applicable). Finally the user can place the order successfully._

- ### Receiving Orders

_After the orders are successfully placed by the users in the user moduled application, on the other side the seller of the particular products can view the orders details for the orders received. The orders are to be automatically be delivered and untill then the users can check they order status in the orders section which could be either "In Process" or "Delivered" accordingly._

- ### Profile Page

_The User and seller both module has a profile page that contains the loggedIn user details. The Name, Email Id, WishList, Cart and Orders are different for every user displayed in the Profile section. The User or Seller can add the Profile Image through this page either directly by capturing from the camera or could select from the photo gallery.user can logout from the application from the profile page itself. Once loggedOut the user/seller will be navigated back to the signIn page._

- ### Retailer Products Visualization or Updation

_If the seller wants to update the details of their products, seller can increase or decrease the price and quantity of the products. Moreover, the Instock products and Out Of Stock products could be viewed in the seller module of the application. The backend Firebase Firestore constantly gathers and updates the details._

 ```
 
Following are pages of the application:

### Customer Module:
Welcome Page
Login Page
SignUp (Registration Page)
HomePage (Bottom Navigation)
Product List Page 
Cart Page
WishList Page
Address Page
Order checkout Page
Profile Screen

### Retailer Module
Welcome Page
Login Page
SignUp Page
HomePage (Bottom Navigation)
Add new Products
Watch InStock and OutOfStock Products
Update Product details
Check placed orders 
Profile Page

```
- ### User Interface

_The UI of both the application are user friendly and with some elegant and bright color designs that lets the user/seller to work efficiently and effectively throughout the application._

- ### Project execution

_Project is build with the help of Flutter and Firebase. We have worked on the applications while maintaining the Clean Architecture of the Data, Domain and Presentation Layers for store data, repositories and UI & Cubits respectively. However one needs to add the services file-json file to run the application._


Made with [radixweb].
