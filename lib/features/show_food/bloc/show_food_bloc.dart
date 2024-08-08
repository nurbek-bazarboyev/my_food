import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';
import 'package:safiyya_cooking/features/show_food/api/show_food_api.dart';

import '../../add_food/model/add_food_model.dart';

part 'show_food_event.dart';

part 'show_food_state.dart';

class ShowFoodBloc extends Bloc<ShowFoodEvent, ShowFoodState> {
  ShowFoodApi api;

  ShowFoodBloc(this.api) : super(ShowFoodInitial()) {
    on<GetPeople>((event, emit) async {
      List<PeopleModel> p = [];
      List<FoodModel> f = [];
      List<int> s = [];
      List<FoodModel> resultedFood = [];
      if (state is OnMemberState) {
        p = (state as OnMemberState).people;
        f = (state as OnMemberState).food;
        s = (state as OnMemberState).ids;
      }
      emit(LoadingState());
      final snapshot = await api.getPeople();
      final snapshot2 = await api.getFood();
      p = snapshot.docs
          .map((snapshot) => PeopleModel.fromJson(snapshot.data(), snapshot.id))
          .toList();
      f = snapshot2.docs
          .map((snapshot) => FoodModel.fromJson(snapshot.data(), snapshot.id))
          .toList();
      emit(OnMemberState(people: p, ids: s, food: f,resultedFood: resultedFood));
    });

    on<ChangeCheckBox>((event, emit) {
      if (event.value == null || state is LoadingState) {
        return;
      }

      List<PeopleModel> p = (state as OnMemberState).people;
      List<FoodModel> f = (state as OnMemberState).food;
      List<int> s = (state as OnMemberState).ids;
      List<FoodModel> resultedFood = [];
      if (event.value!) {
        s.add(event.id);
      } else {
        s.remove(event.id);
      }
      emit(OnMemberState(people: p, ids: s, food: f,resultedFood: resultedFood));
    });

    on<SearchFood>((event, emit) {

      // _resultedFood.clear();
      List<FoodModel> food = (state as OnMemberState).food;
      List<int> selectedIds = (state as OnMemberState).ids;
      List<FoodModel> resultedFood = [];
      List<PeopleModel> p = (state as OnMemberState).people;
      emit(LoadingState());
      for (var food in food) {
        if (selectedIds
            .every((element) => food.ids.contains(element))) {
          resultedFood.add(food);
        }
      }
      emit(OnMemberState(people: p, ids: selectedIds, food: food, resultedFood: resultedFood));
    });
  }
}
