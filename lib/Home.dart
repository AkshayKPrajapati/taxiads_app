import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import 'main.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key, required this.title});

  final String title;

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  int _counter = 0;
  int _tabIndex = 0;

  void _incrementCounter() {
    setState(() => _counter++);
  }

  @override
  Widget build(BuildContext context) {
    final pages = <Widget>[
      _HomeTab(counter: _counter),
      const _PlaceholderTab(icon: Icons.explore, label: 'Explore'),
      const _PlaceholderTab(icon: Icons.person, label: 'Profile'),
    ];

    return Scaffold(
      appBar: AppBar(
        backgroundColor: MyApp.black,
        title: Text(
          widget.title,
          style: const TextStyle(
            color: MyApp.yellow,
            fontWeight: FontWeight.bold,
          ),
        ),
        actions: [
          IconButton(
            icon: const Icon(Icons.notifications_outlined, color: MyApp.white),
            onPressed: () {},
          ),
        ],
      ),
      body: AnimatedSwitcher(
        duration: const Duration(milliseconds: 250),
        child: KeyedSubtree(
          key: ValueKey(_tabIndex),
          child: pages[_tabIndex],
        ),
      ),
      floatingActionButton: _tabIndex == 0
          ? FloatingActionButton(
        onPressed: _incrementCounter,
        tooltip: 'Increment',
        child: const Icon(Icons.add),
      )
          : null,
      bottomNavigationBar: NavigationBar(
        selectedIndex: _tabIndex,
        onDestinationSelected: (i) => setState(() => _tabIndex = i),
        destinations: const [
          NavigationDestination(
            icon: Icon(Icons.home_outlined),
            selectedIcon: Icon(Icons.home),
            label: 'Home',
          ),
          NavigationDestination(
            icon: Icon(Icons.explore_outlined),
            selectedIcon: Icon(Icons.explore),
            label: 'Explore',
          ),
          NavigationDestination(
            icon: Icon(Icons.person_outline),
            selectedIcon: Icon(Icons.person),
            label: 'Profile',
          ),
        ],
      ),
    );
  }
}

class _HomeTab extends StatelessWidget {
  const _HomeTab({required this.counter});

  final int counter;

  @override
  Widget build(BuildContext context) {
    final textTheme = Theme.of(context).textTheme;

    final actions = <_QuickAction>[
      _QuickAction(Icons.dashboard_outlined, 'Dashboard'),
      _QuickAction(Icons.analytics_outlined, 'Analytics'),
      _QuickAction(Icons.message_outlined, 'Messages'),
      _QuickAction(Icons.settings_outlined, 'Settings'),
    ];

    return ListView(
      padding: const EdgeInsets.all(20),
      children: [
        Text(
          'Welcome to TaxiAds 👋',
          style: textTheme.headlineSmall?.copyWith(
            color: MyApp.white,
            fontWeight: FontWeight.bold,
          ),
        ),
        const SizedBox(height: 4),
        const Text(
          'Drive your campaign reach everywhere.',
          style: TextStyle(color: Colors.white70),
        ),
        const SizedBox(height: 20),

        // Counter card styled in Yellow, Black, and White
        Card(
          elevation: 4,
          color: MyApp.yellow,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(20),
          ),
          child: Padding(
            padding: const EdgeInsets.symmetric(vertical: 28, horizontal: 20),
            child: Column(
              children: [
                Text(
                  'Active Ad Impressions Counter:',
                  textAlign: TextAlign.center,
                  style: textTheme.bodyLarge?.copyWith(
                    color: MyApp.black,
                    fontWeight: FontWeight.w600,
                  ),
                ),
                const SizedBox(height: 12),
                Text(
                  '$counter',
                  style: textTheme.displayMedium?.copyWith(
                    fontWeight: FontWeight.bold,
                    color: MyApp.black,
                  ),
                ),
              ],
            ),
          ),
        ),

        const SizedBox(height: 28),
        Text(
          'Quick Actions',
          style: textTheme.titleMedium?.copyWith(
            color: MyApp.yellow,
            fontWeight: FontWeight.bold,
          ),
        ),
        const SizedBox(height: 12),

        GridView.builder(
          shrinkWrap: true,
          physics: const NeverScrollableScrollPhysics(),
          itemCount: actions.length,
          gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
            crossAxisCount: 2,
            mainAxisSpacing: 12,
            crossAxisSpacing: 12,
            childAspectRatio: 1.5,
          ),
          itemBuilder: (context, i) {
            final a = actions[i];
            return Material(
              color: const Color(0xFF1E1E1E),
              borderRadius: BorderRadius.circular(16),
              child: InkWell(
                borderRadius: BorderRadius.circular(16),
                onTap: () => ScaffoldMessenger.of(context).showSnackBar(
                  SnackBar(
                    backgroundColor: MyApp.yellow,
                    content: Text(
                      '${a.label} tapped',
                      style: const TextStyle(color: MyApp.black),
                    ),
                  ),
                ),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Icon(a.icon, size: 30, color: MyApp.yellow),
                    const SizedBox(height: 8),
                    Text(
                      a.label,
                      style: const TextStyle(
                        color: MyApp.white,
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                  ],
                ),
              ),
            );
          },
        ),
        const SizedBox(height: 80),
      ],
    );
  }
}

class _QuickAction {
  final IconData icon;
  final String label;
  _QuickAction(this.icon, this.label);
}

class _PlaceholderTab extends StatelessWidget {
  const _PlaceholderTab({required this.icon, required this.label});

  final IconData icon;
  final String label;

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Icon(icon, size: 64, color: MyApp.yellow),
          const SizedBox(height: 12),
          Text(
            label,
            style: Theme.of(context).textTheme.titleLarge?.copyWith(
              color: MyApp.white,
            ),
          ),
          const SizedBox(height: 4),
          const Text(
            'Coming soon',
            style: TextStyle(color: Colors.white70),
          ),
        ],
      ),
    );
  }
}
