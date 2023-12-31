import 'package:myapp/screens/choose_info_screen.dart';
import 'package:myapp/screens/addBaby_screen.dart';
import 'package:myapp/screens/home_screen.dart';
import 'package:myapp/screens/loading_splash_screen.dart';
import 'package:myapp/screens/login_screen.dart';
import 'package:myapp/screens/onboarding_screen.dart';
import 'package:myapp/screens/overview_screen.dart';
import 'package:myapp/screens/record_screen.dart';
import 'package:myapp/screens/splash_screen.dart';
import 'package:myapp/screens/start_screen.dart';
import 'package:myapp/screens/feeding_sceen.dart';

var routes = {
  '/home': (context) => SplashScreen(),
  '/onboardScreen': (context) => OnBoardingScreen(),
  '/startScreen': (context) => StartScreen(),
  '/loginScreen': (context) => LoginScreen(),
  '/gender': (context) => GenderBaby(),
  '/nameBaby': (context) => NameBaby(),
  '/birthdayBaby': (context) => BirthdayBaby(),
  '/avatarBaby': (context) => AvatarBaby(),
  '/createInfo': (context) => CreateInfo(),
  '/addBaby': (context) => AddBabyScreen(),
  '/addBabyDetail': (context) => AddBabyDetail(),
  '/feedingScreen': (context) => FeedingScreen(),
  '/loadingData': (context) => LoadingSplashScreen(),
  '/homeScreen': (context) => HomeScreen(),
  '/activeDetail': (context) => ActiveDetail(),
  '/overview': (context) => OverviewScreen(),
};
