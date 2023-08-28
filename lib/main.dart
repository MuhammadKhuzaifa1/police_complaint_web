import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:get/get.dart';
import 'package:police_complaint_web/controllers/provider_controller.dart';
import 'package:police_complaint_web/firebase_options.dart';
import 'package:police_complaint_web/screens/side_menu.dart';
import 'package:police_complaint_web/screens/signin_screen.dart';
import 'package:police_complaint_web/screens/signup_screen.dart';
import 'package:provider/provider.dart';


GlobalKey<NavigatorState> navigatorKey = GlobalKey<NavigatorState>();
Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(options: DefaultFirebaseOptions.currentPlatform);
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});
  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: providersController,
      child: GetMaterialApp(
        title: 'Flutter Demo',
        builder: FToastBuilder(),
        navigatorKey: navigatorKey,
        theme: ThemeData(
          primarySwatch: Colors.blue,
          useMaterial3: true,
        ),
        home: const SignInScreen(),
      ),
    );
  }
}
