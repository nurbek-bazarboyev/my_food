part of 'add_food_bloc.dart';

@immutable
sealed class AddFoodEvent {}
final class GetFood extends AddFoodEvent{}

final class GetPeople extends AddFoodEvent{}

final class AddFood extends AddFoodEvent{

  final String? name;
  AddFood({required this.name});
}
final class DeleteFood extends AddFoodEvent{

  final String docId;
  DeleteFood({required this.docId});
}
final class ChangeCheckBox extends AddFoodEvent{

  final bool? value;
  final int id;
  ChangeCheckBox({
    required this.value,
    required this.id
  });
}