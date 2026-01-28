import 'package:flutter/material.dart';
import 'package:sovietunion/widgets/app_drawer.dart';

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
        title: const Text('Soviet Union Dashboard'),
      ),
      drawer: const AppDrawer(),
      body: GridView.builder(
        padding: const EdgeInsets.all(16),
        gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
          crossAxisCount: columns,
          childAspectRatio: 1.0,
          crossAxisSpacing: 12,
          mainAxisSpacing: 12,
        ),
        itemCount: _spaces.length,
        itemBuilder: (context, index) {
          return _buildSpaceCard(_spaces[index]);
        },
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
