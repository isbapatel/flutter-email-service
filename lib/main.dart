import 'package:flutter/material.dart';
import 'screens/user_details_screen.dart';
import 'screens/profile_screen.dart';
import 'theme/app_colors.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'User Details',
      theme: ThemeData(
        primaryColor: AppColors.primaryBlue,
        scaffoldBackgroundColor: AppColors.scaffoldBg,
      ),
      initialRoute: '/',
      routes: {
        '/': (context) => const UserDetailsScreen(),
        '/profile': (context) => const ProfileScreen(),
      },
    );
  }
}
