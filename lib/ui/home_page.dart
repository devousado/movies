import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import 'package:movies/ui/film_pages.dart';

import '../service/api_service.dart';

class HomePage extends ConsumerStatefulWidget {
  const HomePage({super.key});

  @override
  ConsumerState<HomePage> createState() => _HomePageState();
}

class _HomePageState extends ConsumerState<HomePage>
    with SingleTickerProviderStateMixin {
  late PageController pageController;
  int currentPage = 0;

  @override
  void initState() {
    pageController = PageController(initialPage: currentPage);
    super.initState();
    getactorInTrending();
  }

  @override
  void dispose() {
    pageController.dispose();
    super.dispose();
  }

  List<String> typeOfMovie = [
    "all",
    "action",
    "comedia"
        "Romance",
    "terror",
  ];
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      appBar: AppBar(
        elevation: 0,
        backgroundColor: Colors.black,
        title: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            GestureDetector(
              onTap: () {},
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
      ),
      body: SizedBox(
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

List<Widget> paginas = [
  Container(
    color: Colors.white,
  ),
  FilmPage(),
  Container(
    color: Colors.green,
  )
];
