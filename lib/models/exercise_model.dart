class Exercise {
  final String title;
  final String category;
  final String image;

  Exercise({required this.title, required this.category, required this.image});

  // Overriding these allows Cubit to compare exercises correctly
  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is Exercise && title == other.title && category == other.category;

  @override
  int get hashCode => title.hashCode ^ category.hashCode;
}
