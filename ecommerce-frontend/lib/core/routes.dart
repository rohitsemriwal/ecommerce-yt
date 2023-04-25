import 'package:ecommerce/data/models/category/category_model.dart';
import 'package:ecommerce/logic/cubits/category_product_cubit/category_product_cubit.dart';
import 'package:ecommerce/presentation/screens/auth/login_screen.dart';
import 'package:ecommerce/presentation/screens/auth/providers/login_provider.dart';
import 'package:ecommerce/presentation/screens/auth/providers/signup_provider.dart';
import 'package:ecommerce/presentation/screens/auth/signup_screen.dart';
import 'package:ecommerce/presentation/screens/home/home_screen.dart';
import 'package:ecommerce/presentation/screens/home/providers/home_provider.dart';
import 'package:ecommerce/presentation/screens/product/product_by_category_screen.dart';
import 'package:ecommerce/presentation/screens/splash/splash_screen.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:provider/provider.dart';

class Routes {

  static Route? onGenerateRoute(RouteSettings settings) {
    switch(settings.name) {
      
      case LoginScreen.routeName: return CupertinoPageRoute(
        builder: (context) => ChangeNotifierProvider(
          create: (context) => LoginProvider(context),
          child: const LoginScreen()
        )
      );

      case SignupScreen.routeName: return CupertinoPageRoute(
        builder: (context) => ChangeNotifierProvider(
          create: (context) => SignupProvider(context),
          child: const SignupScreen()
        )
      );

      case HomeScreen.routeName: return CupertinoPageRoute(
        builder: (context) => ChangeNotifierProvider(
          create: (context) => HomeProvider(),
          child: const HomeScreen()
        )
      );

      case SplashScreen.routeName: return CupertinoPageRoute(
        builder: (context) => const SplashScreen()
      );

      case ProductByCategoryScreen.routeName: return CupertinoPageRoute(
        builder: (context) => BlocProvider(
          create: (context) => CategoryProductCubit(settings.arguments as CategoryModel),
          child: const ProductByCategoryScreen()
        )
      );

      default: return null; // 404

    }
  }

}