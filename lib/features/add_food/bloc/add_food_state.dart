part of 'add_food_bloc.dart';

@immutable
sealed class AddFoodState {}

final class AddFoodInitial extends AddFoodState {}

final class LoadingState extends AddFoodState{}

final class OnDataState extends AddFoodState{
  final List<PeopleModel> people;
  final List<FoodModel> food;
  final List<int> selectedIds;

  OnDataState({
    required this.people,
    required this.food,
    required this.selectedIds
});
}
