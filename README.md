# Soviet Union App

This project is a Flutter application.

## Folder Structure

The project follows a feature-driven directory structure to promote modularity and scalability.

```
lib/
├── main.dart          # Entry point of your app
├── screens/           # Individual UI screens for each feature
├── widgets/           # Reusable UI components shared across the app
├── models/            # Data models representing the app's data structures
├── services/          # Business logic, API calls, and other services
```

### Directory Purpose

- **`lib/`**: The main container for all Dart code in the application.
- **`main.dart`**: The entry point of the application. It initializes the app and sets up the root widget.
- **`screens/`**: Contains the primary UI screens of the application. Each screen is typically a separate file and represents a major feature or view.
- **`widgets/`**: Holds reusable UI components that can be shared across multiple screens. This promotes code reuse and a consistent UI.
- **`models/`**: Defines the data structures for the application. These are plain Dart classes that represent the data fetched from an API or used within the app.
- **`services/`**: Contains the business logic of the application, such as API communication, database interactions, and other background services.

### Modular App Design

This folder structure supports a modular app design by separating concerns:

- **UI (`screens/`, `widgets/`)**: The UI is kept separate from the business logic, making it easier to modify the look and feel of the app without affecting the underlying functionality.
- **Data (`models/`)**: By defining data models in one place, we ensure a consistent data structure throughout the app.
- **Logic (`services/`)**: Centralizing business logic makes it easier to manage and test.

This separation allows different developers to work on different parts of the app simultaneously with minimal conflicts.

### Naming Conventions

To maintain a clean and readable codebase, we follow these naming conventions:

- **Files**: `snake_case.dart` (e.g., `home_screen.dart`, `custom_button.dart`).
- **Classes**: `PascalCase` (e.g., `HomeScreen`, `CustomButton`).
- **Widgets**: `PascalCase` for widget classes (e.g., `CustomButton`).
- **Variables and Functions**: `camelCase` (e.g., `userName`, `fetchUserData()`).
- **Constants**: `camelCase` or `UPPER_SNAKE_CASE` for top-level constants.

## Responsive Design Implementation

The app features a fully responsive dashboard (`responsive_home.dart`) that adapts seamlessly across different device sizes and orientations:

- **MediaQuery Integration**: Dynamically detects screen width, height, and orientation to adjust layouts
- **Adaptive Layouts**: 
  - Phone (portrait): 2-column grid
  - Tablet (portrait): 3-column grid  
  - Tablet (landscape): 4-column grid
- **Flexible Widgets**: Uses `Flexible`, `FittedBox`, and `LayoutBuilder` for smooth scaling
- **Responsive Typography**: Font sizes and icon sizes automatically adjust for tablets vs phones
- **Overflow Protection**: Proper text truncation and responsive padding prevent UI breaks on any screen size

The responsive dashboard displays shared community spaces (Gym, Community Hall, Swimming Pool, Parking, Study Room, Playground) with an intuitive card-based interface that maintains visual consistency across all devices.


# Stateless vs Stateful Widgets in Flutter

## 📌 Project Overview
This project demonstrates the fundamental difference between **StatelessWidget** and **StatefulWidget** in Flutter. The demo focuses on how static UI elements differ from dynamic, state-driven components and how Flutter efficiently updates the user interface when state changes.

This task is part of **Sprint #2** and aims to strengthen understanding of Flutter’s widget system and reactive UI model.

---

## 🔹 Stateless Widgets

A **StatelessWidget** is a widget that does not store or manage any mutable state. Once it is built, it does not change unless it is rebuilt by its parent widget with new input data.

### When to use StatelessWidget:
- Static text or labels
- Icons and images
- Headers or titles
# Soviet Union App

This project is a Flutter application. The sections below include a new lesson for Sprint-2: "Scrollable Views with ListView & GridView" — examples, guidance, and submission notes.

## Scrollable Views — ListView & GridView (Sprint-2)

Overview
- This lesson demonstrates how to implement scrollable UIs using `ListView` and `GridView` in Flutter.
- It includes code snippets, a combined example, and guidance for testing and submission.

### 1. ListView — Vertical and Horizontal Scrolling
ListView is used for vertically scrolling lists of widgets. For long or dynamic lists, prefer `ListView.builder` for performance.

Basic vertical ListView:

```dart
ListView(
  children: [
    ListTile(
      leading: Icon(Icons.person),
      title: Text('User 1'),
      subtitle: Text('Online'),
    ),
    ListTile(
      leading: Icon(Icons.person),
      title: Text('User 2'),
      subtitle: Text('Offline'),
    ),
  ],
);
```

Using `ListView.builder` for long lists:

```dart
ListView.builder(
  itemCount: 10,
  # Soviet Union App

  This Flutter project includes Sprint-2 lessons and a Firebase Auth exercise. The README below focuses on the authentication flow: Sign Up, Login, and Logout using Firebase Authentication and real-time session handling.

  ## Firebase Auth — Quick Overview

  Flow:
  - Sign Up: creates account in Firebase
  - Login: returns an authenticated session
  - App listens to `authStateChanges()` and shows `HomeScreen` when a user is present
  - Logout: clears session and returns to `AuthScreen`

  ## Add dependencies (pubspec.yaml)

  dependencies:
    firebase_core: ^3.0.0
    firebase_auth: ^5.0.0

  Install packages:

  ```bash
  flutter pub get
  ```

  ## Initialize Firebase and use `authStateChanges()` (`lib/main.dart`)

  Use the `StreamBuilder<User?>` pattern so navigation reacts to auth state:

  ```dart
  import 'package:flutter/material.dart';
  import 'package:firebase_core/firebase_core.dart';
  import 'package:firebase_auth/firebase_auth.dart';
  import 'firebase_options.dart';
  import 'screens/login_screen.dart';
  import 'screens/home_screen.dart';

  void main() async {
    WidgetsFlutterBinding.ensureInitialized();
    await Firebase.initializeApp(options: DefaultFirebaseOptions.currentPlatform);
    runApp(MyApp());
  }

  class MyApp extends StatelessWidget {
    @override
    Widget build(BuildContext context) {
      return MaterialApp(
        title: 'Auth Flow Demo',
        home: StreamBuilder<User?>(
          stream: FirebaseAuth.instance.authStateChanges(),
          builder: (ctx, snapshot) {
            if (snapshot.hasData) return HomeScreen();
            return LoginScreen();
          },
        ),
      );
    }
  }
  ```

  ## Auth service example (`lib/services/auth_service.dart`)

  ```dart
  import 'package:firebase_auth/firebase_auth.dart';

  class AuthService {
    final FirebaseAuth _auth = FirebaseAuth.instance;

    Future<User?> signUp(String email, String password) async {
      final cred = await _auth.createUserWithEmailAndPassword(email: email, password: password);
      return cred.user;
    }

    Future<User?> signIn(String email, String password) async {
      final cred = await _auth.signInWithEmailAndPassword(email: email, password: password);
      return cred.user;
    }

    Future<void> signOut() async => _auth.signOut();
  }
  ```

  ## AuthScreen (Login + Sign Up)

  - Collect email and password inputs.
  - Toggle between Login and Sign Up modes.
  - Call `AuthService.signUp()` or `AuthService.signIn()`.
  - Handle `FirebaseAuthException` and show `SnackBar` messages.

  Example submit handling snippet:

  ```dart
  try {
    await AuthService().signIn(email, password);
  } on FirebaseAuthException catch (e) {
    ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text(e.message ?? 'Authentication error')));
  }
  ```

  Note: On success you don't need to navigate manually — the `StreamBuilder` in `main.dart` will detect the change and show `HomeScreen`.

  ## HomeScreen (`lib/screens/home_screen.dart`)

  ```dart
  import 'package:flutter/material.dart';
  import 'package:firebase_auth/firebase_auth.dart';

  class HomeScreen extends StatelessWidget {
    @override
    Widget build(BuildContext context) {
      final user = FirebaseAuth.instance.currentUser;
      return Scaffold(
        appBar: AppBar(
          title: Text('Welcome, ${user?.email}'),
          actions: [IconButton(icon: Icon(Icons.logout), onPressed: () => FirebaseAuth.instance.signOut())],
        ),
        body: Center(child: Text('You are logged in!', style: TextStyle(fontSize: 22))),
      );
    }
  }
  ```

  ## Testing checklist

  1. Start the app on emulator/device.
  2. Sign up a new user → verify user appears in Firebase Console (Authentication → Users).
  3. App auto-switches to `HomeScreen` after successful sign-up/login.
  4. Tap logout → app returns to `LoginScreen`.
  5. Test error cases: invalid email, wrong password, short password, existing account.

  ## Screenshots

  - Add screenshots in `assets/screenshots/` and link them here:
    - `auth_screen.png`
    - `home_screen.png`
    - `firebase_users.png`

  ## Reflection (write your answers here)

  - Hardest part: e.g., handling different `FirebaseAuthException` codes and ensuring smooth UX.
  - How `StreamBuilder` helps: it centralizes session handling and auto-updates UI when auth state changes.
  - Why logout matters: ensures tokens are cleared and protects user sessions on shared devices.

  ## Commit & PR

  - Commit message example: `feat: implemented signup, login, and logout flows using Firebase Auth`
  - PR title example: `[Sprint-2] Firebase Auth – Signup, Login & Logout Flows – TeamName`
  - PR description: include summary, screenshots (Auth + Home), Firebase Users screenshot, and reflection.

  ---

  Next steps I can take for you:
  - Wire `lib/screens/login_screen.dart` and `lib/screens/signup_screen.dart` to call `AuthService` and display SnackBars.
  - Update `lib/main.dart` in your app to the `StreamBuilder` pattern above.
  - Add or update `home_screen.dart` if you'd like a dedicated file.

  Tell me which of these you want me to implement.
