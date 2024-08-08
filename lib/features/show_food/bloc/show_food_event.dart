part of 'show_food_bloc.dart';

@immutable
sealed class ShowFoodEvent {}

final class GetPeople extends ShowFoodEvent{}

final class GetFood extends ShowFoodEvent{}

final class ChangeCheckBox extends ShowFoodEvent{
  final bool? value;
  final int id;
  ChangeCheckBox({
    required this.value,
    required this.id
});
}

final class SearchFood extends ShowFoodEvent{}

