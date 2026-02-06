import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:sovietunion/screens/storage_screen.dart';

class Dashboard extends StatefulWidget {
  const Dashboard({super.key});

  @override
  State<Dashboard> createState() => _DashboardState();
}

class _DashboardState extends State<Dashboard> {
  // Sample data for shared spaces
  final List<SharedSpace> _spaces = [
    SharedSpace(name: 'Gym', icon: Icons.fitness_center),
    SharedSpace(name: 'Community Hall', icon: Icons.meeting_room),
    SharedSpace(name: 'Swimming Pool', icon: Icons.pool),
    SharedSpace(name: 'Parking', icon: Icons.local_parking),
    SharedSpace(name: 'Study Room', icon: Icons.menu_book),
    SharedSpace(name: 'Playground', icon: Icons.sports_soccer),
  ];

  @override
  Widget build(BuildContext context) {
    // Get screen dimensions using MediaQuery
    double screenWidth = MediaQuery.of(context).size.width;

    // Determine if device is tablet
    bool isTablet = screenWidth > 600;

    // Calculate responsive grid columns
    int columns = isTablet ? 3 : 2;

    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: Colors.blue,
        foregroundColor: Colors.white,
        elevation: 0,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back),
          onPressed: () => Navigator.pop(context),
        ),
        title: const Text('Soviet Union Dashboard'),
        actions: [
          IconButton(
            icon: const Icon(Icons.exit_to_app),
            onPressed: () {
              FirebaseAuth.instance.signOut();
            },
          ),
        ],
      ),
      body: GridView.builder(
        padding: const EdgeInsets.all(16),
        gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
          crossAxisCount: columns,
          childAspectRatio: 1.0,
          crossAxisSpacing: 12,
          mainAxisSpacing: 12,
        ),
        itemCount: _spaces.length + 1,
        itemBuilder: (context, index) {
          if (index == _spaces.length) {
            return _buildAddStorageCard();
          }
          return _buildSpaceCard(_spaces[index]);
        },
      ),
    );
  }

  Widget _buildAddStorageCard() {
    return GestureDetector(
      onTap: () {
        Navigator.push(
          context,
          MaterialPageRoute(builder: (context) => const StorageScreen()),
        );
      },
      child: Card(
        elevation: 2,
        child: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: const [
              Icon(Icons.storage, size: 48, color: Colors.blue),
              SizedBox(height: 12),
              Text(
                'Firebase Storage',
                style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
                textAlign: TextAlign.center,
                maxLines: 2,
                overflow: TextOverflow.ellipsis,
              ),
            ],
          ),
        ),
      ),
    );
  }

  // Simple Space Card
  Widget _buildSpaceCard(SharedSpace space) {
    return Card(
      elevation: 2,
      child: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(space.icon, size: 48, color: Colors.blue),
            const SizedBox(height: 12),
            Text(
              space.name,
              style: const TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
              textAlign: TextAlign.center,
              maxLines: 2,
              overflow: TextOverflow.ellipsis,
            ),
          ],
        ),
      ),
    );
  }
}

// Simple model class
class SharedSpace {
  final String name;
  final IconData icon;

  SharedSpace({required this.name, required this.icon});
}
