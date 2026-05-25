import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';
import 'services/firebase_options.dart';
import 'screens/signup_screen.dart';
import 'cubit/property_details_cubit.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'screens/seller.dart';
import 'screens/buyer.dart';
import 'screens/splash_screen.dart';
import 'cubit/bookingcubit.dart';
import 'screens/home.dart';
void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(options: DefaultFirebaseOptions.currentPlatform);
  runApp(
    MultiBlocProvider(
    providers: [
      BlocProvider(
        create: (_) => PropertyCubit()..fetchProperties(),
      ),
      BlocProvider(
        create: (_) => PropertyCubit()..fetchMyProperties(),
      ),
      BlocProvider(
  create: (_) => BookingCubit(),

)
      ],
       child: MyApp(),));
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(home: SplashScreen(), debugShowCheckedModeBanner: false);
  }
}
