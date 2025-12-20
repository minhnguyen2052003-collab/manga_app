class Category {
  final String? id;
  final String? title;
  final String? slug;

  Category({this.id, this.title, this.slug});

  factory Category.fromJson(Map<String, dynamic> json) {
    final attributes = json['attributes'];
    return Category(
      id: json['id'] ?? "" ,
      title: attributes['title'] ?? 'Unknown',
      slug: attributes['slug'] ?? "",
    );
  }
}
