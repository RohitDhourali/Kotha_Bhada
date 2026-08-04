import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';
import 'services/firebase_options.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'screens/signup_screen.dart';
import 'screens/loginscreen.dart';
import 'screens/seller.dart';
import 'screens/buyer.dart';
import 'screens/splash_screen.dart';
import 'screens/home.dart';
import 'cubit/property_details_cubit.dart';
import 'cubit/bookingcubit.dart';
import 'theme.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(options: DefaultFirebaseOptions.currentPlatform);

  runApp(
    MultiBlocProvider(
      providers: [
        BlocProvider(
          create: (_) => PropertyCubit(),
        ),
        BlocProvider(
          create: (_) => BookingCubit(),
        ),
      ],
      child: MyApp(),
    ),
  );
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'KothaBhada',
      theme: AppTheme.lightTheme(),
      debugShowCheckedModeBanner: false,
      initialRoute: '/',
      routes: {
        '/': (_) => const SplashScreen(),
        '/login': (_) => LoginScreen(),
        '/signup': (_) => SignupScreen(),
        '/home': (_) => const Home(),
        '/seller': (_) => const Seller(),
        '/buyer': (_) => BuyerScreen(),
      },
    );
  }
}
