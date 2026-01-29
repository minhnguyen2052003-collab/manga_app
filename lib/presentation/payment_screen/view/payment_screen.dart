
import 'package:comic_app_gpt/presentation/final_payment_screen/view/final_payment_screen.dart';
import 'package:comic_app_gpt/presentation/detail_manga_screen/widget/basic_infor_comic.dart';
import 'package:flutter/material.dart';

import '../../../utils/Manga.dart';

class PaymentScreen extends StatelessWidget {
  const PaymentScreen({super.key, required this.selectedManga});

  final Manga selectedManga;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: Colors.white,
        title: Text(
          "Phương thức thanh toán",
          style: TextStyle(
            color: Colors.black,
            fontSize: 20,
            fontWeight: FontWeight.bold,
          ),
        ),
      ),
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          BasicInforMangaWidget(selectedManga: selectedManga, isBuying: true),
          SizedBox(height: 24),
          Container(
            margin: EdgeInsets.symmetric(horizontal: 16),
            height: 1,
            width: double.infinity,
            color: Colors.grey.shade300,
          ),
          _paymentMethod(
            context,
            "assets/covers/coin.png",
            "Thanh toán bằng Coin",
          ),
          Container(
            margin: EdgeInsets.symmetric(horizontal: 16),
            height: 1,
            width: double.infinity,
            color: Colors.grey.shade300,
          ),
          _paymentMethod(
            context,
            "assets/covers/MoMo_Logo.png",
            "Thanh toán bằng Momo",
          ),
          Container(
            margin: EdgeInsets.symmetric(horizontal: 16),
            height: 1,
            width: double.infinity,
            color: Colors.grey.shade300,
          ),
          _paymentMethod(
            context,
            "assets/covers/thecao.png",
            "Thanh toán qua Thẻ cào",
          ),
          Container(
            margin: EdgeInsets.symmetric(horizontal: 16),
            height: 1,
            width: double.infinity,
            color: Colors.grey.shade300,
          ),
          _paymentMethod(
            context,
            "assets/covers/thetindung.png",
            "Thanh toán qua chuyển khoản",
          ),
        ],
      ),
    );
  }

  Widget _paymentMethod(BuildContext context, String pathImage, String method) {
    return InkWell(
      onTap: () {
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) => FinalPaymentScreen(
              selectedManga: selectedManga,
              imagePath: pathImage,
              title: method,
            ),
          ),
        );
      },
      child: Container(
        padding: EdgeInsets.symmetric(vertical: 10),
        margin: EdgeInsets.symmetric(horizontal: 16),
        height: 80,
        child: Row(
          children: [
            Image.asset(pathImage),
            SizedBox(width: 8),
            Expanded(
              child: Text(
                method,
                style: TextStyle(
                  color: Colors.black,
                  fontWeight: FontWeight.bold,
                  fontSize: 16,
                ),
              ),
            ),
            Icon(Icons.chevron_right, color: Colors.black),
          ],
        ),
      ),
    );
  }
}
