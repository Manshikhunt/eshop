import 'package:eshop/views/buyers/nav_screens/widgets/banner_widget.dart';
import 'package:eshop/views/buyers/nav_screens/widgets/category_text.dart';
import 'package:eshop/views/buyers/nav_screens/widgets/search_input_screen.dart';
import 'package:eshop/views/buyers/nav_screens/widgets/welcome_text_screen.dart';
import 'package:flutter/material.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return const Center(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          WelcomeText(),
          SizedBox(
            height: 14,
          ),
          SerachInput(),
          BannerWidget(),
          CategoryText(),
        ],
      ),
    );
  }
}