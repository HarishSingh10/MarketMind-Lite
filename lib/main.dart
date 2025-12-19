import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'theme.dart';
import 'screens/login_screen.dart';
import 'providers/user_provider.dart';
import 'providers/market_provider.dart';
import 'screens/home_wrapper.dart';

void main() {
  runApp(MarketMindLiteApp());
}

class MarketMindLiteApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (_) => UserProvider()),
        ChangeNotifierProvider(create: (_) => MarketProvider()),
      ],
      child: MaterialApp(
        title: 'MarketMind Lite',
        debugShowCheckedModeBanner: false,
        theme: AppTheme.darkTheme,
        home: AuthWrapper(),
      ),
    );
  }
}

class AuthWrapper extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Consumer<UserProvider>(
      builder: (context, userProvider, child) {
        if (userProvider.isAuthLoading) {
           return Scaffold(
             backgroundColor: AppTheme.backgroundDark,
             body: Center(child: CircularProgressIndicator(color: AppTheme.primaryColor)),
           );
        }
        
        return userProvider.isLoggedIn ? HomeWrapper() : LoginScreen();
      },
    );
  }
}
