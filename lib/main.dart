import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import './providers/navigation_provider.dart';
import './screens/home_screen.dart';
import './screens/analysis_screen.dart';
import './screens/user_profile_screen.dart';
import './widgets/bottom_nav_bar.dart';

void main() {
  runApp(MultiProvider(
    providers: [
      ChangeNotifierProvider(create: (_) => NavigationProvider()),
    ],
    child: const MyApp(),
  ));
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: '灵感快门',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
        useMaterial3: true,
      ),
      home: const MainScreen(),
    );
  }
}

class MainScreen extends StatefulWidget {
  const MainScreen({super.key});

  @override
  State<MainScreen> createState() => _MainScreenState();
}

class _MainScreenState extends State<MainScreen> {
  @override
  Widget build(BuildContext context) {
    final navProvider = Provider.of<NavigationProvider>(context);

    return Scaffold(
      body: IndexedStack(
        index: navProvider.currentIndex,
        children: const [
          HomeScreen(),
          AnalysisScreen(),
          UserProfileScreen(),
        ],
      ),
      bottomNavigationBar: BottomNavBar(
        currentIndex: navProvider.currentIndex,
        onTap: (index) {
          navProvider.setPageIndex(index);
        },
      ),
    );
  }
}