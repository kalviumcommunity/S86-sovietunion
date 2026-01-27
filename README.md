
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
  ```
  flutter run
  ```
- Observed the default Flutter counter app running on the emulator.

---

## Setup Verification

### Flutter Doctor Output
![Flutter Doctor Output](images/flutter_doctor_screenshot.png)

### Running App on Emulator
![Flutter App Running on Emulator](images/emulator_screenshot.png)

---

## Reflection

**Challenges Faced:**
- Configuring the PATH variable correctly on Windows.
- Downloading the correct system image for the emulator.
- Ensuring all dependencies (Java, Android SDK) were properly installed.

**How this setup prepares for real app development:**
- With the environment ready, building and testing Flutter apps becomes seamless.
- Emulator setup allows for rapid UI/UX testing without a physical device.
- All future Flutter and Firebase integrations can be developed and debugged efficiently.

---

## Project Structure (Reference)

The project follows a feature-driven directory structure to promote modularity and scalability:

```
lib/
├── main.dart          # Entry point of your app
├── screens/           # Individual UI screens for each feature
├── widgets/           # Reusable UI components shared across the app
├── models/            # Data models representing the app's data structures
├── services/          # Business logic, API calls, and other services
```

---

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
