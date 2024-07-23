part of 'home_bloc.dart';


sealed class HomeEvent {}

final class LoadCustomDataEvent extends HomeEvent {}

class ChangeBottomNavIconEvent extends HomeEvent {
  int currIndex;
  ChangeBottomNavIconEvent({required this.currIndex});
}

final class ChangeDrawerEvent extends HomeEvent {}
