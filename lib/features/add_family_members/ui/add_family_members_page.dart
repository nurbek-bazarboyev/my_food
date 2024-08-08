import 'dart:math';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:safiyya_cooking/features/add_family_members/api/add_family_members_api.dart';
import 'package:safiyya_cooking/features/add_family_members/bloc/add_family_members_bloc.dart';

class People extends StatefulWidget {
  const People({super.key});

  @override
  State<People> createState() => _PeopleState();
}

class _PeopleState extends State<People> {

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => AddFamilyMembersBloc(AddFamilyMemberApi()),
      child: Builder(
          builder: (context) {
            context.read<AddFamilyMembersBloc>().add(GetPeople());
            return BlocBuilder<AddFamilyMembersBloc, AddFamilyMembersState>(
              builder: (context, state) {

                return Scaffold(
                  appBar: AppBar(
                    centerTitle: true,
                    title: Text("Oila azolari"),
                  ),
                  floatingActionButton: FloatingActionButton(
                    onPressed: () async {
                      final name = await showDialog<String?>(
                          context: context,
                          builder: (context) {
                            String? name;
                            return AlertDialog(
                              title: Text("Oila azosini qoshish"),
                              content: TextFormField(
                                onChanged: (value) => name = value,
                                decoration: InputDecoration(hintText: "Ism"),
                              ),
                              actions: [
                                TextButton(
                                    onPressed: () {
                                      Navigator.pop(context);
                                    },
                                    child: Text("Cancel")),
                                TextButton(
                                    onPressed: () {
                                      Navigator.pop(context, name);
                                    },
                                    child: Text("Save"))
                              ],
                            );
                          });
                      if (name == null) {
                        return;
                      }

                     context.read<AddFamilyMembersBloc>().add(AddMember(name: name));
                    },
                    child: Icon(Icons.add),
                  ),
                  body: (state is LoadingState || state is AddFamilyMembersInitial)
                      ? Center(
                    child: CircularProgressIndicator.adaptive(),
                  )
                      : ListView.builder(
                      itemCount: (state as MemberState).people.length,
                      itemBuilder: (context, index) {
                        final people = state.people[index];
                        return ListTile(
                          title: Text(people.name),
                          trailing: IconButton(
                              onPressed: () async {
                               context.read<AddFamilyMembersBloc>().add(DeleteMember(docId: people.docId));
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
