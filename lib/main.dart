import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:myapp/firebase_options.dart';
import 'package:myapp/routes/routes.dart';
import 'package:myapp/services/checkUser_exist.dart';
import 'package:shared_preferences/shared_preferences.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  runApp(const MyApp());
}

class MyApp extends StatefulWidget {
  const MyApp({Key? key});

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  @override
  void initState() {
    super.initState();
  }

  Future<List<bool>> getRecord() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    bool storedNameBaby = prefs.getBool("record") ?? false;
    bool existUser = await isUserIdExists();
    return [storedNameBaby, existUser];
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
        useMaterial3: true,
      ),
      home: FutureBuilder<List<bool>>(
        future: getRecord(),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.done) {
            List<bool> data = snapshot.data ?? [false, false];
            bool record = data[0];
            bool existsKid = data[1];
            return MaterialApp(
              debugShowCheckedModeBanner: false,
              theme: ThemeData(
                colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
                useMaterial3: true,
              ),
              initialRoute: (FirebaseAuth.instance.currentUser != null)
                  ? (record || existsKid ? '/loadingData' : '/addBaby')
                  : (record)
                      ? '/loadingData'
                      : '/home',
              routes: routes,
            );
          } else {
            return Container();
          }
        },
      ),
    );
  }
}
