import 'package:flutter/material.dart';

import 'util/style.dart';

class MovieDetailPage extends StatelessWidget {
  const MovieDetailPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      body: ListView(
        children: [
          Container(
            height: 300,
            color: Colors.yellow,
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: [
              Text(
                "18+",
                style: style,
              ),
              Text(
                "18+",
                style: style,
              ),
              Row(
                children: [
                  Icon(
                    Icons.star,
                    color: Colors.yellow,
                    size: 14,
                  ),
                  Text(
                    "5.0",
                    style: style,
                  )
                ],
              )
            ],
          )
        ],
      ),
    );
  }
}
