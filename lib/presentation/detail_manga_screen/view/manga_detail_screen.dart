
import 'dart:math';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

import '../../../utils/Manga.dart';
import '../../payment_screen/view/payment_screen.dart';
import '../../rating_screen/view/rating_screen.dart';
import '../widget/basic_infor_comic.dart';
import '../widget/favorite_star_widget.dart';
import '../widget/five_stars.dart';
import '../widget/star_rating.dart';

class MangaDetailScreen extends StatelessWidget {
  const MangaDetailScreen({super.key, required this.selectedManga});

  final Manga selectedManga;

  @override
  Widget build(BuildContext context) {
    bool _isFavorite = false;

    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: Colors.white,
        actions: [
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: FavoriteStarWidget(selectedManga: selectedManga,),
          ),
        ],
      ),
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            BasicInforMangaWidget(
                selectedManga: selectedManga, isBuying: false),
            SizedBox(height: 4),
            Container(
              padding: EdgeInsets.symmetric(horizontal: 16),
              child: Row(
                children: [
                  Expanded(
                    child: _ratingItem(
                      rating: selectedManga.rating ?? 0,
                      title: selectedManga.rating.toString(),
                      icon: Icons.star,
                      content: "",
                    ),
                  ),
                  Container(width: 1, height: 32, color: Colors.grey.shade300),
                  Expanded(
                    child: _ratingItem(
                      rating: selectedManga.rating ?? 0,
                      title: "${selectedManga.attributes.favoriteCount}",
                      icon: null,
                      content: "Lượt thích",
                    ),
                  ),
                  Container(width: 1, height: 32, color: Colors.grey.shade300),
                  Expanded(
                    child: _ratingItem(
                      rating: selectedManga.rating ?? 0,
                      title: "${selectedManga.attributes.userCount}",
                      icon: null,
                      content: "Lượt đọc",
                    ),
                  ),
                  Container(width: 1, height: 32, color: Colors.grey.shade300),
                  Expanded(
                    child: _ratingItem(
                      rating: selectedManga.rating ?? 0,
                      title: selectedManga.attributes.averageRating ?? "0",
                      icon: null,
                      content: "Tỷ lệ đánh giá",
                    ),
                  ),
                ],
              ),
            ),
            SizedBox(height: 24),
            InkWell(
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) =>
                        PaymentScreen(selectedManga: selectedManga),
                  ),
                );
              },
              child: Container(
                height: 48,
                margin: EdgeInsets.symmetric(horizontal: 16),
                decoration: BoxDecoration(
                  borderRadius: BorderRadiusGeometry.circular(24),
                  color: Colors.blue,
                ),
                padding: EdgeInsets.all(4),
                child: Center(
                  child: Text(
                    "Mua với giá ${selectedManga.price}đ",
                    style: TextStyle(color: Colors.white, fontSize: 18),
                  ),
                ),
              ),
            ),
            SizedBox(height: 24),
            Padding(
              padding: EdgeInsets.symmetric(horizontal: 16),
              child: GestureDetector(
                child: Text(
                  "Cốt truyện",
                  style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
                ),
              ),
            ),
            SizedBox(height: 16),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16),
              child: Text(
                selectedManga.attributes.description ?? "Unknow",
                style: TextStyle(color: Colors.grey, fontSize: 16),
              ),
            ),
            SizedBox(height: 24),
            Padding(
              padding: EdgeInsets.symmetric(horizontal: 16),
              child: Text(
                "Đánh giá và Bình luận",
                style: TextStyle(
                  color: Colors.black,
                  fontSize: 20,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
            SizedBox(height: 8),
            Container(
              padding: EdgeInsets.symmetric(horizontal: 0),
              height: 140,
              width: double.infinity,
              child: Row(
                children: [
                  Expanded(
                    flex: 2,
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Text(
                          selectedManga.rating.toString() ?? "0",
                          style: TextStyle(
                            color: Colors.black,
                            fontWeight: FontWeight.bold,
                            fontSize: 32,
                          ),
                        ),
                        // Row(
                        //   mainAxisAlignment: MainAxisAlignment.center,
                        //   children: [
                        //     ...List.generate(
                        //       5,
                        //           (index) =>
                        //           Icon(
                        //             Icons.star,
                        //             size: 24,
                        //             color: Colors.blue,
                        //           ),
                        //     ),
                        //   ],
                        // ),
                        FiveStarsWidget(ratio: selectedManga.rating ?? 0),
                        SizedBox(height: 4),
                        Text("(${selectedManga.attributes.userCount} reviews)"),
                      ],
                    ),
                  ),
                  // Container(width: 1, height:eight: 2, thickness: 2 )),
                  VerticalDivider(
                    color: Colors.grey.shade300,
                    width: 20,
                    thickness: 1,
                    indent: 8,
                    endIndent: 8,
                  ),
                  Expanded(
                    flex: 3,
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        ...List.generate(5, (index) {
                          int number = 5 - index;
                          double ratingValue = Random().nextDouble();
                          return _ratingBar(
                            context: context,
                            number: number,
                            metric: ratingValue,
                          );
                        }),
                      ],
                    ),
                  ),
                ],
              ),
            ),
            SizedBox(height: 16),
            Center(
              child: Text(
                "Đánh giá truyện này",
                style: TextStyle(
                  color: Colors.black,
                  fontWeight: FontWeight.bold,
                  fontSize: 16,
                ),
              ),
            ),
            SizedBox(height: 8),
            Center(child: StarRating()),
            SizedBox(height: 8),
            Center(
              child: OutlinedButton(
                style: OutlinedButton.styleFrom(
                  side: BorderSide(color: Colors.blue, width: 2),
                ),
                onPressed: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) =>
                          RatingScreen(selectedManga: selectedManga),
                    ),
                  );
                },
                child: Text(
                  "Gửi đánh giá",
                  style: TextStyle(color: Colors.blue, fontSize: 16),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _shareItem({
    required IconData icon,
    required String title,
    required VoidCallback onTap,
  }) {
    return InkWell(
      onTap: onTap,
      borderRadius: BorderRadius.circular(12),
      child: Column(
        children: [
          Container(
            width: 56,
            height: 56,
            decoration: BoxDecoration(
              color: Colors.grey.shade200,
              shape: BoxShape.circle,
            ),
            child: Center(child: FaIcon(icon, size: 26)),
          ),
          const SizedBox(height: 8),
          Text(title),
        ],
      ),
    );
  }

  void showShareBottomSheet(BuildContext context) {
    showModalBottomSheet(
      context: context,
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(top: Radius.circular(20)),
      ),
      builder: (context) {
        return Padding(
          padding: const EdgeInsets.all(16),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              const Text(
                "Chia sẻ qua",
                style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
              ),
              const SizedBox(height: 20),

              Row(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: [
                  _shareItem(
                    icon: FontAwesomeIcons.facebookF,
                    title: "Facebook",
                    onTap: () {
                      Navigator.pop(context);
                      print("Share Facebook");
                    },
                  ),
                  _shareItem(
                    icon: FontAwesomeIcons.xTwitter,
                    title: "X",
                    onTap: () {
                      Navigator.pop(context);
                      print("Share X");
                    },
                  ),
                  _shareItem(
                    icon: FontAwesomeIcons.commentDots,
                    title: "Zalo",
                    onTap: () {
                      Navigator.pop(context);
                      print("Share Zalo");
                    },
                  ),
                  _shareItem(
                    icon: FontAwesomeIcons.instagram,
                    title: "Instagram",
                    onTap: () {
                      Navigator.pop(context);
                      print("Share Instagram");
                    },
                  ),
                ],
              ),

              const SizedBox(height: 20),
            ],
          ),
        );
      },
    );
  }

  Widget _ratingItem({
    required String title,
    required IconData? icon,
    required String content,
    required double rating
  }) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              title,
              style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
            ),
            SizedBox(width: 4),
            if (icon != null)
              ShaderMask(shaderCallback: (Rect bounds) {
                return LinearGradient(colors: [Colors.blue, Colors.yellow],
                    stops: [0.5, 0.5],
                    begin: Alignment.centerLeft,
                    end: Alignment.centerRight).createShader(bounds);
              },
                child: Icon(Icons.star, size: 24, color: Colors.white,),
              )
          ],
        ),
        SizedBox(height: 4),
        Text(content, style: TextStyle(fontSize: 10)),
      ],
    );
  }

  Widget _ratingBar(
      {required int number, required double metric, required BuildContext context}) {
    return Column(
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              number.toString(),
              style: TextStyle(fontWeight: FontWeight.bold),
            ),
            SizedBox(width: 8),
            // Container(
            //   width: 168,
            //   height: 6,
            //   decoration: BoxDecoration(
            //     borderRadius: BorderRadius.circular(12),
            //     gradient: LinearGradient(
            //       begin: Alignment.centerLeft,
            //       end: Alignment.centerRight,
            //       colors: [
            //         Colors.blue,
            //         Colors.blue,
            //         Colors.grey.shade300,
            //         Colors.grey.shade300,
            //       ],
            //       stops: [0.0, metric, metric, 1.0],
            //     ),
            //   ),
            // ),
            Container(
              decoration: BoxDecoration(
                  color: Colors.grey,
                  borderRadius: BorderRadius.circular(40)
              ),
              height: 6,
              width: MediaQuery
                  .of(context)
                  .size
                  .width * 0.5,
              child: Row(
                children: [
                  Expanded(
                    flex: (metric * 100).round(),
                    child: Container(
                      decoration: BoxDecoration(
                        color: Colors.blue,
                        borderRadius: BorderRadius.circular(999),
                      ),
                    ),
                  ),
                  Expanded(
                    flex: ((100 - metric * 100)).round(),
                    child: Container(
                      decoration: BoxDecoration(
                        color: Colors.grey,
                        borderRadius: BorderRadius.circular(999),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
        SizedBox(height: 4),
      ],
    );
  }
}
