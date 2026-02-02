# Soviet Union App

This project is a Flutter application that demonstrates a simple authentication flow and navigation using named routes.

## Navigation Flow

The application has the following navigation flow:

1.  **Login Screen**: The initial screen of the application. The user can log in with their credentials or navigate to the sign-up screen.
2.  **Sign-Up Screen**: The user can create a new account. After a successful sign-up, the user is navigated to the dashboard.
3.  **Dashboard Screen**: The main screen after a successful login. It displays a welcome message and has a sidebar for navigation.
4.  **Soviet Dashboard Screen**: Another screen accessible from the sidebar.

## Named Routes

The application uses named routes for navigation. The routes are defined in `lib/main.dart`:

```dart
initialRoute: '/',
routes: {
  '/': (context) => const FirebaseInitWrapper(),
  '/login': (context) => const LoginScreen(),
  '/signup': (context) => const SignupScreen(),
  '/dashboard': (context) => const DashboardScreen(),
  '/soviet_dashboard': (context) => const Dashboard(),
},
```

Navigation is done using `Navigator.pushReplacementNamed()`:

```dart
Navigator.of(context).pushReplacementNamed('/dashboard');
```

## Sidebar Navigation

The application has a sidebar for navigating between the `DashboardScreen` and the `SovietDashboardScreen`. The sidebar is implemented in `lib/widgets/app_drawer.dart`.

## Screenshots

_Coming soon..._

## Reflection

### What is the role of the Navigator in Flutter?

The `Navigator` is a widget that manages a stack of `Route` objects. It is responsible for pushing and popping routes to and from the stack, which corresponds to navigating between screens.

### Why are named routes preferred for larger apps?

Named routes are preferred for larger apps because they provide a centralized way to manage all the routes in the application. This makes it easier to refactor and maintain the code, as all the routes are defined in one place. It also helps to avoid typos and errors when navigating between screens, as you are using a string name instead of a direct reference to the widget.

### How does Flutter manage the navigation stack?

- **Files**: `snake_case.dart` (e.g., `home_screen.dart`, `custom_button.dart`).
- **Classes**: `PascalCase` (e.g., `HomeScreen`, `CustomButton`).
- **Widgets**: `PascalCase` for widget classes (e.g., `CustomButton`).
- **Variables and Functions**: `camelCase` (e.g., `userName`, `fetchUserData()`).
- **Constants**: `camelCase` or `UPPER_SNAKE_CASE` for top-level constants.

## Scrollable Views Screen

A new screen `lib/screens/scrollable_views.dart` was added to demonstrate scrollable layouts:

- A horizontal `ListView.builder` showcasing simple cards.
- A `GridView.builder` embedded in a `SingleChildScrollView` for a vertical tile layout.

Navigate to it from the Dashboard using the floating action button (bottom-right).

PR: https://github.com/kalviumcommunity/S86-sovietunion/pull/11

Video demo: https://drive.google.com/file/d/1yP5PWrsDOqB1FxT_gwRahE76EK0P8kJ7/view?usp=drive_link

# Firebase Setup

## Brief Description of Firebase Setup

Setting up Firebase in a Flutter project involves several key steps:

1.  **Create a Firebase Project**: Go to the Firebase console, create a new project, and give it a name.
2.  **Register Your App**: Register your iOS and Android apps with the Firebase project. This involves providing the package name (for Android) and bundle ID (for iOS).
3.  **Download Config Files**: Download the `google-services.json` (for Android) and `GoogleService-Info.plist` (for iOS) files and place them in the correct directories in your Flutter project.
4.  **Add Firebase Dependencies**: Add the necessary Firebase plugins to your `pubspec.yaml` file, such as `firebase_core`, `firebase_auth`, and `cloud_firestore`.
5.  **Initialize Firebase**: In your `main.dart` file, initialize Firebase before running the app using `Firebase.initializeApp()`.

## Why is Firebase a popular choice for mobile backends?

Firebase is a popular choice for mobile backends for several reasons:

- **Comprehensive Services**: It offers a wide range of services, including authentication, real-time databases (Firestore and Realtime Database), cloud storage, hosting, and more, all in one platform.
- **Ease of Use**: Firebase is known for its ease of use and well-documented APIs, which makes it easy for developers to integrate its services into their apps.
- **Scalability**: It is built on Google's infrastructure, which means it can scale automatically to handle millions of users.
- **Real-time Data**: Firebase's real-time databases allow for seamless data synchronization between clients, which is great for building collaborative and real-time applications.

## What was the most challenging step in setup?

The most challenging step in the setup process can be correctly configuring the platform-specific files (`google-services.json` and `GoogleService-Info.plist`) and ensuring that all the dependencies are correctly set up. Any mistake in these steps can lead to build errors that can be tricky to debug.

## How does this integration prepare your app for authentication or database features?

This integration prepares the app for authentication and database features by:

- **Providing the Foundation**: The initial setup with `firebase_core` establishes the connection between the app and the Firebase project, which is a prerequisite for using any other Firebase service.
- **Enabling Authentication**: With the Firebase project set up, you can easily enable different authentication providers (like email/password, Google, etc.) in the Firebase console and use the `firebase_auth` plugin to manage user authentication.
- **Allowing Database Integration**: Once the app is connected to Firebase, you can use `cloud_firestore` or `firebase_database` to store and retrieve data from the cloud, enabling features like user profiles, real-time chat, and more.
