import 'package:ecommerce/core/ui.dart';
import 'package:ecommerce/data/models/user/user_model.dart';
import 'package:ecommerce/logic/cubits/user_cubit/user_cubit.dart';
import 'package:ecommerce/logic/cubits/user_cubit/user_state.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class ProfileScreen extends StatefulWidget {
  const ProfileScreen({super.key});

  @override
  State<ProfileScreen> createState() => _ProfileScreenState();
}

class _ProfileScreenState extends State<ProfileScreen> {
  @override
  Widget build(BuildContext context) {
    return BlocBuilder<UserCubit, UserState>(
      builder: (context, state) {
        if(state is UserLoadingState || state is UserInitialState) {
          return const Center(
            child: CircularProgressIndicator(),
          );
        }
        else if(state is UserErrorState) {
          return Center(
            child: Text(state.message)
          );
        }
        else if(state is UserLoggedInState) {
          return userProfile(state.userModel);
        }
        else {
          return const SizedBox();
        }
      }
    );
  }

  Widget userProfile(UserModel userModel) {
    return ListView(
      padding: const EdgeInsets.all(16),
      children: [

        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text("${userModel.fullName}", style: TextStyles.heading3,),
            Text("${userModel.email}", style: TextStyles.body1,),
            const SizedBox(height: 5),
            CupertinoButton(
              onPressed: () {},
              padding: EdgeInsets.zero,
              child: const Text("Edit Profile"),
            ),
          ],
        ),

        const SizedBox(height: 8),

        Divider(color: AppColors.text),

        ListTile(
          onTap: () {},
          contentPadding: EdgeInsets.zero,
          leading: Icon(Icons.help, color: AppColors.accent),
          title: const Text("Help"),
        ),

        ListTile(
          onTap: () {},
          contentPadding: EdgeInsets.zero,
          leading: Icon(Icons.help, color: AppColors.accent),
          title: const Text("Privacy Policy"),
        ),

        ListTile(
          onTap: () {},
          contentPadding: EdgeInsets.zero,
          leading: Icon(Icons.help, color: AppColors.accent),
          title: const Text("Terms of Use"),
        ),

        ListTile(
          onTap: () {},
          contentPadding: EdgeInsets.zero,
          leading: Icon(Icons.settings, color: AppColors.accent),
          title: const Text("Settings"),
        ),

        ListTile(
          onTap: () {
            BlocProvider.of<UserCubit>(context).signOut();
          },
          contentPadding: EdgeInsets.zero,
          leading: const Icon(Icons.exit_to_app, color: Colors.red),
          title: const Text("Log Out", style: TextStyle(color: Colors.red),),
        ),

      ],
    );
  }

}