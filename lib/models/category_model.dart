class CategoryModel {
  final String name;
  final String imageUrl;

  const CategoryModel({required this.name, required this.imageUrl});

  CategoryModel.init({
    required this.name,
    required this.imageUrl,
  });

  toJson() {
    return {
      'name': name,
      'image': imageUrl,
    };
  }

  factory CategoryModel.fromJson(Map<String, dynamic> json) {
    return CategoryModel(
      name: json['name'],
      imageUrl: json['image'],
    );
  }
}
