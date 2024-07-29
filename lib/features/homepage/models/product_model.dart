class ProductModel {
  final String id;
  final String name;
  final String description;
  final String price;
  final String imageUrl;
  final bool wishlisted;

  ProductModel( {
    required this.id,
    required this.name,
    required this.description,
    required this.price,
    required this.imageUrl,
    required this.wishlisted,
  });

  String get getName {
    return name;
  }
}
