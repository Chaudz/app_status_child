import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:myapp/firebase_options.dart';
import 'package:myapp/routes/routes.dart';
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

  Future<bool> getRecord() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    bool storedNameBaby = prefs.getBool("record") ?? false;
    return storedNameBaby;;
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
      home: FutureBuilder<bool>(
        future: getRecord(),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.done) {
            bool record = snapshot.data ?? false;
            print("++++++++$record");
            print(record);
            return MaterialApp(
              debugShowCheckedModeBanner: false,
              theme: ThemeData(
                colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
                useMaterial3: true,
              ),
              initialRoute: (FirebaseAuth.instance.currentUser != null)
                  ? (record) ? '/loadingData' : '/addBaby'
                  : (record) ? '/loadingData': '/home',
              routes: routes,
            );
          } else {
            return CircularProgressIndicator();
          }
        },
      ),
    );
  }
}
