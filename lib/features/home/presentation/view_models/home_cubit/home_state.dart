abstract class HomeState {}

class InitiallHomeState extends HomeState {}

class UpdateUsersState extends HomeState {}

class GetUserSuccessState extends HomeState {}

class GetUserLoadingState extends HomeState {}

class GetUserFailureState extends HomeState {
  final String error;

  GetUserFailureState({required this.error});
}
