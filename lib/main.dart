import 'package:af_watches2/Bussiness_logic/User/user_cubit.dart';
import 'package:af_watches2/Data/repository/user_repo.dart';
import 'package:af_watches2/Presentation/Screens/welcomePage.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:af_watches2/app_router.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'Bussiness_logic/Watch/watches_cubit.dart';
import 'Data/repository/WatchRepo.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'Presentation/Screens/home_screen.dart';


void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  final SharedPreferences prefs = await SharedPreferences.getInstance();
  var name=prefs.get('name');
  await Firebase.initializeApp();
  runApp( MultiBlocProvider(
    providers:[
          BlocProvider<WatchesCubit>(
  create: (context) =>WatchesCubit(WatchRepo())),
      BlocProvider<UserCubit>(
          create: (context) =>UserCubit(UserRepo())),
  ],
    child: MyApp(appRouter: AppRouter(),wel:name==null?const WelcomePage():const HomeScreen() ),
  ));
}

class MyApp extends StatelessWidget {
   MyApp({super.key, required this.appRouter,required this.wel});

  final AppRouter appRouter;
  final  wel;

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      onGenerateRoute: appRouter.generateRoute,
      home: wel,
    );
  }
}
/**
 * MaterialApp(
    debugShowCheckedModeBanner: false,
    onGenerateRoute: appRouter.generateRoute,
    );
 */
