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

## Responsive Design (MediaQuery + LayoutBuilder)

This project includes a responsive screen implementation using `MediaQuery`
and `LayoutBuilder` to adapt UI across phone and tablet sizes. The main
example is `lib/screens/responsive_home.dart` which switches layouts based
on `constraints.maxWidth` (from `LayoutBuilder`) while using
`MediaQuery` for device metrics and orientation.

Key snippet:

```dart
// inside build()
return LayoutBuilder(
	builder: (context, constraints) {
		final isTablet = constraints.maxWidth >= 600;
		final orientation = MediaQuery.of(context).orientation;

		final int columns = isTablet
			? (orientation == Orientation.portrait ? 3 : 4)
			: 2;

		// build header and grid using computed values
	},
);
```

## Asset Management (images & icons)

This project demonstrates how to add and use local assets (images and icons).

1. Folder structure (create under project root):

```
assets/
	images/
		logo.png
		banner.jpg
	icons/
		star.png
		profile.png
```

2. Registration: `pubspec.yaml` now includes:

```yaml
flutter:
	assets:
		- assets/images/
		- assets/icons/
```

3. Demo screen: `lib/screens/asset_demo.dart` shows usage of `Image.asset` and built-in `Icon` widgets.

Example snippet:

```dart
Image.asset('assets/images/logo.png', width: 140, height: 140, fit: BoxFit.cover)
Icon(Icons.flutter_dash, color: Colors.blue)
```

4. Notes & common issues:

- Ensure correct indentation in `pubspec.yaml` (2 spaces).
- Run `flutter pub get` after adding assets.
- If images don't appear, confirm file paths and that assets are present.

## Test Cases

- **Logged-in state persists after restart:**
  1.  Open the app.
  2.  Log in.
  3.  Close the app completely.
  4.  Reopen the app.
  5.  **Expected:** The app should open directly to the `Dashboard` screen.

- **Logged-out state persists after restart:**
  1.  Open the app and log in.
  2.  Log out from the `Dashboard`.
  3.  Close the app completely.
  4.  Reopen the app.
  5.  **Expected:** The app should open to the `AuthScreen`.

- **Session changes reflect immediately:**
  1.  Log in to the app.
  2.  You should be on the `Dashboard`.
  3.  Press the logout button.
  4.  **Expected:** You should be immediately redirected to the `AuthScreen`.

- **No flickering or incorrect routing:**
  1.  Open the app when logged out.
  2.  **Expected:** The `AuthScreen` should be displayed without any brief flashes of the `Dashboard`.
  3.  Log in.
  4.  **Expected:** The `Dashboard` should be displayed without any brief flashes of the `AuthScreen`.

You can capture screenshots from emulators (phone and tablet), add them to `screenshots/`, and reference them in the PR description.

Add screenshots of the demo and your `pubspec.yaml` snippet to the `screenshots/` folder for the PR.
