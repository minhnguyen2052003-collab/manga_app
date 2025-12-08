import 'package:comic_app_gpt/models/comic.dart';
import 'package:comic_app_gpt/widgets/star_rating.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';


class ComicDetailScreen extends StatefulWidget{
  const ComicDetailScreen({super.key, required this.selectedComic});
  
  final Comic selectedComic;

  @override
  State<ComicDetailScreen> createState() => _ComicDetailScreenState();
}

class _ComicDetailScreenState extends State<ComicDetailScreen> {

  bool isBuying = false;

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
            child: Center(
              child: FaIcon(icon, size: 26),
            ),
          ),
          const SizedBox(height: 8),
          Text(title),
        ],
      ),
    );
  }




  void showShareBottomSheet(BuildContext context){
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
                style: TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.bold,
                ),
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


  Widget inforUI(){
    return Column(
      key: ValueKey(1),
      children: [
        Container(
          padding: EdgeInsets.symmetric(horizontal: 15),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Column(
                children: [
                  Row(
                    children:  [
                      Text(
                        widget.selectedComic.rating.toString(),
                        style: TextStyle(
                          fontSize: 18,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      SizedBox(width: 4),
                      Icon(Icons.star, size: 18, color: Colors.orange),
                    ],
                  ),
                  SizedBox(height: 4),
                  Text(
                    widget.selectedComic.reviews.toString(),
                    style: TextStyle(
                      fontSize: 12,
                      color: Colors.grey,
                    ),
                  ),
                ],
              ),
              
              Container(width: 1, height: 30, color: Colors.grey.shade300),
              
              Column(
                children: [
                  Text(
                    widget.selectedComic.views.toString(),
                    style: TextStyle(
                      fontSize: 18,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  SizedBox(height: 4),
                  Text(
                    "Lượt xem",
                    style: TextStyle(
                      fontSize: 12,
                      color: Colors.grey,
                    ),
                  ),
                ],
              ),
          
              Container(width: 1, height: 30, color: Colors.grey.shade300),
          
              // --- ITEM 3 ---
              Column(
                children:  [
                  Text(
                    widget.selectedComic.favorites.toString(),
                    style: TextStyle(
                      fontSize: 18,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  SizedBox(height: 4),
                  Text(
                    "Lượt yêu thích",
                    style: TextStyle(
                      fontSize: 12,
                      color: Colors.grey,
                    ),
                  ),
                ],
              ),
          
              Container(width: 1, height: 30, color: Colors.grey.shade300),
          
              // --- ITEM 4 ---
              Column(
                children:  [
                  Text(
                    widget.selectedComic.readers,
                    style: TextStyle(
                      fontSize: 18,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  SizedBox(height: 4),
                  Text(
                    "Lượt mua",
                    style: TextStyle(
                      fontSize: 12,
                      color: Colors.grey,
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
        SizedBox(height: 10,),
        Container(
          width: double.infinity,
          height: 90,
          padding: EdgeInsets.all(16),
          child: ElevatedButton(
              style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.blue,
                  foregroundColor: Colors.white,
                  minimumSize: Size(200, 48),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadiusGeometry.circular(30),

                  ),
                  elevation: 3
              ),
              onPressed: (){
                setState(() {
                  isBuying = true;
                });
              },
              child: Text("Mua với giá ${widget.selectedComic.price} đ", style: TextStyle(
                  fontSize: 20
              ),)
          ),
        ),
        SizedBox(height: 12,),
        TextButton(
            onPressed: (){},
            child: Text("Cốt Truyện",
              style: TextStyle(
                color: Colors.black,
                fontSize: 25,
                fontWeight: FontWeight.bold,
              ),
            )
        ),
        SizedBox(height: 5,),
        Padding(
          padding: const EdgeInsets.all(10),
          child: Text(widget.selectedComic.description),
        ),
        SizedBox(height: 12,),
        Padding(
          padding: const EdgeInsets.all(8.0),
          child: Text(
            "Đánh giá và Bình luận",
            style: TextStyle(
              fontSize: 20,
              fontWeight: FontWeight.bold,
            ),
          ),
        ),
        SizedBox(height: 8,),
        Container(
          height: 125,
          width: double.infinity,
        ),
        SizedBox(height: 10,),
        Align(
          alignment: Alignment.center,
          child: Text(
            "Đánh giá truyện này",
            style: TextStyle(
              fontSize: 16,
              fontWeight: FontWeight.bold,
            ),
          ),
        ),
        SizedBox(height: 8,),
        Align(
            alignment: Alignment.center,
            child: StarRating(size: 32, maxRating: 5, selectedColor: Colors.amber, unselectedColor: Colors.black)),
        SizedBox(height: 8,),
        Align(
          alignment: Alignment.center,
          child: ElevatedButton(
              style: ElevatedButton.styleFrom(
                backgroundColor: Colors.white,
              ),
              onPressed: (){},
              child: Text(
                "Gửi Đánh Giá",
                style: TextStyle(
                  color: Colors.blue,
                  fontSize: 14,
                ),
              )
          ),
        )
      ],
    );
  }

  Widget paymentUI(){
    return Column(
      key: ValueKey(2),
      children: [
        Container(
          alignment: Alignment.centerLeft,
          width: double.infinity,
          height: 50,
          child: TextButton(
              onPressed: (){},
              child: Text("Thanh toán bằng Coin", style: TextStyle(fontSize: 20),)),
        ),
        SizedBox(height: 8,),
        Container(
          alignment: Alignment.centerLeft,
          width: double.infinity,
          height: 50,
          child: TextButton(
              onPressed: (){},
              child: Text("Thanh toán qua Thẻ cào", style: TextStyle(fontSize: 20),)),
        ),
        SizedBox(height: 8,),
        Container(
          alignment: Alignment.centerLeft,
          width: double.infinity,
          height: 50,
          child: TextButton(
              onPressed: (){},
              child: Text("Thanh toán qua Chuyển khoản", style: TextStyle(fontSize: 20),)),
        ),
        SizedBox(height: 8,),
        Container(
          alignment: Alignment.centerLeft,
          width: double.infinity,
          height: 50,
          child: TextButton(
              onPressed: (){},
              child: Text("Thanh toán qua Momo", style: TextStyle(fontSize: 20),)),
        ),


      ],
    );
  }

  @override
  Widget build(BuildContext context) {


    return Scaffold(
      appBar: AppBar(
        actions: [
          ElevatedButton(onPressed: (){
            showShareBottomSheet(context);
          },
              child: Text("Chia Sẻ"),
            style: ElevatedButton.styleFrom(
              backgroundColor: Colors.blue,
              foregroundColor: Colors.white,
            ),
          )
        ],
      ),
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Container(
              height: 250,
              width: double.infinity,
              padding: EdgeInsets.all(4),
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  ClipRRect(
                    borderRadius:  BorderRadius.circular(10),
                    child: Image.asset(
                        widget.selectedComic.cover,
                      fit: BoxFit.cover,

                    ),

                  ),
                  Expanded(
                    child: Column(
                      children: [
                        Text(
                          widget.selectedComic.title,
                          style: TextStyle(
                            fontSize: 20,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        SizedBox(height: 12,),
                        Row(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            const Text(
                              "Tác Giả:",
                                style: TextStyle(
                                  color: Colors.grey,
                                  fontSize: 14,
                                ),
                            ),
                            SizedBox(width: 8,),
                            Expanded(
                                child: Text(
                                    widget.selectedComic.author,
                                  style: TextStyle(
                                    color: Colors.grey,
                                    fontSize: 14,
                                  ),
                                )
                            )
                          ],
                        ),
                        SizedBox(height: 6,),
                        Row(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            const Text(
                              "Tình Trạng:",
                              style: TextStyle(
                                color: Colors.grey,
                                fontSize: 14,
                              ),
                            ),
                            SizedBox(width: 8,),
                            Expanded(
                                child: Text(
                                  widget.selectedComic.status,
                                  style: TextStyle(
                                    color: Colors.grey,
                                    fontSize: 14,
                                  ),
                                )
                            )
                          ],
                        ),
                        SizedBox(height: 6,),
                        Row(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            const Text(
                              "Chapters:",
                              style: TextStyle(
                                color: Colors.grey,
                                fontSize: 14,
                              ),
                            ),
                            SizedBox(width: 8,),
                            Expanded(
                                child: Text(
                                  widget.selectedComic.chapter,
                                  style: TextStyle(
                                    color: Colors.grey,
                                    fontSize: 14,
                                  ),
                                )
                            )
                          ],
                        ),
                        SizedBox(height: 6,),
                        Row(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            const Text(
                              "Cập Nhật:",
                              style: TextStyle(
                                color: Colors.grey,
                                fontSize: 14,
                              ),
                            ),
                            SizedBox(width: 8,),
                            Expanded(
                                child: Text(
                                  widget.selectedComic.updatedAt,
                                  style: TextStyle(
                                    color: Colors.grey,
                                    fontSize: 14,
                                  ),
                                )
                            )
                          ],
                        ),
                        SizedBox(height: 6,),
                        Wrap(
                          spacing: 0,
                          runSpacing: 0,
                          children: [
                        ...List.generate(
                            widget.selectedComic.tags.length,
                            (index){
                              final genre = widget.selectedComic.tags[index];
                              return TextButton(
                                  onPressed: (){},
                                  child: Text(genre));
                            }

                        )
                            ]
                        ),
                      ],
                    ),
                  )
                ],
              ),
            ),
            SizedBox(height: 10,),
            AnimatedSwitcher(
                duration: Duration(milliseconds: 100),
              child: isBuying ? paymentUI() : inforUI(),
            )




          ],
        ),
      ),
    );
  }
}