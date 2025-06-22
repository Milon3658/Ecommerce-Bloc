import 'package:bloc/bloc.dart';
import 'package:bloc_ecommerce/app.dart';
import 'package:bloc_ecommerce/src/blocs/bloc_ecommerce_observer.dart';
import 'package:bloc_ecommerce/src/data/preference/local_preference.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';

import 'firebase_options.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  try {
    await Firebase.initializeApp(
      options: DefaultFirebaseOptions.currentPlatform,
    );
  } on FirebaseException catch (e) {
    if (e.code == 'duplicate-app') {
    } else {
      rethrow;
    }
  }
  Bloc.observer = BlocEcommerceObserver();
  await LocalPreferences().init();
  runApp(const BlocEcommerceApp());
}
