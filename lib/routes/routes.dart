import 'package:myapp/screens/addBaby_screen.dart';
import 'package:myapp/screens/login_screen.dart';
import 'package:myapp/screens/onboarding_screen.dart';
import 'package:myapp/screens/splash_screen.dart';
import 'package:myapp/screens/start_screen.dart';

var routes = {
  '/home': (context) => SplashScreen(),
  '/onboardScreen': (context) => OnBoardingScreen(),
  '/startScreen': (context) => StartScreen(),
  '/loginScreen': (context) => LoginScreen(),
  '/gender': (context) => GenderBaby(),
  '/nameBaby': (context) => NameBaby(),
  '/birthdayBaby': (context) => BirthdayBaby(),
  '/avatarBaby': (context) => AvatarBaby(),
  '/addBaby': (context) => AddBabyScreen(),
  '/addBabyDetail': (context) => AddBabyDetail()
};