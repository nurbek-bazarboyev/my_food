part of 'show_food_bloc.dart';

@immutable
sealed class ShowFoodState {}

final class ShowFoodInitial extends ShowFoodState {}

final class LoadingState extends ShowFoodState{}

final class OnMemberState extends ShowFoodState{
  final List<PeopleModel> people;
  final List<FoodModel> food;
  final List<int> ids;
  final List<FoodModel> resultedFood;
  OnMemberState({
    required this.people,
    required this.ids,
    required this.food,
    required this.resultedFood
  });
}
