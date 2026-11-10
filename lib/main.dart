import 'package:flutter/material.dart';

void main() {
  runApp(const MyApp());


  
}

/// ---------------------------------------------------------------------------
/// APP THEME & ENTRY POINT
/// ---------------------------------------------------------------------------
class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // App Color Palette: Yellow, Black, and White
  static const Color yellow = Color(0xFFFFD600); // Taxi Yellow
  static const Color black = Color(0xFF121212);  // Rich Dark Black
  static const Color white = Color(0xFFFFFFFF);  // Pure White

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'TaxiAds',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        useMaterial3: true,
        brightness: Brightness.dark,
        scaffoldBackgroundColor: black,
        colorScheme: const ColorScheme.dark(
          primary: yellow,
          onPrimary: black,
          secondary: yellow,
          onSecondary: black,
          surface: Color(0xFF1E1E1E),
          onSurface: white,
        ),
        appBarTheme: const AppBarTheme(
          backgroundColor: black,
          foregroundColor: yellow,
          elevation: 0,
          centerTitle: true,
        ),
        floatingActionButtonTheme: const FloatingActionButtonThemeData(
          backgroundColor: yellow,
          foregroundColor: black,
        ),
        navigationBarTheme: NavigationBarThemeData(
          backgroundColor: const Color(0xFF1E1E1E),
          indicatorColor: yellow,
          iconTheme: WidgetStateProperty.resolveWith((states) {
            if (states.contains(WidgetState.selected)) {
              return const IconThemeData(color: black);
            }
            return const IconThemeData(color: white);
          }),
          labelTextStyle: WidgetStateProperty.resolveWith((states) {
            if (states.contains(WidgetState.selected)) {
              return const TextStyle(color: yellow, fontWeight: FontWeight.bold);
            }
            return const TextStyle(color: Colors.white70);
          }),
        ),
      ),
      home: const SplashScreen(),
    );
  }
}

/// ---------------------------------------------------------------------------
/// SPLASH SCREEN
/// ---------------------------------------------------------------------------
class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen>
    with SingleTickerProviderStateMixin {
  late final AnimationController _controller;
  late final Animation<double> _fade;
  late final Animation<double> _scale;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 1400),
    );
    _fade = CurvedAnimation(parent: _controller, curve: Curves.easeIn);
    _scale = Tween<double>(begin: 0.7, end: 1.0).animate(
      CurvedAnimation(parent: _controller, curve: Curves.elasticOut),
    );
    _controller.forward();
    _goToHome();
  }

  Future<void> _goToHome() async {
    await Future.delayed(const Duration(milliseconds: 2800));
    if (!mounted) return;
    Navigator.of(context).pushReplacement(
      PageRouteBuilder(
        transitionDuration: const Duration(milliseconds: 600),
        pageBuilder: (context, animation, secondaryAnimation) =>
            const HomeScreen(title: 'TaxiAds'),
        transitionsBuilder: (context, animation, secondaryAnimation, child) =>
            FadeTransition(opacity: animation, child: child),
      ),
    );
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: MyApp.black,
      body: Container(
        width: double.infinity,
        height: double.infinity,
        decoration: BoxDecoration(
          gradient: RadialGradient(
            center: Alignment.center,
            radius: 1.2,
            colors: [
              MyApp.yellow.withValues(alpha: 0.12),
              MyApp.black,
            ],
          ),
        ),
        child: SafeArea(
          child: Column(
            children: [
              const Spacer(),
              FadeTransition(
                opacity: _fade,
                child: ScaleTransition(
                  scale: _scale,
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      // Logo Container using assets/icon/taxilogo.png
                      Container(
                        width: 130,
                        height: 130,
                        padding: const EdgeInsets.all(16),
                        decoration: BoxDecoration(
                          color: MyApp.black,
                          shape: BoxShape.circle,
                          border: Border.all(
                            color: MyApp.yellow,
                            width: 3,
                          ),
                          boxShadow: [
                            BoxShadow(
                              color: MyApp.yellow.withValues(alpha: 0.35),
                              blurRadius: 24,
                              spreadRadius: 4,
                            ),
                          ],
                        ),
                        child: Image.asset(
                          'assets/icon/taxilogo.png',
                          fit: BoxFit.contain,
                          errorBuilder: (context, error, stackTrace) {
                            return const Icon(
                              Icons.local_taxi,
                              size: 64,
                              color: MyApp.yellow,
                            );
                          },
                        ),
                      ),
                      const SizedBox(height: 28),
                      // App Title
                      RichText(
                        text: const TextSpan(
                          children: [
                            TextSpan(
                              text: 'TAXI ',
                              style: TextStyle(
                                fontSize: 36,
                                fontWeight: FontWeight.w900,
                                color: MyApp.yellow,
                                letterSpacing: 2.0,
                              ),
                            ),
                            TextSpan(
                              text: 'ADS',
                              style: TextStyle(
                                fontSize: 36,
                                fontWeight: FontWeight.w900,
                                color: MyApp.white,
                                letterSpacing: 2.0,
                              ),
                            ),
                          ],
                        ),
                      ),
                      const SizedBox(height: 10),
                      // Slogan
                      Container(
                        padding: const EdgeInsets.symmetric(
                          horizontal: 16,
                          vertical: 6,
                        ),
                        decoration: BoxDecoration(
                          color: MyApp.yellow.withValues(alpha: 0.15),
                          borderRadius: BorderRadius.circular(20),
                          border: Border.all(
                            color: MyApp.yellow.withValues(alpha: 0.3),
                          ),
                        ),
                        child: const Text(
                          'Moving Ads, Maximum Reach',
                          style: TextStyle(
                            fontSize: 14,
                            fontWeight: FontWeight.w600,
                            color: MyApp.yellow,
                            letterSpacing: 0.8,
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
              const Spacer(),
              // Loading Indicator
              const Padding(
                padding: EdgeInsets.only(bottom: 48),
                child: SizedBox(
                  width: 32,
                  height: 32,
                  child: CircularProgressIndicator(
                    strokeWidth: 3,
                    color: MyApp.yellow,
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

/// ---------------------------------------------------------------------------
/// HOME SCREEN
/// ---------------------------------------------------------------------------
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
