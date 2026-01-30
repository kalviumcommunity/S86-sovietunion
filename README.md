
# Flutter Environment Setup and First App Run

This project is a Flutter application. Below are the steps followed to set up the Flutter SDK, configure the development environment, and run the first Flutter app on an emulator.

---

## Steps Followed

### 1. Install Flutter SDK
- Downloaded the Flutter SDK from the [official Flutter installation page](https://docs.flutter.dev/get-started/install).
- Extracted the SDK to `C:\src\flutter`.
- Added `C:\src\flutter\bin` to the Windows PATH environment variable.
- Verified the installation by running:
  ```
  flutter doctor
  ```

### 2. Set Up Android Studio & VS Code
- Installed Android Studio and ensured the following components were checked:
  - Android SDK
  - Android SDK Platform
  - Android Virtual Device (AVD) Manager
- Installed Flutter and Dart plugins in Android Studio (via Plugins tab).
- Installed Flutter and Dart extensions in VS Code from the Marketplace.

### 3. Configure Emulator
- Opened AVD Manager in Android Studio.
- Created a new virtual device (Pixel 6, Android 13).
- Launched the emulator.
- Verified device detection with:
  ```
  flutter devices
  ```

### 4. Create and Run First Flutter App
- Created a new Flutter project:
  ```
  flutter create first_flutter_app
  ```
- Opened the project in Android Studio/VS Code.
- Ran the app on the emulator:
  # Responsive Layouts with Rows, Columns, and Containers

  This repository contains a Flutter app that demonstrates how to build responsive layouts using `Container`, `Row`, and `Column`. The goal is to design a screen that adapts smoothly across phone and tablet sizes and both orientations.

  ## Project Title
  Responsive Layout Demo — Rows, Columns & Containers

  ## Short Explanation
  This sample shows how to structure UI using `Container` for styling, `Row` for horizontal layouts, and `Column` for vertical stacking. Responsiveness is achieved using `MediaQuery`, `Expanded`, and `Flexible` so panels stack on small screens and sit side-by-side on larger screens.

  ---

  ## Task Overview

  1. Understand Flutter’s Core Layout Widgets

  - Container: A flexible box for padding, margin, alignment, color and size.

    Example:

    ```dart
    Container(
      padding: EdgeInsets.all(16),
      color: Colors.blue,
      child: Text('This is inside a Container'),
    );
    ```

  - Row: Arranges children horizontally. Use `mainAxisAlignment` and `crossAxisAlignment`.

    ```dart
    Row(
      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
      children: [
        Icon(Icons.home),
        Icon(Icons.search),
        Icon(Icons.person),
      ],
    );
    ```

  - Column: Arranges children vertically; commonly used to stack text, images, buttons.

    ```dart
    Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Text('Welcome!'),
        SizedBox(height: 10),
        ElevatedButton(onPressed: () {}, child: Text('Click Me')),
      ],
    );
    ```

  2. Combine Layout Widgets to Build a Responsive Screen

  Create a screen `lib/screens/responsive_layout.dart` that combines `Container`, `Row`, and `Column` to form a header and two responsive panels. Example implementation:

  ```dart
  import 'package:flutter/material.dart';

  class ResponsiveLayout extends StatelessWidget {
    const ResponsiveLayout({super.key});

    @override
    Widget build(BuildContext context) {
      final screenWidth = MediaQuery.of(context).size.width;
      final isLarge = screenWidth >= 600;

      return Scaffold(
        appBar: AppBar(title: const Text('Responsive Layout')),
        body: Padding(
          padding: const EdgeInsets.all(16),
          child: Column(
            children: [
              Container(
                width: double.infinity,
                height: 150,
                decoration: BoxDecoration(
                  color: Colors.lightBlueAccent,
                  borderRadius: BorderRadius.circular(8),
                ),
                child: const Center(child: Text('Header Section', style: TextStyle(fontSize: 20))),
              ),
              const SizedBox(height: 12),
              Expanded(
                child: isLarge
                    ? Row(
                        children: [
                          Expanded(
                            child: Container(
                              color: Colors.amber,
                              child: const Center(child: Text('Left Panel')),
                            ),
                          ),
                          const SizedBox(width: 12),
                          Expanded(
                            child: Container(
                              color: Colors.greenAccent,
                              child: const Center(child: Text('Right Panel')),
                            ),
                          ),
                        ],
                      )
                    : Column(
                        children: [
                          Expanded(
                            child: Container(
                              width: double.infinity,
                              color: Colors.amber,
                              child: const Center(child: Text('Top Panel')),
                            ),
                          ),
                          const SizedBox(height: 12),
                          Expanded(
                            child: Container(
                              width: double.infinity,
                              color: Colors.greenAccent,
                              child: const Center(child: Text('Bottom Panel')),
                            ),
                          ),
                        ],
                      ),
              ),
            ],
          ),
        ),
      );
    }
  }
  ```

  This layout includes a header and a two-panel area that becomes side-by-side on wide screens and stacked on narrow screens.

  3. Make Your Layout Responsive

  - Use `MediaQuery.of(context).size.width` to adapt layout rules.
  - Use `Expanded` and `Flexible` to allocate space proportionally.
  - For small devices, stack panels vertically; for larger devices, show side-by-side panels.

  Example snippet using `MediaQuery`:

  ```dart
  double screenWidth = MediaQuery.of(context).size.width;
  Container(
    width: screenWidth > 600 ? 500 : double.infinity,
    color: Colors.blueGrey,
    child: const Text('Responsive width based on screen size'),
  );
  ```

  4. Test Across Different Screen Sizes

  - Run on a standard phone emulator (Pixel 5) and a tablet emulator (iPad/Pixel C).
  - Verify proportions, resizing, and no text cut-offs.
  - Capture screenshots for both small and large screens (portrait and landscape if possible).

  ---

  ## README Guidelines (This file)

  Include the following in your README:

  - Project Title and short explanation of your responsive layout.
  - Code snippets showing `Row`, `Column`, and `Container` usage (see above).
  - Screenshots:

    - Small screen (phone): `images/responsive_small.png`
    - Large screen (tablet/landscape): `images/responsive_large.png`

  - Reflection prompts:
    - Why is responsiveness important in mobile apps?
    - What challenges did you face while managing layout proportions?
    - How can you improve your layout for different screen orientations?

  ---

  ## Submission Guidelines

  1. Create a Pull Request (PR)

  - Commit message:

    `feat: designed responsive layout using rows, columns, and containers`

  - PR title:

    `[Sprint-2] Responsive Layout Design – TeamName`

  - PR description should include:
    - Summary of your implementation
    - Screenshots from this README (`images/responsive_small.png`, `images/responsive_large.png`)
    - Short reflection answering the prompts above

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

  If you'd like, I can also create `lib/screens/responsive_layout.dart` in this repo and add placeholder screenshots. Would you like me to add the example screen file now?

# 📱 Scrollable Views in Flutter  
### Sprint-2 Task — ListView & GridView Implementation

This project demonstrates how to build **scrollable layouts in Flutter** using two core widgets:

- **ListView** → for dynamic vertical or horizontal lists  
- **GridView** → for structured, multi-column layouts  

The goal is to design smooth, interactive, and performance-optimized UI screens such as **product catalogs, chat lists, dashboards, and photo galleries**.

---

## 🚀 Features

✅ Vertical & Horizontal scrolling  
✅ Dynamic list rendering  
✅ Grid-based layout design  
✅ Performance-optimized scrolling  
✅ Clean UI structure  
✅ Responsive layout handling  

---

## 🧠 Concepts Covered

- Scrollable widgets in Flutter  
- `ListView`  
- `ListView.builder()`  
- `GridView.count()`  
- `GridView.builder()`  
- `SingleChildScrollView`  
- `SliverGridDelegateWithFixedCrossAxisCount`  
- Performance optimization  
- Nested scrolling handling  

---

## 📂 File Structure

```bash
lib/
 └── screens/
     └── scrollable_views.dart
