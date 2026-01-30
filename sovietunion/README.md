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
