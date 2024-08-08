class PeopleModel {
  final String docId;
  final int id;
  final String name;

  PeopleModel(this.docId, this.id, this.name);

  factory PeopleModel.fromJson(Map<String, dynamic> data, String docId) {
    return PeopleModel(docId, data['id'], data['name']);
  }
}

class FoodModel {
  final String docId;
  final String name;
  final int id;
  final List<int> ids;

  FoodModel(this.docId, this.id, this.name, this.ids);

  factory FoodModel.fromJson(Map<String, dynamic> data, String docId) {
    List<dynamic> ids = data['ids'];
    return FoodModel(
        docId, data['id'], data['name'], ids.map((e) => e as int).toList());
  }
}
