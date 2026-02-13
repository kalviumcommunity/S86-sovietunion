import 'package:flutter/material.dart';

/// A self-contained demo of BottomNavigationBar with PageView and
/// an IndexedStack option for state preservation.
///
/// Usage:
/// Add `BottomNavigationDemo()` to your widget tree (for example in
/// `home:` of your `MaterialApp`).
class BottomNavigationDemo extends StatefulWidget {
  /// When true, uses `IndexedStack` to preserve child state.
  /// When false, uses `PageView` with a `PageController` (supports swiping).
  final bool useIndexedStack;

  const BottomNavigationDemo({Key? key, this.useIndexedStack = false}) : super(key: key);

  @override
  State<BottomNavigationDemo> createState() => _BottomNavigationDemoState();
}

class _BottomNavigationDemoState extends State<BottomNavigationDemo> {
  final PageController _pageController = PageController();
  int _currentIndex = 0;

  // Define your app's main screens once, outside of build, to avoid
  // recreating them and to keep state consistent.
  late final List<Widget> _screens = const [
    _DemoHomeScreen(),
    _DemoSearchScreen(),
    _DemoFavoritesScreen(),
    _DemoProfileScreen(),
  ];

  void _onTap(int index) {
    if (widget.useIndexedStack) {
      setState(() => _currentIndex = index);
    } else {
      _pageController.animateToPage(
        index,
        duration: const Duration(milliseconds: 300),
        curve: Curves.easeInOut,
      );
    }
  }

  @override
  void dispose() {
    _pageController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Bottom Navigation Demo')),
      body: widget.useIndexedStack
          ? IndexedStack(index: _currentIndex, children: _screens)
          : PageView(
              controller: _pageController,
              children: _screens,
              onPageChanged: (index) => setState(() => _currentIndex = index),
              physics: const BouncingScrollPhysics(),
            ),
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: _currentIndex,
        onTap: _onTap,
        type: BottomNavigationBarType.fixed,
        selectedItemColor: Theme.of(context).colorScheme.primary,
        unselectedItemColor: Colors.grey,
        showUnselectedLabels: false,
        items: const [
          BottomNavigationBarItem(icon: Icon(Icons.home), label: 'Home'),
          BottomNavigationBarItem(icon: Icon(Icons.search), label: 'Search'),
          BottomNavigationBarItem(icon: Icon(Icons.favorite), label: 'Favorites'),
          BottomNavigationBarItem(icon: Icon(Icons.person), label: 'Profile'),
        ],
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          // Example action: navigate to next tab programmatically
          final next = (_currentIndex + 1) % _screens.length;
          _onTap(next);
        },
        child: const Icon(Icons.swap_horiz),
        tooltip: 'Next tab',
      ),
    );
  }
}

// ------------------- Example screens -------------------

class _DemoHomeScreen extends StatelessWidget {
  const _DemoHomeScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return const Center(
      child: Padding(
        padding: EdgeInsets.all(24.0),
        child: Text(
          'Home\n\nThis screen preserves state when using IndexedStack or PageView.',
          textAlign: TextAlign.center,
          style: TextStyle(fontSize: 18),
        ),
      ),
    );
  }
}

class _DemoSearchScreen extends StatelessWidget {
  const _DemoSearchScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      padding: const EdgeInsets.all(8),
      itemCount: 30,
      itemBuilder: (context, i) => ListTile(
        leading: const Icon(Icons.search),
        title: Text('Search result #${i + 1}'),
      ),
    );
  }
}

class _DemoFavoritesScreen extends StatefulWidget {
  const _DemoFavoritesScreen({Key? key}) : super(key: key);

  @override
  State<_DemoFavoritesScreen> createState() => _DemoFavoritesScreenState();
}

class _DemoFavoritesScreenState extends State<_DemoFavoritesScreen> {
  final List<bool> _selected = List<bool>.filled(8, false);

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      padding: const EdgeInsets.all(8),
      itemCount: _selected.length,
      itemBuilder: (context, i) => ListTile(
        leading: Icon(_selected[i] ? Icons.star : Icons.star_border, color: Colors.amber),
        title: Text('Item ${i + 1}'),
        trailing: Switch(
          value: _selected[i],
          onChanged: (v) => setState(() => _selected[i] = v),
        ),
      ),
    );
  }
}

class _DemoProfileScreen extends StatelessWidget {
  const _DemoProfileScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: const [
          CircleAvatar(radius: 40, child: Icon(Icons.person, size: 48)),
          SizedBox(height: 12),
          Text('User Name', style: TextStyle(fontSize: 18)),
          SizedBox(height: 6),
          Text('user@example.com', style: TextStyle(color: Colors.grey)),
        ],
      ),
    );
  }
}
