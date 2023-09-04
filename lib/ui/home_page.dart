import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:movies/ui/film_pages.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage>
    with SingleTickerProviderStateMixin {
  late PageController pageController;
  int currentPage = 0;

  @override
  void initState() {
    pageController = PageController(initialPage: currentPage);
    super.initState();
  }

  @override
  void dispose() {
    pageController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      body: ListView(
        physics: NeverScrollableScrollPhysics(),
        shrinkWrap: true,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              GestureDetector(
                onTap: () => pageController.jumpToPage(0),
                child: onTopText(
                    title: "Series",
                    color: currentPage == 0 ? Colors.red : Colors.white),
              ),
              GestureDetector(
                onTap: () => pageController.jumpToPage(1),
                child: onTopText(
                    title: "Filmes",
                    color: currentPage == 1 ? Colors.red : Colors.white),
              ),
            ],
          ),
          SizedBox(
            height: MediaQuery.of(context).size.height,
            child: PageView.builder(
              physics: const NeverScrollableScrollPhysics(),
              itemCount: 3,
              onPageChanged: (value) => setState(
                () {
                  currentPage = value;
                },
              ),
              controller: pageController,
              itemBuilder: (context, index) {
                return paginas[index];
              },
            ),
          )
        ],
      ),
    );
  }

  Widget onTopText({required String title, required Color color}) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 20),
      child: Text(
        title,
        style: TextStyle(
          fontSize: 17,
          color: color,
        ),
      ),
    );
  }
}

List paginas = [
  Container(
    color: Colors.white,
  ),
  FilmPage(),
  Container(
    color: Colors.green,
  )
];
