import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'app.dart';
import 'controllers/bloc_observer.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();

  await Firebase.initializeApp();
  BlocOverrides.runZoned(
    () {
      runApp(
        MyApp(),
      );
    },
    blocObserver: MyBlocObserver(),
  );
}
