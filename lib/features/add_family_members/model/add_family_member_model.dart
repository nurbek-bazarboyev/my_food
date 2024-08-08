class PeopleModel {
  final String docId;
  final int id;
  final String name;

  PeopleModel(this.docId, this.id, this.name);

  factory PeopleModel.fromJson(Map<String, dynamic> data, String docId) {
    return PeopleModel(docId, data['id'], data['name']);
  }
}