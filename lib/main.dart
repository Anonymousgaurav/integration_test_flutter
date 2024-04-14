import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:integration_test_flutter/view/splash_screen/splash_screen.dart';
import 'package:integration_test_flutter/controller/bloc/splash/splash_event.dart';
import 'controller/bloc/splash/splash_bloc.dart';
import 'controller/db/db.dart';


 final GlobalKey<NavigatorState> navigatorKey =
      GlobalKey<NavigatorState>();
void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await DB.instance().initialize();
  runApp(const MainApp());
}

class MainApp extends StatefulWidget {
  const MainApp({super.key});

  @override
  State<MainApp> createState() => _MainAppState();
}

class _MainAppState extends State<MainApp> {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      navigatorKey: navigatorKey,
      home: BlocProvider<SplashBloc>(
          create: (context) =>
              SplashBloc(DB.instance())..add(GetSignInCredential()),
          child: const SplashScreen()),
    );
  }
}
