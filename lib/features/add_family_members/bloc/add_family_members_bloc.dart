import 'dart:math';

import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';

import '../../show_food/model/show_food_model.dart';
import '../api/add_family_members_api.dart';

part 'add_family_members_event.dart';
part 'add_family_members_state.dart';

class AddFamilyMembersBloc extends Bloc<AddFamilyMembersEvent, AddFamilyMembersState> {
  final AddFamilyMemberApi api;
  AddFamilyMembersBloc(this.api) : super(AddFamilyMembersInitial()) {

    on<GetPeople>((event, emit) async{
      emit(LoadingState());

      final snapshot = await api.getPeople();

      List<PeopleModel> _people = snapshot.docs
          .map((snapshot) => PeopleModel.fromJson(snapshot.data(), snapshot.id))
          .toList();

      emit(MemberState(_people));

    });


    on<AddMember>((event, emit) async{
      final id = Random().nextInt(1000000);

      final data = {'name': event.name, 'id': id};

      await api.AddMember(data);
      add(GetPeople());
    });


    on<DeleteMember>((event, emit) async{
      await api.DeleteMember(event.docId);
      add(GetPeople());
    });


     }
}
