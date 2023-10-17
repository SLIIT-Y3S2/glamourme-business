class CategoryModel {
  final String name;
  final String image;

  const CategoryModel({required this.name, required this.image});

  CategoryModel.init({
    required this.name,
    required this.image,
  });

  toJson() {
    return {
      'name': name,
      'image': image,
    };
  }
}
