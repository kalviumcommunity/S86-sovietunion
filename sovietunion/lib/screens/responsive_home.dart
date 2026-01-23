import 'package:flutter/material.dart';

class ResponsiveHome extends StatelessWidget {
  const ResponsiveHome({super.key});

  @override
  Widget build(BuildContext context) {
    // Get screen dimensions using MediaQuery
    double screenWidth = MediaQuery.of(context).size.width;
    double screenHeight = MediaQuery.of(context).size.height;
    Orientation orientation = MediaQuery.of(context).orientation;
    
    // Determine if device is tablet
    bool isTablet = screenWidth > 600;
    
    // Calculate responsive values
    int columns = isTablet 
        ? (orientation == Orientation.portrait ? 3 : 4) 
        : 2;

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
        title: Text(
          'Community Dashboard',
          style: TextStyle(fontSize: isTablet ? 22 : 18),
        ),
      ),
      body: Column(
        children: [
          // Header Info Section
          _buildHeader(screenWidth, isTablet),
          
          // Main Grid Content
          Expanded(
            child: _buildGrid(columns, isTablet),
          ),
        ],
      ),
    );
  }

  // Header Section
  Widget _buildHeader(double screenWidth, bool isTablet) {
    return Container(
      width: double.infinity,
      padding: EdgeInsets.all(isTablet ? 24 : 16),
      color: Colors.blue[50],
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            'Shared Spaces',
            style: TextStyle(
              fontSize: isTablet ? 24 : 20,
              fontWeight: FontWeight.bold,
              color: Colors.blue[900],
            ),
          ),
          SizedBox(height: isTablet ? 8 : 4),
          Text(
            'Track availability of community facilities',
            style: TextStyle(
              fontSize: isTablet ? 16 : 14,
              color: Colors.blue[700],
            ),
          ),
        ],
      ),
    );
  }

  // Grid Layout
  Widget _buildGrid(int columns, bool isTablet) {
    final List<SharedSpace> spaces = [
      SharedSpace(name: 'Gym', icon: Icons.fitness_center),
      SharedSpace(name: 'Community Hall', icon: Icons.meeting_room),
      SharedSpace(name: 'Swimming Pool', icon: Icons.pool),
      SharedSpace(name: 'Parking', icon: Icons.local_parking),
      SharedSpace(name: 'Study Room', icon: Icons.menu_book),
      SharedSpace(name: 'Playground', icon: Icons.sports_soccer),
    ];

    return GridView.builder(
      padding: EdgeInsets.all(isTablet ? 20 : 16),
      gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: columns,
        childAspectRatio: 1.1,
        crossAxisSpacing: isTablet ? 16 : 12,
        mainAxisSpacing: isTablet ? 16 : 12,
      ),
      itemCount: spaces.length,
      itemBuilder: (context, index) {
        return _buildCard(spaces[index], isTablet);
      },
    );
  }

  // Individual Card
  Widget _buildCard(SharedSpace space, bool isTablet) {
    return Card(
      elevation: 3,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(12),
      ),
      child: Padding(
        padding: EdgeInsets.all(isTablet ? 16 : 12),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Flexible(
              child: Icon(
                space.icon,
                size: isTablet ? 56 : 48,
                color: Colors.blue,
              ),
            ),
            SizedBox(height: isTablet ? 12 : 8),
            Flexible(
              child: FittedBox(
                fit: BoxFit.scaleDown,
                child: Text(
                  space.name,
                  style: TextStyle(
                    fontSize: isTablet ? 18 : 16,
                    fontWeight: FontWeight.bold,
                  ),
                  textAlign: TextAlign.center,
                  maxLines: 2,
                  overflow: TextOverflow.ellipsis,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

// Model class
class SharedSpace {
  final String name;
  final IconData icon;

  SharedSpace({required this.name, required this.icon});
}
