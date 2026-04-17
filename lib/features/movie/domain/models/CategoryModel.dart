class CategoryModel {
  String category;
  String categorySlug;

  CategoryModel({required this.category, required this.categorySlug});

  @override
  String toString() {
    return 'CategoryModel{category: $category, categorySlug: $categorySlug}';
  }
}
