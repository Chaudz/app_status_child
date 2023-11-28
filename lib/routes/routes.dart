import 'package:myapp/screens/onboarding_screen.dart';
import 'package:myapp/screens/splash_screen.dart';
import 'package:myapp/screens/start_screen.dart';

var routes = {
  '/': (context) => SplashScreen(),
  '/onboardScreen': (context) => OnBoardingScreen(),
  '/startScreen': (context) => StartScreen(),
};