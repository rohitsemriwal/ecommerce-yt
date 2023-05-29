import 'package:ecommerce/core/ui.dart';
import 'package:ecommerce/data/models/user/user_model.dart';
import 'package:ecommerce/logic/cubits/user_cubit/user_cubit.dart';
import 'package:ecommerce/logic/cubits/user_cubit/user_state.dart';
import 'package:ecommerce/presentation/widgets/gap_widget.dart';
import 'package:ecommerce/presentation/widgets/primary_button.dart';
import 'package:ecommerce/presentation/widgets/primary_textfield.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class EditProfileScreen extends StatefulWidget {
  const EditProfileScreen({super.key});

  static const routeName = "edit_profile";

  @override
  State<EditProfileScreen> createState() => _EditProfileScreenState();
}

class _EditProfileScreenState extends State<EditProfileScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Edit Profile"),
      ),
      body: SafeArea(
        child: BlocBuilder<UserCubit, UserState>(
          builder: (context, state) {

            if(state is UserLoadingState) {
              return const Center(
                child: CircularProgressIndicator(),
              );
            }

            if(state is UserErrorState) {
              return Center(
                child: Text(state.message),
              );
            }

            if(state is UserLoggedInState) {
              return editProfile(state.userModel);
            }

            return const Center(
              child: Text("An error occured!"),
            );
          }
        )
      ),
    );
  }

  Widget editProfile(UserModel userModel) {
    return ListView(
      padding: const EdgeInsets.all(16),
      children: [

        Text("Personal Details", style: TextStyles.body1.copyWith(fontWeight: FontWeight.bold)),
        const GapWidget(size: -10,),
        PrimaryTextField(
          initialValue: userModel.fullName,
          onChanged: (value) {
            userModel.fullName = value;
          },
          labelText: "Full Name",
        ),

        const GapWidget(),

        PrimaryTextField(
          initialValue: userModel.phoneNumber,
          onChanged: (value) {
            userModel.phoneNumber = value;
          },
          labelText: "Phone Number",
        ),

        const GapWidget(size: 20),
        Text("Address", style: TextStyles.body1.copyWith(fontWeight: FontWeight.bold)),
        const GapWidget(size: -10,),

        PrimaryTextField(
          initialValue: userModel.address,
          onChanged: (value) {
            userModel.address = value;
          },
          labelText: "Address",
        ),

        const GapWidget(),

        PrimaryTextField(
          initialValue: userModel.city,
          onChanged: (value) {
            userModel.city = value;
          },
          labelText: "City",
        ),

        const GapWidget(),

        PrimaryTextField(
          initialValue: userModel.state,
          onChanged: (value) {
            userModel.state = value;
          },
          labelText: "State",
        ),

        const GapWidget(),

        PrimaryButton(
          onPressed: () async {
            bool success = await BlocProvider.of<UserCubit>(context).updateUser(userModel);
            if(success) {
              Navigator.pop(context);
            }
          },
          text: "Save"
        ),

      ],
    );
  }

}