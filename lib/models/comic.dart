class Comic {
  final String id;
  final String title;
  final String author;

  final String status;       // Ví dụ: "Chap 600"
  final String chapter;      // Ví dụ: "Chap 600"
  final String type;         // Ví dụ: "Màu", "Tranh màu"

  final String updatedAt;    // Ngày cập nhật
  final List<String> tags;   // Danh sách thể loại / tag

  final double rating;       // Điểm đánh giá
  final int reviews;         // Số lượng đánh giá
  final int views;           // Lượt xem
  final int favorites;       // Lượt yêu thích
  final String readers;      // Ví dụ: "70M+"

  final int price;           // Giá truyện
  final String description;  // Mô tả truyện

  final String cover;        // Đường dẫn ảnh trong assets

  Comic({
    required this.id,
    required this.title,
    required this.author,
    required this.status,
    required this.chapter,
    required this.type,
    required this.updatedAt,
    required this.tags,
    required this.rating,
    required this.reviews,
    required this.views,
    required this.favorites,
    required this.readers,
    required this.price,
    required this.description,
    required this.cover,
  });
}
