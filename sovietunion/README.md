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

# Input Form with Validation

This project demonstrates a simple login form with input validation in Flutter. The form uses a `GlobalKey<FormState>` to manage the form's state and validate the input fields.

## Code Snippets

### TextFields and Form

The `Form` widget acts as a container for grouping and validating multiple form fields. The `TextFormField` widgets are used for text input and have a `validator` property to check for valid input.

```dart
final _formKey = GlobalKey<FormState>();
final _emailController = TextEditingController();
final _passwordController = TextEditingController();

// ...

Form(
  key: _formKey,
  child: Column(
    mainAxisAlignment: MainAxisAlignment.center,
    children: [
      TextFormField(
        controller: _emailController,
        decoration: const InputDecoration(labelText: 'Email'),
        keyboardType: TextInputType.emailAddress,
        validator: (value) {
          if (value == null || value.isEmpty) {
            return 'Please enter your email';
          }
          if (!RegExp(r'^[^@]+@[^@]+\.[^@]+').hasMatch(value)) {
            return 'Please enter a valid email';
          }
          return null;
        },
      ),
      const SizedBox(height: 16),
      TextFormField(
        controller: _passwordController,
        decoration: const InputDecoration(labelText: 'Password'),
        obscureText: true,
        validator: (value) {
          if (value == null || value.isEmpty) {
            return 'Please enter your password';
          }
          if (value.length < 6) {
            return 'Password must be at least 6 characters long';
          }
          return null;
        },
      ),
      // ...
    ],
  ),
)
```

### Button and Validation Logic

The `ElevatedButton`'s `onPressed` callback triggers the form's validation by calling `_formKey.currentState!.validate()`. If the form is valid, it proceeds with the login logic and shows a `SnackBar`.

```dart
void _login() {
  if (_formKey.currentState!.validate()) {
    ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(content: Text('Processing Data')),
    );
    Navigator.of(context).pushReplacementNamed('/dashboard');
  }
}

// ...

ElevatedButton(onPressed: _login, child: const Text('Login')),
```

## Screenshots

### Form Before Validation

![Before Validation](https://via.placeholder.com/300x600.png?text=Before+Validation)

### Form After Validation

![After Validation](https://via.placeholder.com/300x600.png?text=After+Validation)

## Reflection

### What are the benefits of input validation in mobile apps?

Input validation is crucial in mobile apps for several reasons:

- **Data Integrity:** It ensures that the data entered by the user is in the correct format and meets the required criteria before it is sent to the server or stored locally. This prevents data corruption and related issues.
- **User Experience:** Providing immediate feedback on invalid input helps users correct their mistakes easily, leading to a less frustrating and more efficient user experience.
- **Security:** It helps prevent common security vulnerabilities like SQL injection and cross-site scripting (XSS) by ensuring that the input does not contain malicious code.

### How does FormState simplify input handling?

`FormState` simplifies input handling in Flutter by providing a centralized way to manage and validate multiple form fields. Instead of handling each field's state and validation individually, you can use a `GlobalKey<FormState>` to:

- **Validate all fields at once:** `formKey.currentState!.validate()` triggers the validation for all `TextFormField`s within the `Form`.
- **Save the form:** `formKey.currentState!.save()` calls the `onSaved` callback for each `TextFormField`, allowing you to easily save the final values.
- **Reset the form:** `formKey.currentState!.reset()` resets all the fields in the form to their initial values.

### What user experience improvements can be made through feedback widgets like SnackBar?

Feedback widgets like `SnackBar` can significantly improve the user experience by:

- **Providing Confirmation:** Informing users that an action, like submitting a form or saving data, was successful.
- **Displaying Non-critical Errors:** Showing error messages that don't require immediate user interaction, such as a network error.
- **Offering Contextual Actions:** A `SnackBar` can include an action button, like an "Undo" option after deleting an item, giving users more control.
- **Being Unobtrusive:** `SnackBar`s appear at the bottom of the screen and disappear after a short time, providing information without interrupting the user's workflow.

# Animations in Flutter

## Goal: Use animation to improve user experience, not to distract.

This document outlines how to use animations in Flutter to create a better user experience.

## 2. Explore Implicit Animations

Implicit animations automatically transition between property values without needing an animation controller. Flutter’s built-in widgets like `AnimatedContainer`, `AnimatedOpacity`, and `AnimatedAlign` make this easy.

### Example 1: AnimatedContainer

```dart
import 'package:flutter/material.dart';

class AnimatedBoxDemo extends StatefulWidget {
  @override
  _AnimatedBoxDemoState createState() => _AnimatedBoxDemoState();
}

class _AnimatedBoxDemoState extends State<AnimatedBoxDemo> {
  bool _toggled = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('AnimatedContainer Demo')),
      body: Center(
        child: AnimatedContainer(
          width: _toggled ? 200 : 100,
          height: _toggled ? 100 : 200,
          color: _toggled ? Colors.teal : Colors.orange,
          duration: Duration(seconds: 1),
          curve: Curves.easeInOut,
          child: Center(
            child: Text(
              'Tap Me!',
              style: TextStyle(color: Colors.white, fontSize: 18),
            ),
          ),
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          setState(() {
            _toggled = !_toggled;
          });
        },
        child: Icon(Icons.play_arrow),
      ),
    );
  }
}
```

**Explanation:** When you press the FAB, the container smoothly transitions between sizes and colors.

### Implementation in this App

In `lib/screens/login_screen.dart`, the login button uses `AnimatedContainer` to change its width and color upon being tapped.

```dart
GestureDetector(
  onTap: () {
    setState(() {
      _toggled = !_toggled;
    });
    _login();
  },
  child: AnimatedContainer(
    width: _toggled ? 200 : 150,
    height: 50,
    duration: const Duration(seconds: 1),
    curve: Curves.easeInOut,
    decoration: BoxDecoration(
      color: _toggled ? Colors.teal : Colors.orange,
      borderRadius: BorderRadius.circular(8),
    ),
    child: const Center(
      child: Text(
        'Login',
        style: TextStyle(color: Colors.white, fontSize: 18),
      ),
    ),
  ),
),
```

### Example 2: AnimatedOpacity

```dart
AnimatedOpacity(
  opacity: _toggled ? 1.0 : 0.3,
  duration: Duration(seconds: 1),
  child: Image.asset('assets/images/logo.png', width: 120),
);
```

This widget makes the image fade in or out smoothly when `_toggled` changes.

## 3. Explore Explicit Animations

Explicit animations give developers full control using an `AnimationController`. They’re ideal for creating loops, custom timing, or layered effects.

### Example: Rotation Animation

```dart
import 'package:flutter/material.dart';

class RotateLogoDemo extends StatefulWidget {
  @override
  _RotateLogoDemoState createState() => _RotateLogoDemoState();
}

class _RotateLogoDemoState extends State<RotateLogoDemo>
    with SingleTickerProviderStateMixin {
  late AnimationController _controller;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      duration: Duration(seconds: 2),
      vsync: this,
    )..repeat(reverse: true);
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Rotation Animation Demo')),
      body: Center(
        child: RotationTransition(
          turns: _controller,
          child: Image.asset('assets/images/logo.png', width: 100),
        ),
      ),
    );
  }
}
```

This continuously rotates the logo image using Flutter’s `RotationTransition` and `AnimationController`.

### Implementation in this App

In `lib/screens/login_screen.dart`, a `RotationTransition` is used to rotate the app logo.

```dart
RotationTransition(
  turns: _controller,
  child: Image.asset('assets/images/logo.png', width: 100),
),
```

## 4. Adding Page Transitions

Instead of abrupt screen changes, you can use animated transitions for navigation.

### Example: Slide Transition Between Screens

```dart
Navigator.push(
  context,
  PageRouteBuilder(
    transitionDuration: Duration(milliseconds: 700),
    pageBuilder: (context, animation, secondaryAnimation) => NextPage(),
    transitionsBuilder: (context, animation, secondaryAnimation, child) {
      return SlideTransition(
        position: Tween<Offset>(
          begin: const Offset(1.0, 0.0),
          end: Offset.zero,
        ).animate(CurvedAnimation(
          parent: animation,
          curve: Curves.easeInOut,
        )),
        child: child,
      );
    },
  ),
);
```

**Result:** The new screen slides in smoothly from the right. You can try other transitions like fade, scale, or rotation for creative effects.

### Implementation in this App

In `lib/screens/login_screen.dart`, a `SlideTransition` is used when navigating to the `SignupScreen`.

```dart
TextButton(
  onPressed: () {
    Navigator.push(
      context,
      PageRouteBuilder(
        transitionDuration: const Duration(milliseconds: 700),
        pageBuilder: (context, animation, secondaryAnimation) =>
            const SignupScreen(),
        transitionsBuilder:
            (context, animation, secondaryAnimation, child) {
          return SlideTransition(
            position: Tween<Offset>(
              begin: const Offset(1.0, 0.0),
              end: Offset.zero,
            ).animate(CurvedAnimation(
              parent: animation,
              curve: Curves.easeInOut,
            )),
            child: child,
          );
        },
      ),
    );
  },
  child: const Text('Don\'t have an account? Sign Up'),
),
```

## 5. Best Practices for Animations

- **Keep it meaningful** — animations should support user intent.
- **Stay fast and subtle** — aim for durations between 300–800ms.
- **Test on real devices** to avoid lag on low-end phones.
- **Use curves** like `Curves.easeInOut` for natural motion.
