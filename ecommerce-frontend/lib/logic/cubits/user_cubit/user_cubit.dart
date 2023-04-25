import 'package:ecommerce/data/models/user/user_model.dart';
import 'package:ecommerce/data/repositories/user_repository.dart';
import 'package:ecommerce/logic/cubits/user_cubit/user_state.dart';
import 'package:ecommerce/logic/services/preferences.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class UserCubit extends Cubit<UserState> {
  UserCubit() : super( UserInitialState() ) {
    _initialize();
  }
  final UserRepository _userRepository = UserRepository();

  void _initialize() async {
    final userDetails = await Preferences.fetchUserDetails();
    if(userDetails.email != null && userDetails.password != null) {
      signIn(email: userDetails.email!, password: userDetails.password!);
    }
    else {
      emit( UserLoggedOutState() );
    }
  }

  void _emitLoggedInState({
    required String email,
    required String password,
    required UserModel userModel
  }) async {
    await Preferences.saveUserDetails(email, password);
    emit( UserLoggedInState(userModel) );
  }

  void signIn({
    required String email,
    required String password
  }) async {
    emit( UserLoadingState() );
    try {
      UserModel userModel = await _userRepository.signIn(email: email, password: password);
      _emitLoggedInState(email: email, password: password, userModel: userModel);
    }
    catch(ex) {
      emit( UserErrorState(ex.toString()) );
    }
  }

  void createAccount({
    required String email,
    required String password
  }) async {
    emit( UserLoadingState() );
    try {
      UserModel userModel = await _userRepository.createAccount(email: email, password: password);
      _emitLoggedInState(email: email, password: password, userModel: userModel);
    }
    catch(ex) {
      emit( UserErrorState(ex.toString()) );
    }
  }

  void signOut() async {
    await Preferences.clearData();
    emit( UserLoggedOutState() );
  }
}