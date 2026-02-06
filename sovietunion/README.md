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
Project Title: Soviet Union App — Firestore Queries, Filters & Ordering

Brief: Demonstrates Firestore queries (filters, ordering, and limits) and how to display results in Flutter using `StreamBuilder` and `FutureBuilder`.

Prerequisites:
- Ensure `cloud_firestore` is added to `pubspec.yaml` (this project uses `cloud_firestore` from pubspec):

```yaml
dependencies:
	cloud_firestore: ^6.1.2
```

- Run:

```bash
flutter pub get
```

- Firebase must already be initialized in `lib/main.dart` (e.g., `Firebase.initializeApp()`).

Implemented query types
- Equality filters: `where('status', isEqualTo: 'active')`
- Comparison filters: `where('price', isGreaterThan: 100)`
- Array filters: `where('tags', arrayContains: 'popular')`
- Ordering: `orderBy('createdAt', descending: true)` and multi-field ordering
- Limiting results: `limit(10)`

Example code snippets (from `lib/screens/firestore_read_example.dart`)

- where (equality):

```dart
query = FirebaseFirestore.instance
	.collection('tasks')
	.where('isCompleted', isEqualTo: false);
```

- arrayContains:

```dart
query = query.where('tags', arrayContains: 'popular');
```

- orderBy + limit:

```dart
query = query
	.orderBy('priority', descending: true)
	.limit(10);
```

Using StreamBuilder for live updates:

```dart
StreamBuilder<QuerySnapshot>(
	stream: query.snapshots(),
	builder: (context, snapshot) {
		if (!snapshot.hasData) return CircularProgressIndicator();
		final docs = snapshot.data!.docs;
		return ListView.builder(...);
	},
)
```

Screenshots (placeholders)
- `screenshots/firestore_console.png` — Firestore console view (add after capturing)
- `screenshots/app_firestore_list.png` — App UI showing filtered/sorted list

Reflection
- **Which query types used:** Equality (`isEqualTo`), `arrayContains`, `orderBy`, and `limit`.
- **Why sorting/filtering improves UX:** Reduces noise, surfaces relevant items first (e.g., high-priority tasks), lowers bandwidth and speeds up UI.
- **Index notes:** Using `where` and `orderBy` on different fields may require a composite index — Firestore console provides a link to create the index when needed.

What changed for this assignment
- Implemented interactive query example: `lib/screens/firestore_read_example.dart` (UI controls for `where`, `orderBy`, and `limit`).
- Updated README with specific query examples, code snippets, and reflection.

Submission notes
- Commit message: `feat: implemented Firestore queries, filters, and ordering in UI`
- PR title suggestion: `[Sprint-2] Firestore Queries & Filtering – TeamName`
- PR description should include: feature explanation, code snippets, screenshots, and reflection. 

## Cloud Functions (Serverless) Integration

This project includes a simple example of Firebase Cloud Functions (callable + Firestore trigger) and a Flutter wrapper to call the callable function.

Files added:
- `functions/index.js` — callable `sayHello` and Firestore `newUserCreated` trigger.
- `lib/services/functions_service.dart` — simple Dart wrapper to call the `sayHello` function.

Cloud Function: `functions/index.js`

```js
const functions = require('firebase-functions');
const admin = require('firebase-admin');
admin.initializeApp();

exports.sayHello = functions.https.onCall((data, context) => {
	const name = data.name || 'User';
	return { message: `Hello, ${name}!` };
});

exports.newUserCreated = functions.firestore
	.document('users/{userId}')
	.onCreate((snap, context) => {
		const data = snap.data();
		console.log('New user created:', data);
		return null;
	});
```

Flutter callable invocation (`lib/services/functions_service.dart`):

```dart
import 'package:cloud_functions/cloud_functions.dart';

class FunctionsService {
	static final FirebaseFunctions _functions = FirebaseFunctions.instance;

	static Future<String> sayHello(String name) async {
		final callable = _functions.httpsCallable('sayHello');
		final result = await callable.call({'name': name});
		final data = result.data as Map<String, dynamic>?;
		return data?['message'] as String? ?? '';
	}
}
```

How to deploy (local dev machine):

1. Install Firebase CLI:

```bash
npm install -g firebase-tools
firebase login
```

2. Initialize functions (if not already):

```bash
cd sovietunion
firebase init functions
```

3. Deploy only functions:

```bash
firebase deploy --only functions
```

Testing & verification:
- Call `FunctionsService.sayHello('Alex')` from UI code and display the returned message.
- Create a new document in `users/` collection to trigger `newUserCreated` and check logs in Firebase Console → Functions → Logs.

Screenshots to include in PR:
- `screenshots/functions_logs.png` — Firebase Functions logs showing execution
- `screenshots/app_sayhello.png` — App UI showing the returned message from callable function

Reflection:
- Serverless functions reduce backend overhead by removing server management, scaling automatically, and integrating with Firebase services.
- This implementation includes both a callable function (invoked from Flutter) and an event-triggered function (Firestore `onCreate`).
- Real-world use cases: sending welcome emails/notifications, sanitizing user input, generating derived data, running background data processing.


