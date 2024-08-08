import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:safiyya_cooking/features/add_family_members/ui/add_family_members_page.dart';
import 'package:safiyya_cooking/features/add_food/ui/food_page.dart';
import 'package:safiyya_cooking/features/show_food/api/show_food_api.dart';
import 'package:safiyya_cooking/features/show_food/bloc/show_food_bloc.dart';

import '../model/show_food_model.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => ShowFoodBloc(ShowFoodApi()),
      child: Builder(
          builder: (context) {
            context.read<ShowFoodBloc>().add(GetPeople());
            return BlocBuilder<ShowFoodBloc, ShowFoodState>(
              builder: (context, state) {
                return Scaffold(
                  appBar: AppBar(
                    centerTitle: true,
                    title: Text("Saffiya Cooking"),
                    actions: [
                      IconButton(
                          onPressed: () {
                            Navigator.push(
                                context,
                                MaterialPageRoute(
                                    builder: (context) => People()));
                          },
                          icon: Icon(Icons.person_add_alt_1_rounded)),
                      IconButton(
                          onPressed: () {
                            Navigator.push(
                                context, MaterialPageRoute(
                                builder: (context) => Food()));
                          },
                          icon: Icon(Icons.cookie_outlined))
                    ],
                  ),
                  body: (state is LoadingState || state is ShowFoodInitial)

                      ? Center(
                    child: CircularProgressIndicator.adaptive(),
                  )
                      : ListView(
                    padding: EdgeInsets.all(12),
                    children: [
                      ListView.builder(
                          shrinkWrap: true,
                          padding: EdgeInsets.zero,
                          itemCount: (state as OnMemberState).people.length,
                          itemBuilder: (context, index) {
                            final people = state.people[index];
                            return CheckboxListTile(
                                contentPadding: EdgeInsets.zero,
                                title: Text(people.name),
                                value: state.ids.contains(people.id),
                                onChanged: (bool? value) {
                                  context.read<ShowFoodBloc>().add(ChangeCheckBox(value: value, id: people.id));
                                });
                          }),
                      const SizedBox(
                        height: 24,
                      ),
                      SizedBox(
                        width: double.infinity,
                        height: 48,
                        child: ElevatedButton(
                            onPressed: () {
                              context.read<ShowFoodBloc>().add(SearchFood());
                            },
                            child: Text("Qidirish")),
                      ),
                      SizedBox(
                        height: 24,
                      ),
                      ListView.builder(
                          shrinkWrap: true,
                          padding: EdgeInsets.zero,
                          itemCount: (state as OnMemberState).resultedFood.length,
                          itemBuilder: (context, index) {
                            final food = (state as OnMemberState).resultedFood[index];
                            return ListTile(
                              contentPadding: EdgeInsets.zero,
                              title: Text(food.name),
                            );
                          })
                    ],
                  ),
                );
              },
            );
          }
      ),
    );
  }
}
