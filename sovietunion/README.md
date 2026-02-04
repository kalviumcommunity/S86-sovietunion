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

What to add to README for submission:
- Screenshots: `screenshots/phone.png` and `screenshots/tablet.png` (place them here)
- Short reflection on why responsiveness matters and how the implementation uses `MediaQuery` vs `LayoutBuilder`.

Reflection (short):

- **Why responsive matters:** Ensures layouts adapt to various screen sizes, improving usability and preventing overflow issues.
- **LayoutBuilder vs MediaQuery:** `LayoutBuilder` uses parent constraints to decide layout structure; `MediaQuery` provides raw device metrics for sizing and scaling.
- **Team usage:** Use `LayoutBuilder` to change widget trees for breakpoints and `MediaQuery` for proportional sizing (padding, font scaling).

You can capture screenshots from emulators (phone and tablet), add them to `screenshots/`, and reference them in the PR description.

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

Add screenshots of the demo and your `pubspec.yaml` snippet to the `screenshots/` folder for the PR.

## Firestore Read Operations (Live Data Display)

Project Title: Soviet Union App — Firestore Read Demo

Brief: This section demonstrates how the app reads data from Cloud Firestore and displays it in real time using `cloud_firestore`.

Prerequisites:
- Ensure `cloud_firestore` is added to `pubspec.yaml`:

```yaml
dependencies:
	cloud_firestore: ^5.0.0
```

- Run:

```bash
flutter pub get
```

- Firebase must already be initialized in `lib/main.dart` (e.g., `Firebase.initializeApp()`).

Code snippets

- Collection read (one-time):

```dart
final snapshot = await FirebaseFirestore.instance
		.collection('products')
		.get();

for (var doc in snapshot.docs) {
	print(doc.data());
}
```

- Document read (one-time):

```dart
final doc = await FirebaseFirestore.instance
		.collection('users')
		.doc('userId')
		.get();

print(doc.data());
```

- Real-time collection stream with `StreamBuilder` (recommended):

```dart
StreamBuilder<QuerySnapshot>(
	stream: FirebaseFirestore.instance.collection('tasks').snapshots(),
	builder: (context, snapshot) {
		if (!snapshot.hasData) return CircularProgressIndicator();

		final tasks = snapshot.data!.docs;

		return ListView.builder(
			itemCount: tasks.length,
			itemBuilder: (context, index) {
				final task = tasks[index].data() as Map<String, dynamic>;
				return ListTile(
					title: Text(task['title'] ?? 'No title'),
					subtitle: Text(task['description'] ?? ''),
				);
			},
		);
	},
);
```

- Single document in UI using `FutureBuilder`:

```dart
FutureBuilder<DocumentSnapshot>(
	future: FirebaseFirestore.instance.collection('users').doc('userId').get(),
	builder: (context, snapshot) {
		if (!snapshot.hasData) return CircularProgressIndicator();

		final data = snapshot.data!.data() as Map<String, dynamic>?;
		if (data == null) return Text('No data');

		return Text("Name: ${data['name'] ?? 'Unknown'}");
	},
);
```

Screenshots (add to `screenshots/`):
- `screenshots/firestore_console.png` — Firestore data in Firebase Console
- `screenshots/app_firestore_list.png` — App UI showing Firestore data

Reflection

- **Read method used:** Real-time streams (`snapshots()`) for live lists and `FutureBuilder` for one-time profile/document reads.
- **Why streams:** Streams automatically update the UI when data changes in Firestore — ideal for chat, dashboards, and live lists without manual refresh.
- **Challenges faced:** Null-safety checks for missing fields and ensuring Firebase is initialized before reads. Use defensive coding: `?.`, `??`, and explicit type casts.

What I changed for this assignment

- Added example Firestore read widget: `lib/screens/firestore_read_example.dart` (see file).
- Updated this README with code snippets, screenshot placeholders, and a short reflection.

Submission notes

- Commit message: `feat: implemented Firestore read operations for live data display`
- PR title suggestion: `[Sprint-2] Firestore Read Operations – TeamName`
- PR description should include: collections/documents read, code snippets, screenshots, and the reflection above.

