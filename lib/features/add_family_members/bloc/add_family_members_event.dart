part of 'add_family_members_bloc.dart';

@immutable
sealed class AddFamilyMembersEvent {}

class GetPeople extends AddFamilyMembersEvent{}

class AddMember extends AddFamilyMembersEvent{
  final String name;
  AddMember({required this.name});
}

class DeleteMember extends AddFamilyMembersEvent{
  final String docId;
  DeleteMember({required this.docId});
}
