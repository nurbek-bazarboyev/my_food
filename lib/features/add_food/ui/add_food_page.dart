import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:safiyya_cooking/features/add_food/bloc/add_food_bloc.dart'as n;



class AddFood extends StatefulWidget {
  const AddFood({super.key});

  @override
  State<AddFood> createState() => _AddFoodState();
}

class _AddFoodState extends State<AddFood> {
  String foodName = '';

  @override
  Widget build(BuildContext context) {
    context.read<n.AddFoodBloc>().add(n.GetPeople());
    return BlocBuilder<n.AddFoodBloc, n.AddFoodState>(
      builder: (context, state) {
        return Scaffold(
          resizeToAvoidBottomInset: false,
          appBar: AppBar(
            centerTitle: true,
            title: Text("Taomni qo'shish"),
          ),
          body: (state is n.LoadingState || state is n.AddFoodInitial)
              ? Center(
            child: CircularProgressIndicator.adaptive(),
          )
              : Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              SizedBox(
                height: 24,
              ),
              Padding(
                padding: EdgeInsets.all(12),
                child: TextFormField(
                  onChanged: (value) => foodName = value,
                  decoration: InputDecoration(
                      border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(18)),
                      labelText: "Taom Nomi"),
                ),
              ),
              Padding(
                padding: EdgeInsets.all(12),
                child: Text(
                  "Oila azolari:",
                  style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
                ),
              ),
              ListView.builder(
                  shrinkWrap: true,
                  itemCount: (state as n.OnDataState).people.length,
                  itemBuilder: (context, index) {
                    final people = state.people[index];
                    return CheckboxListTile(
                      value: state.selectedIds.contains(people.id),
                      onChanged: (value) {
                       context.read<n.AddFoodBloc>().add(n.ChangeCheckBox(value: value, id: people.id));
                      },
                      title: Text(people.name),
                    );
                  }),
              Spacer(),
              Padding(
                padding: EdgeInsets.all(12),
                child: SizedBox(
                  width: double.infinity,
                  height: 48,
                  child: ElevatedButton(
                      onPressed: () async {
                        context.read<n.AddFoodBloc>().add(n.AddFood(name: foodName));
                     },
                      child: Text("Saqlash")),
                ),
              ),
              SizedBox(
                height: 48,
              )
            ],
          ),
        );
      },
    );
  }
}
