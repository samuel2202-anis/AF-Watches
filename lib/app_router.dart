import 'package:af_watches2/Bussiness_logic/Watch/watches_cubit.dart';
import 'package:af_watches2/Data/repository/WatchRepo.dart';
import 'package:af_watches2/Presentation/Screens/home_screen.dart';
import 'package:af_watches2/Presentation/Screens/loginPage.dart';
 import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'Constants/strings.dart';
import 'Presentation/Screens/SignUpPage.dart';
import 'Presentation/Screens/watchDetails.dart';
import 'Presentation/Screens/welcomePage.dart';

class AppRouter {
  late WatchRepo watchRepo;
  late WatchesCubit watchesCubit;



  Route? generateRoute(RouteSettings setting) {
    switch (setting.name) {
      case homeScreen:
        return MaterialPageRoute(builder: (_) => const HomeScreen());
      case loginPage:
        return MaterialPageRoute(builder: (_) => const LoginPage());
      case signUp:
        return MaterialPageRoute(builder: (_)=>const SignUp());
      case welcomePage:
        return MaterialPageRoute(builder: (_)=>const WelcomePage(),);
      case watchDetails:
        return MaterialPageRoute(builder: (_) => const WatchDetails());
    }
  }
}
