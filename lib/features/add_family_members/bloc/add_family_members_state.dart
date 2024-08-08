part of 'add_family_members_bloc.dart';

@immutable
sealed class AddFamilyMembersState {}

final class AddFamilyMembersInitial extends AddFamilyMembersState {}

final class LoadingState extends AddFamilyMembersState{}

final class MemberState extends AddFamilyMembersState{
  List<PeopleModel> people;
  MemberState(this.people);
}
