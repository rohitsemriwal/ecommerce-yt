import 'package:ecommerce/logic/cubits/user_cubit/user_cubit.dart';
import 'package:ecommerce/logic/cubits/user_cubit/user_state.dart';
import 'package:ecommerce/presentation/screens/home/category_screen.dart';
import 'package:ecommerce/presentation/screens/home/profile_screen.dart';
import 'package:ecommerce/presentation/screens/home/providers/home_provider.dart';
import 'package:ecommerce/presentation/screens/home/user_feed_screen.dart';
import 'package:ecommerce/presentation/screens/splash/splash_screen.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:provider/provider.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  static const String routeName = "home";

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {

  List<Widget> pages = const [
    UserFeedScreen(),
    CategoryScreen(),
    ProfileScreen()
  ];

  @override
  Widget build(BuildContext context) {
    final provider = Provider.of<HomeProvider>(context);

    return BlocListener<UserCubit, UserState>(
      listener: (context, state) {
        if(state is UserLoggedOutState) {
          Navigator.popUntil(context, (route) => route.isFirst);
          Navigator.pushReplacementNamed(context, SplashScreen.routeName);
        }
      },
      child: Scaffold(
        appBar: AppBar(
          title: const Text("E-Commerce App"),
          actions: [
            IconButton(
              onPressed: () {},
              icon: const Icon(CupertinoIcons.cart_fill),
            ),
          ],
        ),
        bottomNavigationBar: BottomNavigationBar(
          currentIndex: provider.currentIndex,
          onTap: provider.changeIndex,
          items: const [
    
            BottomNavigationBarItem(
              label: "Home",
              icon: Icon(Icons.home)
            ),
    
            BottomNavigationBarItem(
              label: "Categories",
              icon: Icon(Icons.category)
            ),
    
            BottomNavigationBarItem(
              label: "Profile",
              icon: Icon(Icons.person)
            ),
    
          ],
        ),
        body: SafeArea(
          child: pages[provider.currentIndex],
        ),
      ),
    );
  }
}