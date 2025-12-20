class PosterImage {
  final String? tiny;
  final String? medium;
  final String? large;

  PosterImage({required this.large, required this.medium, required this.tiny});

  factory PosterImage.fromJson(Map<String, dynamic> json) {
    return PosterImage(
      large: json["large"],
      medium: json["medium"],
      tiny: json["tiny"],
    );
  }

  void operator [](String other) {}
}
