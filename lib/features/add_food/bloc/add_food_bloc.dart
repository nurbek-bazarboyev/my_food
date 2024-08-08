import 'dart:math';

import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';
import '../../show_food/model/show_food_model.dart';
import '../api/add_food_api.dart';

part 'add_food_event.dart';

part 'add_food_state.dart';

class AddFoodBloc extends Bloc<AddFoodEvent, AddFoodState> {
  final AddFoodApi api;

  AddFoodBloc(this.api) : super(AddFoodInitial()) {

    on<GetFood>((event, emit) async {
      List<PeopleModel> p = [];
      List<int> s = [];
      if (state is OnDataState) {
        p = (state as OnDataState).people;
        s = (state as OnDataState).selectedIds;
      }
      emit(LoadingState());

      final snapshot = await api.getFood();
      List<FoodModel> food = snapshot.docs
          .map((snap) => FoodModel.fromJson(snap.data(), snap.id))
          .toList();

      emit(OnDataState(people: p, food: food, selectedIds: s));
    });


    on<GetPeople>((event, emit) async{
      List<FoodModel> f = [];
      List<int> s = [];
      if (state is OnDataState) {
        f = (state as OnDataState).food;
        s = (state as OnDataState).selectedIds;
      }
      emit(LoadingState());

      final snapshot = await api.getPeople();
      List<PeopleModel> people = snapshot.docs
          .map((snap) => PeopleModel.fromJson(snap.data(), snap.id))
          .toList();

      emit(OnDataState(people: people, food: f, selectedIds: s));
    });


    on<ChangeCheckBox>((event, emit) {
      if(event.value == null || state is LoadingState){
        return;
      }
      final a = (state as OnDataState);
      List<PeopleModel> p = a.people;
      List<FoodModel> f = a.food;
      List<int> s = a.selectedIds;

      if(event.value!){s.add(event.id);}
      else{s.remove(event.id);}

      emit(OnDataState(people: p, food: f, selectedIds: s));
    });


    on<AddFood>((event, emit) async{
      if(event.name == null || (state as OnDataState).selectedIds.isEmpty){
        return;
      }

      final data = {
        'name': event.name,
        'ids': (state as OnDataState).selectedIds,
        'id': Random().nextInt(1000000)
      };
      emit(LoadingState());
      await api.addFood(data);
      add(GetFood());
    });


    on<DeleteFood>((event, emit) async{
      await api.deleteFood(event.docId);
      add(GetFood());
    });
  }
}
