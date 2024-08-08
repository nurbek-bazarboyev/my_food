import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:safiyya_cooking/features/add_food/api/add_food_api.dart';
import 'package:safiyya_cooking/features/add_food/ui/add_food_page.dart' as a;
import '../bloc/add_food_bloc.dart';

class Food extends StatefulWidget {
  const Food({super.key});

  @override
  State<Food> createState() => _FoodState();
}

class _FoodState extends State<Food> {

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => AddFoodBloc(AddFoodApi()),
      child: Builder(
          builder: (context) {
            context.read<AddFoodBloc>().add(GetFood());
            return BlocBuilder<AddFoodBloc, AddFoodState>(
              builder: (context, state) {
                return Scaffold(
                  appBar: AppBar(
                    centerTitle: true,
                    title: Text("Taomlar"),
                  ),
                  floatingActionButton: FloatingActionButton(
                    onPressed: () async {
                      await Navigator.push(
                          context, MaterialPageRoute(
                          builder: (_) => BlocProvider.value(
                            value: context.read<AddFoodBloc>(),
                            child: a.AddFood(),
                          )));


                    },
                    child: Icon(Icons.add),
                  ),
                  body: (state is LoadingState || state is AddFoodInitial)
                      ? const Center(
                    child: CircularProgressIndicator.adaptive(),
                  )
                      : ListView.builder(
                      itemCount: (state as OnDataState).food.length,
                      itemBuilder: (context, index) {
                        final food = (state as OnDataState).food[index];
                        return ListTile(
                          title: Text(food.name),
                          trailing: IconButton(
                              onPressed: () async {
                                context.read<AddFoodBloc>().add(DeleteFood(docId: food.docId));
                              },
                              icon: Icon(
                                Icons.delete,
                                color: Colors.red,
                              )),
                        );
                      }),
                );
              },
            );
          }
      ),
    );
  }
}
