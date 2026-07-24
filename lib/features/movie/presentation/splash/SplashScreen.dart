import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:injectable/injectable.dart';
import 'package:rive/rive.dart';

import '../../../../core/colors/VColors.dart';
import '../../../../core/di/injection.dart';
import '../../../../firebase_options.dart';
import '../../../../main.dart';

class SplashScreen extends StatelessWidget {
  const SplashScreen({super.key});

  Future<void> _initApp() async {
    await configurationDependencies(Environment.dev);
    await RiveNative.init();
    await Firebase.initializeApp(
      options: DefaultFirebaseOptions.currentPlatform,
    );
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: FutureBuilder<void>(
        future: _initApp(),
        builder: (context, snapshot) {
          if (snapshot.connectionState != ConnectionState.done) {
            return const Scaffold(
              backgroundColor: VColors.blackBackground,
              body: Center(
                child: CircularProgressIndicator(color: VColors.colorIcon),
              ),
            );
          }
          return const MyApp();
        },
      ),
    );
  }
}