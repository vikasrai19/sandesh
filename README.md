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
    * [ ✅ ] Design a page to get user phone number
    * [ ✅ ] Get the phone Number and create  a new user account in firebase
    * [ ✅ ] Design a page to take name from the user
    * [ ✅ ] After getting all the details about the user, store the user data in database
        * [ ✅ ] And also mark the user as signed in and save the sign in state in shared preferences
        * [ ✅ ] Store user name, user uid and user profile image url in shared preferences

    * [ ✅ ] Whenever the app opens, check for the user's sign in state, if signed in alrady, just load the home page of the app
    * [ ✅ ] Also provide the feature of logging out of the account.
    
* Messaging
    * [ ✅ ] Creating a home page as a entry page to the app
    * [ ✅ ] Creating three tabs -> each for Message, Stores and Profile
    * [ ✅ ] Display all the new messages in the order of new in the first
        * [ ] Create a chat tile
        * [ ] Display the other user profile image if present
        * [ ] Display name of the user, according to the contact
        * [ ] Display the last message
        * [ ] Display the count of unread message if any
        * [ ] Display the time of last message
        * [ ] Option to archive any chat
        * [ ] option to delete the entire chat
    * [ ✅ ] Create a chat page, for users to chat
        * [ ✅ ] Text support message
            * [ ✅ ] Send a text message
            * [ ✅ ] Receive a text message
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