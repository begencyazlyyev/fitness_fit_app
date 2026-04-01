class UserModel {
  final String name;
  final String price;
  final String country;
  final String? imagePath;
  UserModel({
    required this.name,
    required this.price,
    required this.country,
    this.imagePath,
  });

  UserModel copyWith({String? name, String? price, String? country}) {
    return UserModel(
      name: name ?? this.name,
      price: price ?? this.price,
      country: country ?? this.country,
    );
  }
}
