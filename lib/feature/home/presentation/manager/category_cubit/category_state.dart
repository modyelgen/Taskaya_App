part of 'category_cubit.dart';

@immutable
sealed class CategoryState {}

final class CategoryInitialState extends CategoryState {}

final class CategoryChangeColorState extends CategoryState {}

final class CategoryChangeIconState extends CategoryState {}

final class CategoryChangeNameState extends CategoryState {}
