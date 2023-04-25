import 'dart:async';

import 'package:ecommerce/logic/cubits/user_cubit/user_cubit.dart';
import 'package:ecommerce/logic/cubits/user_cubit/user_state.dart';
import 'package:ecommerce/presentation/screens/auth/login_screen.dart';
import 'package:ecommerce/presentation/screens/home/home_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  static const String routeName = "splash";

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {

  void goToNextScreen() async {
    final userCubit = BlocProvider.of<UserCubit>(context);
    final userState = userCubit.state;

    if(userState is UserLoggedInState) {
      Navigator.pushReplacementNamed(context, HomeScreen.routeName);
    }
    else if(userState is UserLoggedOutState || userState is UserErrorState) {
      Navigator.pushReplacementNamed(context, LoginScreen.routeName);
    }
    else {
      // Wait/404
    }
  }

  @override
  void initState() {
    super.initState();
    Timer(const Duration(milliseconds: 300), () {
      goToNextScreen();
    });
  }

  @override
  Widget build(BuildContext context) {
    return BlocListener<UserCubit, UserState>(
      listener: (context, state) {
        goToNextScreen();
      },
      child: const Scaffold(
        body: Center(
          child: CircularProgressIndicator()
        ),
      ),
    );
  }
}