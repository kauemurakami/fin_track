import 'dart:convert';

// Função para converter um List<Map<String, dynamic>> em uma lista de Category
List<CategoryModel> categoriesFromMap(List<Map<String, dynamic>> categoryMaps) {
  return List<CategoryModel>.from(categoryMaps.map((map) => CategoryModel.fromJson(map)));
}

CategoryModel categoryFromJson(String str) => CategoryModel.fromJson(json.decode(str));

String categoryToJson(CategoryModel data) => json.encode(data.toJson());

class CategoryModel {
  int? id;
  String? name;

  CategoryModel({
    this.id,
    this.name,
  });

  factory CategoryModel.fromJson(Map<String, dynamic> json) => CategoryModel(
        id: json["id"],
        name: json["name"],
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "name": name,
      };
}
