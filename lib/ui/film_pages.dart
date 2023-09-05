import 'package:flutter/material.dart';

import 'carousel.dart';

class FilmPage extends StatefulWidget {
  const FilmPage({super.key});

  @override
  State<FilmPage> createState() => _FilmPageState();
}

class _FilmPageState extends State<FilmPage> {
  int currenIndexOfTypeOfMovie = 0;
  TextStyle style = TextStyle(color: Colors.white, fontSize: 16);
  @override
  Widget build(BuildContext context) {
    return ListView(
      shrinkWrap: true,
      children: [
        _customText("Coming Soon"),
        Carossel(
          aspectRatio: 2.1,
          viewportFraction: 0.8,
          container: ClipRRect(
            borderRadius: BorderRadius.circular(25),
            child: Container(
              color: Colors.yellow,
            ),
          ),
        ),
        SizedBox(
          height: 30,
          child: ListView.separated(
            separatorBuilder: (context, index) => const SizedBox(
              width: 15,
            ),
            scrollDirection: Axis.horizontal,
            shrinkWrap: true,
            itemCount: typeOfMovie.length,
            itemBuilder: (context, index) {
              return ElevatedButton(
                style: ElevatedButton.styleFrom(
                  backgroundColor: currenIndexOfTypeOfMovie == index
                      ? Colors.red
                      : const Color(0xFF1a1b23),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(10),
                  ),
                ),
                onPressed: () {
                  setState(() {
                    currenIndexOfTypeOfMovie = index;
                  });
                },
                child: Text(
                  typeOfMovie[index],
                ),
              );
            },
          ),
        ),
        const SizedBox(
          height: 25,
        ),
        _customText("Trending Now"),
        Container(
          height: 290,
          child: Carossel(
            aspectRatio: 1.0,
            viewportFraction: 0.5,
            container: Container(
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  ClipRRect(
                    borderRadius: BorderRadius.circular(20),
                    child: Container(
                      color: Colors.red,
                      height: MediaQuery.of(context).size.height * 0.27,
                      width: 160,
                    ),
                  ),
                  SizedBox(
                    height: 2,
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceAround,
                    children: [
                      Text(
                        "18+",
                        style: style,
                      ),
                      Text(
                        "action",
                        style: style,
                      ),
                      Row(
                        children: [
                          Icon(
                            Icons.star,
                            color: Colors.yellow,
                            size: 15,
                          ),
                          Text(
                            "5.0",
                            style: style,
                          )
                        ],
                      )
                    ],
                  ),
                  SizedBox(
                    height: 5,
                  ),
                  Center(
                    child: Text(
                      "mil formas de morrer",
                      style: TextStyle(
                          color: Colors.white,
                          fontSize: 17,
                          fontWeight: FontWeight.bold,
                          overflow: TextOverflow.fade),
                    ),
                  )
                ],
              ),
            ),
          ),
        ),
        _customText("Trending person of the week"),
        Container(
          height: 50,
          child: ListView.separated(
              separatorBuilder: (context, index) => SizedBox(
                    width: 10,
                  ),
              shrinkWrap: true,
              scrollDirection: Axis.horizontal,
              itemCount: 10,
              itemBuilder: (context, index) {
                return CircleAvatar(
                  radius: 50,
                );
              }),
        )
      ],
    );
  }

  Widget _customText(String title) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 18, vertical: 6),
      child: Text(
        title,
        style: const TextStyle(
            color: Colors.white, fontSize: 22, fontWeight: FontWeight.bold),
      ),
    );
  }
}

List<String> typeOfMovie = [
  "all",
  "action",
  "comedia",
  "Romance",
  "terror",
];
