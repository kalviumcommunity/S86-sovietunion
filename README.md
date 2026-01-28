
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

  2. Record a Short Video Demo (1–2 minutes)

  - Demonstrate the app adapting across screen sizes and orientations.
  - Mention how `Row`, `Column`, `Container`, `MediaQuery`, and `Expanded` are used.
  - Upload to Google Drive, Loom, or YouTube (unlisted) and include the link in your PR description.

  ---

  ## Resources

  - Flutter Layout Basics: https://flutter.dev/docs/development/ui/layout
  - Building Responsive Apps in Flutter: https://flutter.dev/docs/development/ui/layout/responsive
  - MediaQuery Class Reference: https://api.flutter.dev/flutter/widgets/MediaQuery-class.html

  ---

  ## Placeholders / Next Steps

  - Add `lib/screens/responsive_layout.dart` (example provided above) if not present.
  - Add screenshots to `S86-sovietunion/images/responsive_small.png` and `S86-sovietunion/images/responsive_large.png`.
  - Commit and open PR following the guidelines above.

  ---

  ## Reflection (example answers)

  - **Why is responsiveness important?** Mobile devices vary greatly in screen size and pixel density; responsive design ensures consistent usability and appearance across devices.
  - **Challenges faced:** Managing proportions and spacing without hard-coded sizes; ensuring text scales and doesn't overflow.
  - **Improvements:** Use `LayoutBuilder` for even finer control, add breakpoints for multiple widths, and tune typography with `MediaQuery` or `flutter_screenutil`.

  ---

  If you'd like, I can also create `lib/screens/responsive_layout.dart` in this repo and add placeholder screenshots. Would you like me to add the example screen file now?
