class Product {
  final int id;
  final String nom_produit;
  final String image_produit;
  final double prix_avant_remise;
  final String description_produit;

  Product({
    required this.id,
    required this.nom_produit,
    required this.image_produit,
    required this.prix_avant_remise,
    required this.description_produit,
  });

  factory Product.fromJson(Map<String, dynamic> json) {
    return Product(
      id: json['id'] ?? 0,
      nom_produit: json['nom_produit'] ?? '',
      image_produit: json['image_produit'] ?? '',
      prix_avant_remise: (json['prix_avant_remise'] != null) ? double.parse(json['prix_avant_remise'].toString()) : 0.0,
      description_produit: json['description_produit'] ?? '',
    );
  }
}
