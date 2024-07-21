part of 'on_boarding_bloc.dart';

@immutable
sealed class OnBoardingState {}

final class OnBoardingInitial extends OnBoardingState {}

final class OnBoardingChangePage extends OnBoardingState {}

final class OnBoardingFinishedState extends OnBoardingState {}
