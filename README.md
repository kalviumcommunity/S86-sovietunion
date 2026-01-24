
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
