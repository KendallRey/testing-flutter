import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:normal_list/app/core/services/app_provider.dart';
import 'package:normal_list/features/list/data/list_provider.dart';
import 'package:provider/provider.dart';
import 'firebase_options.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';

import 'app/app.dart';

void main() async {
  await dotenv.load(fileName: ".env");
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  runApp(
    MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (_) => AppProvider()),
        ChangeNotifierProvider(create: (_) => ListProvider()),
      ],
      child: const MyApp(),
    )
  );
}