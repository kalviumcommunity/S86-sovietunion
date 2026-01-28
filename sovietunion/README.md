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

Flutter manages the navigation stack using the `Navigator` widget. When you push a new route onto the stack, the new screen is displayed on top of the previous one. When you pop a route from the stack, the previous screen is revealed. The `Navigator` keeps track of the order of the routes in the stack, so you can navigate back and forth between screens. You can also manipulate the stack by using methods like `pushReplacementNamed`, which replaces the current route with a new one, or `popUntil`, which pops routes until a certain condition is met.
