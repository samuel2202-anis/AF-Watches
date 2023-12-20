import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';

import '../../Data/models/user.dart';
import '../../Data/repository/user_repo.dart';

part 'user_state.dart';

class UserCubit extends Cubit<UserState> {
  final UserRepo userRepo;
  late AppUser appUser;
  UserCubit(this.userRepo) : super(UserInitial());
  AppUser getData(){
    userRepo.getUserData().then((value) {
      emit(UserLoaded(value));
      appUser=value ;
    });
    return appUser;
  }
}
