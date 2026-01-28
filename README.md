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
  itemBuilder: (context, index) {
    return ListTile(
      leading: CircleAvatar(child: Text('${index + 1}')),
      title: Text('Item $index'),
      subtitle: Text('This is item number $index'),
    );
  },
);
```

### 2. GridView — Grids for Images or Cards
GridView displays scrollable grid layouts. Use `GridView.builder` for large or dynamic grids.

Fixed count example:

```dart
GridView.count(
  crossAxisCount: 2,
  crossAxisSpacing: 10,
  mainAxisSpacing: 10,
  children: [
    Container(color: Colors.red, height: 100),
    Container(color: Colors.green, height: 100),
    Container(color: Colors.blue, height: 100),
    Container(color: Colors.yellow, height: 100),
  ],
);
```

Using `GridView.builder`:

```dart
GridView.builder(
  gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
    crossAxisCount: 2,
    crossAxisSpacing: 8,
    mainAxisSpacing: 8,
  ),
  itemCount: 8,
  itemBuilder: (context, index) {
    return Container(
      color: Colors.primaries[index % Colors.primaries.length],
      child: Center(child: Text('Item $index')),
    );
  },
);
```

### 3. Combined Example (`scrollable_views.dart`)
Place this example in `lib/screens/scrollable_views.dart` to show both a horizontal `ListView` and a vertical `GridView` on one screen.

```dart
import 'package:flutter/material.dart';

class ScrollableViews extends StatelessWidget {
  const ScrollableViews({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Scrollable Views')),
      body: SingleChildScrollView(
        child: Column(
          children: [
            Container(
              padding: const EdgeInsets.all(8),
              child: const Text('ListView Example', style: TextStyle(fontSize: 18)),
            ),
            SizedBox(
              height: 200,
              child: ListView.builder(
                scrollDirection: Axis.horizontal,
                itemCount: 5,
                itemBuilder: (context, index) {
                  return Container(
                    width: 150,
                    margin: const EdgeInsets.all(8),
                    color: Colors.teal[100 * (index + 2)],
                    child: Center(child: Text('Card $index')),
                  );
                },
              ),
            ),
            const Divider(thickness: 2),
            Container(
              padding: const EdgeInsets.all(8),
              child: const Text('GridView Example', style: TextStyle(fontSize: 18)),
            ),
            SizedBox(
              height: 400,
              child: GridView.builder(
                physics: const NeverScrollableScrollPhysics(),
                shrinkWrap: true,
                gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: 2,
                  crossAxisSpacing: 10,
                  mainAxisSpacing: 10,
                ),
                itemCount: 6,
                itemBuilder: (context, index) {
                  return Container(
                    color: Colors.primaries[index % Colors.primaries.length],
                    child: Center(
                      child: Text(
                        'Tile $index',
                        style: const TextStyle(color: Colors.white, fontWeight: FontWeight.bold),
                      ),
                    ),
                  );
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}
```

### 4. Testing & Screenshots
- Run the app on different devices/emulators and verify:
  - `ListView` scrolls smoothly (horizontal or vertical as used).
  - `GridView` items are evenly spaced and wrap or scroll as expected.
- Capture screenshots showing the horizontal list and the grid view.

Add screenshots to this repo (e.g., `assets/screenshots/`) and reference them below.

### 5. Reflection
- **How they improve efficiency:** `ListView` and `GridView` provide lazy layout engines (especially with builder constructors) that render only visible items, reducing memory and CPU usage.
- **Why builders are recommended:** `ListView.builder` and `GridView.builder` create widgets on demand, improving performance for large data sets by avoiding building the entire list/grid at once.
- **Common pitfalls:** Nesting multiple scrollable widgets without constraints, not using `shrinkWrap`/`physics` correctly, and building complex widgets per item without optimization (e.g., expensive rebuilds) can harm performance.

## README Snippets / Screenshots
- Example ListView and GridView code are shown above.
- Add screenshots here once captured:

![ListView Example](assets/screenshots/listview_example.png)
![GridView Example](assets/screenshots/gridview_example.png)

## Submission Guidelines

- Commit message suggestion:

```
feat: implemented scrollable layouts using ListView and GridView
```

- PR title suggestion:

```
[Sprint-2] Scrollable Views with ListView & GridView – TeamName
```

- PR description should include:
  - A short summary of the implementation.
  - Screenshots from this README.
  - A short reflection on what you learned.
  - A link to the demo video (1–2 minutes) hosted on Google Drive, Loom, or YouTube (unlisted). Ensure the link is set to "Anyone with the link" and has Edit access for Google Drive.

## Notes
- This README update focuses on documentation. The example `scrollable_views.dart` is included as a reference snippet; create the file under `lib/screens/` if you want to run the demo.

---

Previous sections about responsive design, widgets, and debugging remain useful and can be referenced as needed.
