import 'package:flutter/material.dart';
import 'package:sovietunion/services/auth_service.dart';
import 'package:sovietunion/screens/login_screen.dart';
import 'package:sovietunion/screens/scrollable_views.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:sovietunion/widgets/info_card.dart';
import 'package:sovietunion/widgets/custom_button.dart';

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
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            InfoCard(
              title: 'Account',
              subtitle: 'Logged in as ${user?.email ?? 'Guest'}',
              icon: Icons.person,
            ),
            const SizedBox(height: 12),
            InfoCard(
              title: 'Progress',
              subtitle: 'Open tasks and assignments',
              icon: Icons.insights,
            ),
            const SizedBox(height: 20),
            CustomButton(
              label: 'Open Scrollable Views',
              onPressed: () {
                Navigator.of(context).push(
                  MaterialPageRoute(builder: (context) => const ScrollableViewsScreen()),
                );
              },
            ),
          ],
        ),
      ),
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
