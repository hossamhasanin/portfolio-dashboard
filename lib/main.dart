import 'package:base/destination.dart';
import 'package:fill_main_data/ui/fill_data_screen.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:login/ui/login_screen.dart';
import 'package:main_data/ui/main_data_screen.dart';
import 'package:portfolio_dashboard/firebase_options.dart';
import 'package:projects/ui/projects_screen.dart';
import 'package:splash/ui/splash_screen.dart';

import 'dependencies.dart';

void main() {
  WidgetsFlutterBinding.ensureInitialized();
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  final Future<FirebaseApp> _initialization = Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  MyApp({Key? key}) : super(key: key);

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      getPages: [
        GetPage(name: SPLASH_SCREEN, page:()=> const SplashScreen()),
        GetPage(name: LOGIN_SCREEN, page:()=> const LoginScreen()),
        GetPage(name: FILL_DATA_SCREEN, page:()=> const FillDataScreen()),
        GetPage(name: MAIN_DATA_SCREEN, page:()=> const MainDataScreen()),
        GetPage(name: PROJECTS_SCREEN, page:()=> const ProjectsScreen()),
      ],
      home: FutureBuilder(
        future: _initialization,
        builder: (_ , snapshot){
          if (snapshot.connectionState == ConnectionState.waiting){
            return const Scaffold(
              body: Center(
                child: CircularProgressIndicator(),
              ),
            );
          }

          if (snapshot.hasError){
            print(snapshot.error);
            return Scaffold(
              body: Center(
                child: Text(snapshot.error.toString()),
              ),
            );
          }
          initDependencies();
          return const SplashScreen();
        },
      ),
    );
  }
}