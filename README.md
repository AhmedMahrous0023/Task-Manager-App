
# Video Of My App

[Watch Demo Video](https://vimeo.com/948966731?share=copy)


# Task Manager App 
Task Manager App is an application that allows users to log in with a specific username and password to access dummy data on a server. The app features:

# Features

**User Authentication**:: Users can log in using predefined credentials stored on a server with dummy data.

**User Information**: A drawer menu provides information about the user, options for dark mode, and a logout button.

**Task Management**: On the main home screen, users can view tasks with checkboxes. These tasks are fetched from a server API providing dummy data for "todos".

**Pagination**: The app implements pagination, displaying 10 tasks at a time. As users scroll, more tasks are loaded incrementally.

**Task Deletion**: Users can swipe tasks to either side to prompt an alert dialogue, asking if they want to delete the task.



**Getting Started**

To run Task Manager App  locally, follow these steps:

Clone this repository.

Navigate to the project directory.

Run flutter pub get to install dependencies.

Run the app using flutter run.

# Usernames and Passwords
You can try the app using the following predefined usernames and passwords:

       username": "hbingley1",
      "password": "CQutx25i8r",

      "username": "atuny0",
      "password": "9uQFF1Lh",

      "username": "rshawe2",
      "password": "OWsTbMUgFc",

       "username": "yraigatt3",
      "password": "sRQxjPfdS",

      "username": "kmeus4",
      "password": "aUTdmmmbH",

      "username": "jtreleven5",
      "password": "zY1nE46Zm",

      "username": "dpettegre6",
      "password": "YVmhktgYVS",

      "username": "ggude7",
      "password": "MWwlaeWcOoF6",

      username": "nloiterton8",
      "password": "HTQxxXV9Bq4",

      username": "umcgourty9",
      "password": "i0xzpX",




  

**Prerequisites** 

Ensure you have Flutter and all necessary dependencies installed.

**Dependencies:** 

  Task Manager App relies on the following key dependencies:

provider: ^6.1.2

  http: ^1.2.1

  shared_preferences: ^2.2.3

  sqflite: ^2.3.3+1

  path: ^1.9.0

For a full list of dependencies, look the pubspec.yaml file.



# Design Decisions

**Responsive Design** : The UI is designed to be responsive, providing an optimal user experience across various devices and screen sizes. MediaQuery is used to adapt layouts and widgets dynamically.

**Dark Mode** :A dark mode option is available, providing a better experience in low-light conditions. The app automatically adjusts text and background colors based on the selected theme.

**User-Friendly Navigation** :The drawer menu offers easy access to user information and settings, including the dark mode toggle and logout functionality.

# State Management

**Provider Package** : The app uses the Provider package for state management. This allows for efficient and reactive updates to the UI based on changes in the app's state, such as user authentication status and task list updates.

# Data Handling
 **Pagination** :To improve performance and user experience, tasks are loaded in small chunks (10 at a time). This approach minimizes initial load time and optimizes memory usage.

 **Local Storage** : For tasks added by the user, data is stored locally using SQLite. This ensures persistence across app sessions, even when offline.


 # Network Operations
 **API Integration** : he app integrates with a server API to fetch tasks and user data. This demonstrates handling real-world scenarios where data is fetched from and synchronized with a remote server.

 **Error Handling** :  Robust error handling ensures that the app gracefully handles network errors, displaying appropriate messages to the user and maintaining a smooth user experience.

 # Challenges Faced

 **State Management**

 **Provider Implementation**: Implementing the Provider package for state management required a deep understanding of reactive programming principles and ensuring that state updates were properly reflected in the UI without causing unnecessary rebuilds.

 **Pagination**

 **Efficient Data Loading**: Implementing efficient data loading with pagination was challenging. Ensuring that the user experience remained smooth while loading additional data dynamically required careful handling of scroll events and asynchronous data fetching.


**Local Storage**

 **SQLite Integration** : Integrating SQLite for local storage involved learning the sqflite package, setting up the database schema, and ensuring that data persisted correctly across app sessions.


 # Testing

**Unit and Widget Tests** : Comprehensive tests cover critical functionalities such as task CRUD operations, input validation, state management, and network requests. Mock responses are used for testing against reqres.in endpoints.

# Security 
**User Authentication** : The app ensures that sensitive operations like login and data fetch are secured. Dummy data is used for demonstration purposes, but principles for secure communication with a server are applied.





# Contributing
We welcome contributions from the community! Feel free to report bugs, suggest features.


**Acknowledgements**

We would like to express our gratitude to the Flutter and Provider communities for their valuable contributions and support.

**Contact**

For any inquiries or support, please reach out to [ahmed.mahrous1092@gmail.com],
[amahrous022@gmail.com]

