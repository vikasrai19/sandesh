# Sandesh

> Indian Native chatting app created using Flutter.

### Features :
* User Authentication using Firebase Phone Authentication
* Real time messaging with friends
* Group chats and messages
* Update Stories 
* Notify when your contacts join **SANDESH**
* Completely free to use
* Dark mode to reduce strain on eyes
* Different Message themes
* **Sandesh** chat bot
* Developed In India

---

### Progress : 
* User Authentication 
    * [✅] Design a page to get user phone number
    * [✅] Get the phone Number and create  a new user account in firebase
    * [✅] Design a page to take name from the user
    * [✅] After getting all the details about the user, store the user data in database
        * [✅] And also mark the user as signed in and save the sign in state in shared preferences
        * [✅] Store user name, user uid and user profile image url in shared preferences

    * [✅] Whenever the app opens, check for the user's sign in state, if signed in alrady, just load the home page of the app
    * [✅] Also provide the feature of logging out of the account.
    
* Messaging
    * [✅] Creating a home page as a entry page to the app
    * [✅] Creating three tabs -> each for Message, Stores and Profile
    * [✅] Display all the new messages in the order of new in the first
        * [ ] Create a chat tile
        * [ ] Display the other user profile image if present
        * [ ] Display name of the user, according to the contact
        * [ ] Display the last message
        * [ ] Display the count of unread message if any
        * [ ] Display the time of last message
        * [ ] Option to archive any chat
        * [ ] option to delete the entire chat
    * [ ] Create a chat page, for users to chat
        * [ ] Text support message
            * [ ] Send a text message
            * [ ] Receive a text message
        * [ ] Image support 
            * [ ] Send an image
            * [ ] Receive an image
            8 [ ] Show image in the chat page
            * [ ] Display image inside the main app
        * [ ] Video support  
            * [ ] Send a video
            * [ ] Receive an video
            * [ ] Show video in the chat page
            * [ ] Play the video in the main app
        * [ ] Document Support
        * [ ] Audio Support 
            * [ ] Send Audio message
            * [ ] Receive Audio Message
            * [ ] Record and send audio message
        * [ ] Emoji Support 
            * [ ] Custom emojis
        * [ ] Sticker support
            * [ ] Built-in Sticker
            * [ ] Custom stciker 
        * [ ] Option to mark the text as **Important**
        * [ ] Option to copy the text of message into clipboard
        * [ ] Add end-end encryption  
        * [ ] Display the time of each message
        * [ ] Display whether the message as deliverd or not
        * [ ] Display whether the message is read by the user
        * [ ] Option to check delivery report of the message
        * [ ] Forward any message
        * [ ] Check for any particular message in the chat 
        * [ ] Option to delete the particular chat
    * [ ] Design a status page
        * [ ] Allow user to add his status
        * [ ] Allow user to check his status
        * [ ] Allow user to check other contact people's status
        * [ ] Display who has seen their status
    * [ ] Desing a profile page
        * [ ] Show user name and profile pic if any, if profile pic is null, show name initials
        * [ ] List out different settings to tweak
        * [ ] Add controls to toggle dark mode
        * [ ] Add different themes for users
        * [ ] Add an option to share this app
        * [ ] Add control to log out
            * [ ] Remove the name, user uid, profile pic and login state from shared preferences

* Some extra things:
    * [ ] Add terms and conditions
    * [ ] Add privacy and policy
    
    
----
    
## App Structure
### **Models**
#### **User Model**
* This is used to store the details of the user.
* **Name** => Contains the name of the user.
* **phoneNo** => Contains the phone number of the user.
* **dob** => Contains the DOB of the user.
* **userUid** => Contains the UID provided by the firebase for the user.
* **profileImg** => Contains the link of the profile image of the user.
<br /><br />
#### **Message Model**
* This model describes the entire structure of Messages that are going to be sent using this app.
* **sender** => Contains the phone no of the sender
* **msg** => Contains the content of the msg sent
* **msgType** => Defines the type of the message sent [EG: TEXT, AUDIO, VIDEO] [..This may change..]
* **isMessageDel** => Returns true if the message is delivered.[FALSE BY DEFAULT]
* **isMessageRead** => Returns true if the message is read by the receiving user. [FALSE BY DEFAULT]
* **messageSentTime** => Stores the time at which the message was created and sent by the user.
* **messgaeDelTime** => Stores the time at which the message was delivered to the receiving user.
* **messageReadTime** => Stores the time at which the message was read by the receiving user.
* **time** => Contains milliSecondsSinceEpoch time. This is used to display the message in order.
<br /><br />
#### **Contacts Model**
* This describes the structure of the Contact class that is used to store different contacts value from the phone's contact list.
* **name** => Stores the display name of the contact.
* **phoneNo** => Stores the phone No of the specific contact.
<br /><br />
----
### **Controllers**

#### **AccountController**
* This controller is responsible for the authentication of the user and also stores the user data in two different databases. Mainly Firebase Firestore and SQFLite local database.
    * **veifyPhoneNumber()**:
        *  This function takes in the user phone number and sends them an otp to verify and then login the user.
        * The supported mobiles otp will autoread by the app and if there is any issue in auto-reading the otp, the user can input the otp manually.
    * **getUserUid()**: 
        * This function gets userUid of the logged in user. USERUID is the unique generated by Firebase for each user.
    * **selectDate()**:
        * This function displays the calendar for the user to pick his birth date and then stores it.
    * **storeUser()**:
        * This function adds all the user details like name, phoneNo, userUid, profileImage link and dob into two different databases.
    * **checkIsUserSignedIn()**:
        * This function checks if the user is already signed in, if they are already signed in, then directly home page will be rendered or else authentication page will be rendered.
    * **signOut()**: 
        * This function deletes the values of the user that is stored in the local database and sets the isSignedIn Value into false, and redirects the app into authentication page.

#### **ContactController**
* This controller is used to get the contacts from the user phone and store it in its required data format.
    * **getContact()** :
        * This function fetches all the contacts from the users phone and stores it in contact variable.
    * **askPermission()**:
        *  It fetches the permission that is given by the user to access the contact.
        * If the permission is granted than **getContacts()** function will be called.
        * Else if the permission is not granted, then **handleInvalidPermission()** will be called.
    * **getContactPermission()**:
        * This check the permission status to access the phone contacts.
        * If the permission is not granted and if the permission is not denied, then the pop up will be sent asking for permission to access the system.
        * Else the permission will be returned.
    * **handleInvalidPermission()**:
        * If the permission to access contacts is denied, then a platform exception will be raised saying permission is denied by the user.

#### **HomePageController**
* This controller is used to handle the working of the home page of the app.
    * **getChats()** :
        * This function fetches the chat list of user from the firebase using users phone number.[To be continued]
    * **navItems**:
        * This variable contains the different bottomNavigation Icons that has to be displayed to the user in the home page.
        * They include Home icon for chats page, camera icon for status page and person icon for profile page.
    * **children**:
        * This variable contains three different pages for the three bottom navigation bars. ie Homepage, StatusPage and ProfilePage.
    * **onTabTapped()**:
        * This function is used to change the tabs on the press of different tab icons in the bottom navigation bar.

#### **LocalDatabaseController**
* This controller is used to connect to the local database ie sqflite database and store all the information so that it can be accessed when the phone is not connected into the internet.
    * **createDatabase()**:
        * This function is used to create a new database if the database is not existing and then return the database object.
    * **populateDatabase()**:
        * This function creates different tables to store values in them.
        * The present tables include **User** table, **message** table and **contacts** table.
    * **addUserData()**:
        * This function is used to store the user information in local database so that it can be accessed later.
    * **getUserData()**:
        * This function gives all the information about the user that us stored in the local database.
    * **deleteUserData()**:
        * This function deletes all the information about the user that is stored in the local database.
    * **getContactList()**:
        * This function is used to get the list of contacts that has been saved in the local database.
    * **addContactsToDB()**:
        * This function is used to add new contacts into the local database.

#### **User Controller**
* This controller is used to store the different info of the user and provide them to the required functions during the execution of the app.
    * **setUserValue()**:
        * This function is used to set the each peice if user info with their resp variables so that it can be easily accessed by other functions during the execution of the program.
----
### **Views**
<br />

----

## Database Structure

### **Firebase Firestore**
### 

### **SQFLite Local Database**
----