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
- UI elements that do not change during runtime

### Example:
```dart
class HeaderWidget extends StatelessWidget {
  const HeaderWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return const Text(
      'Interactive Counter App',
      style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
    );
  }
}


# Hot Reload, Debug Console, and Flutter DevTools in Flutter

## 📌 Project Overview
This module demonstrates how to effectively use **Hot Reload**, the **Debug Console**, and **Flutter DevTools** to improve development speed, debugging efficiency, and performance analysis in Flutter applications. These tools are essential for building, testing, and maintaining scalable Flutter apps.

This task is part of **Sprint #2** and focuses on practical usage of Flutter’s development and debugging ecosystem.

---

## ⚡ Hot Reload

**Hot Reload** allows developers to instantly apply code changes to a running Flutter app without restarting it or losing the current state. This makes UI development fast and interactive.

### Steps Performed:
1. Ran the Flutter app using `flutter run`
2. Modified a widget’s text and color
3. Applied Hot Reload using:
   - Pressing `r` in the terminal
   - Or clicking the ⚡ Hot Reload button in the IDE
4. Observed the UI update instantly while preserving app state

### Example:
```dart
// Before
Text('Hello, Flutter!');

// After
Text('Welcome to Hot Reload!');
