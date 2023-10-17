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
}
