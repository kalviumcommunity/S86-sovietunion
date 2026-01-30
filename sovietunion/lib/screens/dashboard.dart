import 'package:flutter/material.dart';
import 'package:sovietunion/services/auth_service.dart';
import 'package:sovietunion/screens/login_screen.dart';
import 'package:sovietunion/screens/scrollable_views.dart';
import 'package:firebase_auth/firebase_auth.dart';

class DashboardScreen extends StatelessWidget {
  const DashboardScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Dashboard'),
        actions: [
          IconButton(
            icon: const Icon(Icons.logout),
            onPressed: () {
              Navigator.of(context).pushReplacementNamed('/login');
            },
          ),
        ],
      ),
      body: Center(child: Text('Welcome, ${user?.email ?? 'Guest'}!')),
      floatingActionButton: FloatingActionButton(
        tooltip: 'Scrollable Views',
        child: const Icon(Icons.view_stream),
        onPressed: () {
          Navigator.of(context).push(
            MaterialPageRoute(builder: (context) => const ScrollableViewsScreen()),
          );
        },
      ),
    );
  }
}
