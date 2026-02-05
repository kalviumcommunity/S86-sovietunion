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

## Scrollable Views Screen

A new screen `lib/screens/scrollable_views.dart` was added to demonstrate scrollable layouts:

- A horizontal `ListView.builder` showcasing simple cards.
- A `GridView.builder` embedded in a `SingleChildScrollView` for a vertical tile layout.

Navigate to it from the Dashboard using the floating action button (bottom-right).

PR: https://github.com/kalviumcommunity/S86-sovietunion/pull/11

Video demo: https://drive.google.com/file/d/1yP5PWrsDOqB1FxT_gwRahE76EK0P8kJ7/view?usp=drive_link

## State Management Demo

I added `lib/screens/state_management_demo.dart` — a small `StatefulWidget` counter demonstrating local state management with `setState()`.

Key behaviors:

- Increment, decrement, and reset the counter.
- Conditional UI: background color changes when `_counter >= 5`.

Code snippet:

```dart
class StateManagementDemo extends StatefulWidget { ... }

class StateManagementDemoState extends State<StateManagementDemo> {
	int _counter = 0;

	void _incrementCounter() {
		setState(() { _counter++; });
	}

	void _decrementCounter() {
		setState(() { if (_counter > 0) _counter--; });
	}
}
```

Navigate to the demo from the Dashboard via the "State Management Demo" button.

Reflection prompts to include in PR description:

- Difference between `StatelessWidget` and `StatefulWidget`.
- Why `setState()` is required to update the UI.
- How improper `setState()` use can lead to performance issues.

## Firebase SDK Integration (FlutterFire CLI)

This project includes Firebase SDKs configured using the FlutterFire CLI. The CLI automates generating platform-specific configuration and wiring it into your Flutter app.

**What is FlutterFire CLI?**

- **Description:** A command-line tool that generates `firebase_options.dart` and configures Android, iOS, macOS and Web build files to connect your app to a Firebase project.
- **Benefits:** prevents manual mistakes, supports multi-platform in one command, keeps SDK setup consistent.

**Quick Install & Setup**

- Prerequisites: `flutter` and `dart` on PATH, and `node` + `npm` for Firebase tools.
- Install Firebase CLI (if needed):

```bash
npm install -g firebase-tools
```

- Install FlutterFire CLI:

```bash
dart pub global activate flutterfire_cli
```

- Verify:

```bash
flutterfire --version
```

**Login & Configure (run inside project root)**

```bash
firebase login
flutterfire configure
```

The `flutterfire configure` command will detect your Firebase projects, allow you to select the correct one, and generate `lib/firebase_options.dart` with platform credentials.

**Dependencies**

This project already includes Firebase dependencies in `pubspec.yaml`:

- `firebase_core` (required)
- `firebase_auth`
- `cloud_firestore`

Run:

```bash
flutter pub get
```

**Initialize Firebase**

Use the generated `lib/firebase_options.dart` when initializing Firebase. Example `main.dart` initialization used in this project:

```dart
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'firebase_options.dart';

void main() async {
	WidgetsFlutterBinding.ensureInitialized();
	await Firebase.initializeApp(
		options: DefaultFirebaseOptions.currentPlatform,
	);
	runApp(const MyApp());
}
```

After the app starts you should see the app run normally and Firebase logs indicating initialization.

**Verify Integration**

- Run the app:

```bash
flutter run
```

- Confirm the UI loads and the console contains messages like `Firebase initialized with DefaultFirebaseOptions`.
- Check Firebase Console → Project Settings → Your Apps — the app should appear as a registered instance.

**Adding Other Firebase SDKs**

- Example dependencies you can add to `pubspec.yaml`:

```yaml
cloud_firestore: ^5.0.0
firebase_auth: ^5.0.0
firebase_analytics: ^11.0.0
```

Then run `flutter pub get`. New SDKs will use credentials from `firebase_options.dart`.

**Common Issues & Fixes**

- `flutterfire` not recognized — add `~/.pub-cache/bin` to your PATH.
- Firebase not initialized — ensure you `await Firebase.initializeApp(...)` before `runApp()`.
- Android build fails — ensure Google Services plugin is applied (`com.google.gms.google-services`) and `google-services.json` exists for Android.
- Project mismatch — re-run `flutterfire configure` and select the correct Firebase project.

**Submission / PR Guidelines**

- Commit message: `feat: integrated Firebase SDKs using FlutterFire CLI`
- PR title: `[Sprint-2] Firebase SDK Integration with FlutterFire CLI – TeamName`
- PR description should include:
	- Steps performed (install, login, configure, initialize)
	- Terminal screenshot or log showing `flutterfire configure` success
	- Link to a short demo video (1–2 minutes) showing terminal commands, `firebase_options.dart`, and the running app
	- Reflection answers: how the CLI simplified setup, any errors faced and fixes, and why CLI is preferred over manual config

**Recording Tip**

Record a short screen capture showing `flutterfire configure` and `flutter run`. Upload to Drive, Loom, or YouTube (unlisted) and include the link in the PR.

---

If you want, I can:

- Add a short screenshot placeholder and sample PR body to this README.
- Create a branch and commit these README + `main.dart` changes and provide the exact git commands to create the PR.

## Firebase Authentication (Email & Password)

This project includes an Email & Password authentication flow using Firebase Authentication. The implementation uses `firebase_auth` via an `AuthService` at `lib/services/auth_service.dart` and UI screens at `lib/screens/login_screen.dart` and `lib/screens/signup_screen.dart`.

1. Enable Authentication in Firebase Console

- Go to Firebase Console → Authentication → Sign-in method.
- Enable **Email/Password** and save.

2. Dependencies

This repo already includes Firebase packages in `pubspec.yaml` (adjust versions as needed):

- `firebase_core`
- `firebase_auth`
- `cloud_firestore` (optional)

Run:

```bash
flutter pub get
```

3. Initialize Firebase

Ensure Firebase is initialized before using auth APIs. `lib/main.dart` already initializes Firebase using the generated `firebase_options.dart`:

```dart
void main() async {
	WidgetsFlutterBinding.ensureInitialized();
	await Firebase.initializeApp(
		options: DefaultFirebaseOptions.currentPlatform,
	);
	runApp(const MyApp());
}
```

4. Auth Screens and Service

- `lib/services/auth_service.dart` — wrapper around `FirebaseAuth` with `signUp`, `signIn`, and `signOut` methods.
- `lib/screens/login_screen.dart` — login form that calls `AuthService().signIn(...)` and routes to `DashboardScreen` on success.
- `lib/screens/signup_screen.dart` — signup form that calls `AuthService().signUp(...)` and routes to `DashboardScreen` on success.

Example auth service (already present):

```dart
final FirebaseAuth _auth = FirebaseAuth.instance;

Future<User?> signUp(String email, String password) async {
	final credential = await _auth.createUserWithEmailAndPassword(
		email: email,
		password: password,
	);
	return credential.user;
}
```

5. Verify Authentication

- Sign up via the app; then open Firebase Console → Authentication → Users to see the new user.
- The `DashboardScreen` displays the current user email via `FirebaseAuth.instance.currentUser` and provides a logout button that calls `AuthService().signOut()`.

6. Auth State Listener

You can observe auth state globally using:

```dart
FirebaseAuth.instance.authStateChanges().listen((User? user) {
	if (user == null) {
		print('User is signed out');
	} else {
		print('User is signed in: \\${user.email}');
	}
});
```

7. Common Issues & Fixes

- `ERROR_INVALID_EMAIL` — ensure a valid email format.
- Password must be at least 6 characters — enforce client-side validation.
- Firebase not initialized — ensure `await Firebase.initializeApp()` before using `FirebaseAuth`.
- App crashes on sign-in — verify package versions and run `flutter pub get`.

8. README / PR Guidelines

- Commit message: `feat: implemented Firebase Auth (email & password)`
- PR title: `[Sprint-2] Firebase Authentication (Email & Password) – TeamName`
- PR description checklist:
	- Steps performed (enable in console, install deps, initialize, implement auth screens)
	- Screenshot of Firebase Console → Authentication → Users showing the registered email(s)
	- Short reflection on implementation and any errors/fixes
	- Link to 1–2 minute demo video showing signup/login and Firebase Console

If you'd like, I can prepare the PR body text and add a placeholder screenshot file to the repo.

## Firestore Write & Update Operations

This project includes a new `Tasks` screen that demonstrates how to safely write and update documents in Cloud Firestore.

- **File:** `lib/screens/tasks_screen.dart`
- **Collection used:** `tasks`

Add (auto-generated ID):

```dart
await FirebaseFirestore.instance.collection('tasks').add({
	'title': title,
	'description': desc,
	'isCompleted': false,
	'createdAt': Timestamp.now(),
});
```

Set (specific ID — example merge):

```dart
await FirebaseFirestore.instance
	.collection('tasks')
	.doc('taskId123')
	.set({'title': 'New Task'}, SetOptions(merge: true));
```

Update (modify specific fields):

```dart
await FirebaseFirestore.instance
	.collection('tasks')
	.doc('taskId123')
	.update({'completed': true});
```

Input form (from `TasksScreen`):

```dart
TextFormField(controller: _titleController, validator: (v) => v==null||v.trim().isEmpty? 'Required' : null)
TextFormField(controller: _descController, validator: (v) => v==null||v.trim().isEmpty? 'Required' : null)
ElevatedButton(onPressed: _addTask, child: Text('Add Task'))
```

Add operation (from `TasksScreen`):

```dart
Future<void> _addTask() async {
	if (!_formKey.currentState!.validate()) return;
	await FirebaseFirestore.instance.collection('tasks').add({
		'title': title,
		'description': desc,
		'isCompleted': false,
		'createdAt': Timestamp.now(),
	});
}
```

Update operation (from `TasksScreen`):

```dart
await FirebaseFirestore.instance.collection('tasks').doc(id).update({
	'title': newTitle,
	'description': newDesc,
	'updatedAt': Timestamp.now(),
});
```

Best practices demonstrated:

- Validate user input before writing (form validators).
- Use `Timestamp.now()` to record `createdAt` and `updatedAt`.
- Use `update()` to avoid accidental overwrites; use `set(..., SetOptions(merge: true))` for partial merges.
- Wrap writes in `try/catch` and show user-friendly errors via `SnackBar`.

Testing steps:

1. Run the app (`flutter run`).
2. Open the `Tasks` screen.
3. Add a task using the form — confirm it appears in Firestore Console under `tasks`.
4. Tap edit on a task, change fields and save — confirm fields update in Firestore.

## Real-Time Sync (Snapshot Listeners)

This app demonstrates real-time updates using Firestore snapshot listeners.

Collection listener (used in `TasksScreen`):

```dart
StreamBuilder<QuerySnapshot>(
	stream: FirebaseFirestore.instance.collection('tasks').snapshots(),
	builder: (context, snapshot) { /* build list from snapshot.data!.docs */ }
)
```

Document listener (used in `TaskDetailScreen`):

```dart
StreamBuilder<DocumentSnapshot>(
	stream: FirebaseFirestore.instance.collection('tasks').doc(taskId).snapshots(),
	builder: (context, snapshot) { /* show single doc fields */ }
)
```

Manual change detection using `listen()` and `docChanges` (optional, used by toggle in `TasksScreen`):

```dart
final sub = FirebaseFirestore.instance
	.collection('tasks')
	.snapshots()
	.listen((snapshot) {
		for (var change in snapshot.docChanges) {
			if (change.type == DocumentChangeType.added) print('New');
			if (change.type == DocumentChangeType.modified) print('Updated');
			if (change.type == DocumentChangeType.removed) print('Removed');
		}
	});
// sub.cancel() when no longer needed
```

UX tips:

- Use `StreamBuilder` for UI-bound live updates — it automatically rebuilds on changes.
- Use `.listen()` for side effects (showing snackbars, triggering local notifications).
- Always handle empty/loading states as shown in `TasksScreen`.

Testing real-time behavior:

1. Open `Tasks` screen in app.
2. Enable live notifications (bell icon in AppBar) to see snackbars on add/update/remove.
3. Add a document via the app or Firestore Console — UI updates immediately.
4. Edit a document in the Console — `TaskDetailScreen` reflects changes instantly.


Reflection:

- Secure writes matter to prevent accidental data loss and maintain data integrity; prefer `update()` for partial changes.
- `add()` creates a document with an auto-generated ID; `set()` writes a document at a specific ID (overwrites by default); `update()` changes only specified fields and fails if the document doesn't exist.
- Validation prevents empty or malformed records from being saved, reducing data corruption and simplifying rules.



