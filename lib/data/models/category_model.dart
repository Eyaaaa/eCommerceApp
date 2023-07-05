class Category {
  final String nom_categorie;
  final String image_categorie;
  final String description_categorie;

  Category({
    required this.nom_categorie,
    required this.image_categorie,
    required this.description_categorie,
  });

  factory Category.fromJson(Map<String, dynamic> json) {
    return Category(
      nom_categorie: json['nom_categorie'] ?? '',
      image_categorie: json['image_categorie'] ?? '',
      description_categorie: json['description_categorie'] ?? '',
    );
  }
}