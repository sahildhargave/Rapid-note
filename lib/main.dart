import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:twitch/providers/user_provider.dart';
import 'package:twitch/resources/auth_methods.dart';
import 'package:twitch/screens/home_screen.dart';
import 'package:twitch/screens/login_screen.dart';
import 'package:twitch/screens/onboarding_screen.dart';
import 'package:twitch/screens/signup_screen.dart';
import 'package:twitch/utils/colors.dart';
import 'package:twitch/models/user.dart' as model;
import 'package:twitch/widgets/loading_indicator.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  if (kIsWeb) {
    await Firebase.initializeApp(
        options: FirebaseOptions(
            apiKey: "AIzaSyC5QzavW1a4DemZbyN7ys5r49gHGVWySE4",
            authDomain: "twitch-clone-5784e.firebaseapp.com",
            projectId: "twitch-clone-5784e",
            storageBucket: "twitch-clone-5784e.appspot.com",
            messagingSenderId: "550245132857",
            appId: "1:550245132857:web:7cc8ba2cf5d14ae1e3bbe8"));
  } else {
    await Firebase.initializeApp();
  }
  runApp(
    MultiProvider(providers: [
      ChangeNotifierProvider(
        create: (_) => UserProvider(),
      ),
    ], child: const MyApp()),
  );
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
        title: 'Twitch Clone ',
        debugShowCheckedModeBanner: false,
        theme: ThemeData.light().copyWith(
            colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
            useMaterial3: true,
            scaffoldBackgroundColor: backgroundColor,
            appBarTheme: AppBarTheme.of(context).copyWith(
                backgroundColor: backgroundColor,
                elevation: 0,
                titleTextStyle: const TextStyle(
                  color: primaryColor,
                  fontSize: 20,
                  fontWeight: FontWeight.w600,
                ),
                iconTheme: const IconThemeData(
                  color: primaryColor,
                ))),
        routes: {
          OnboardingScreen.routeName: (context) => const OnboardingScreen(),
          LoginScreen.routeName: (context) => const LoginScreen(),
          SignupScreen.routeName: (context) => const SignupScreen(),
          HomeScreen.routeName: (context) => const HomeScreen(),
        },
        home: FutureBuilder(
          future: AuthMethods()
              .getCurrentUser(FirebaseAuth.instance.currentUser != null
                  ? FirebaseAuth.instance.currentUser!.uid
                  : null)
              .then((value) {
            if (value != null) {
              Provider.of<UserProvider>(context, listen: false).setUser(
                model.User.fromMap(value),
              );
            }
            return value;
          }),
          builder: (context, snapshot) {
            if (snapshot.connectionState == ConnectionState.waiting) {
              return const LoadingIndicator();
            }
            if (snapshot.hasData) {
              return const HomeScreen();
            }
            return const OnboardingScreen();
          },
        ));
  }
}
