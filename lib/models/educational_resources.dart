class EducationalResource {
  String? id;
  late String title;
  late String description;

  EducationalResource({
    required this.title,
    required this.description,
    this.id,
  });

  EducationalResource.fromMap(Map obj, [this.id]) {
    title = obj["title"];
    description = obj["description"];
  }

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    if (id != null) map["id"] = id;
    map["title"] = title;
    map["description"] = description;
    return map;
  }
}
