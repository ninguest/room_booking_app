# Mobile Developer Interview

## Background
You are to develop a simple single page mobile application designed to allow users in our office to check for room availability. 

Assumptions: You may assume that login and access control have already been handled.




## Tasks
Develop a frontend application, listed under User Stories below, for users to search for room availability. 

- Fetch and display rooms availability by date and style according to mockup
- Sort rooms available by level, capacity or availability
- Launch camera within application to scan QRCode to book room. 


-------------------------------------
## Mock Ups
https://www.figma.com/proto/frY14DLkbptFz07WmoCeo4/Untitled?node-id=1%3A2&viewport=170%2C536%2C0.405783474445343&scaling=scale-down




## User Stories




### Task 1: As a staff, I want to list rooms available by date and time slot.
Refer to screenshots provided to style your application UI accordingly.

```
1a)     Select Datetime
        -------------------------------------
        Given user is on Room Listing Page, 
        When clicked on date & time elements,
        Then user should be able to select date & time using platform’s native date/time pickers.
```

```
1b)     Fetch Room Listing
        -------------------------------------
        Given user has selected date & time,
        When network connection is available,
        Then room listing should be displayed, sorted by level in ascending order by default
        And room details displayed must include Room name, location, capacity and respective availability.
```   
** Use the following API endpoint to fetch room availability data to complete your task. 
- HTTP GET https://gist.githubusercontent.com/yuhong90/7ff8d4ebad6f759fcc10cc6abdda85cf/raw/463627e7d2c7ac31070ef409d29ed3439f7406f6/room-availability.json
- Timeslot availability: 0 - Not Available. 1 - Available. 
- Note that above api response will be static.



### Task 2: As a staff, I want to sort room listing in different ways to search for room according to my needs.
Refer to screenshots provided to style your application UI accordingly.
```
2a)     Sort by capacity
        -------------------------------------
        Given user is on Room Listing Page, 
        When clicked on sort button,
        Then user should be able to sort room listing by capacity.
```
```
2b)     Sort by availability
        -------------------------------------
        Given user is on Room Listing Page, 
        When clicked on sort button,
        Then user should be able to sort room listing by availability.
```


### Task 3: As a staff, I want to scan QRCode printed outside room to make a room booking for next hour.
Refer to screenshots provided to style your application UI accordingly.

```
3a)     Launch QRCode Scanner
        -------------------------------------
        Given user is on Room Listing Page
        When click camera icon 
        Then camera qrcode scanner should be launched within application to scan QRCode to book room.

```

```
3b)     Scan QRCode & Open Url
        -------------------------------------
        Given qrcode scanner is launched 
        When application scan QRCode 
        Then qrcode url should be opened up in webview to display booking results.
```

```
3c)     Return back from Booking Results
        -------------------------------------
        Given booking is complete
        When user click back button
        Then app return to Room Listing Page.
```

** Your app should be able to scan QRCode provided to open up webview to simulate actual room booking success.

--------------------


## Requirements/Expectations

- Your code repository should contain a README.md that includes the following:
    - Setup instructions on how to build / run your application; we need to minimally be able to launch and test your solution locally
    - Instructions on how to run your automated tests
- Please use React-Native/iOS/Android mobile technologies to complete this technical assessment.
- Include unit tests for application logic that should be tested.
- You may state any assumptions made on requirements.
- If you are selected for a face-to-face interview, you should be prepared to:
    - Walk through your code to interviewers
    - Explain any design decisions you’ve made
    - Modify/extend the solution


## Important!
We will assess your submission holistically (i.e. not just in terms of functionality), including factors such as:
- Sound approach to handle responsive layout and styling within the application to support different devices
- Readability and code cleanliness
- Code structure/design, e.g. modularity, testability
- Naming / Coding conventions as per your language of choice
- Designing for user experience / performance
- Adequate error handling, eg. network failure



You should be able to complete this assessment within 10-12 hours.

When you have completed your assignment, before the given deadline, please upload your solution to a public git respository and submit to us (at d3hiring@gmail.com) a link to your code repository.

If you have any queries, feel free to post them to d3hiring@gmail.com.
