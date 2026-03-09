import 'package:flutter/material.dart';
import 'package:movie_app/core/colors/VColors.dart';

class TitleMovieItem extends StatelessWidget {
  final String _movieName;

  const TitleMovieItem(this._movieName, {super.key});

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        Container(color: Colors.black),
        Positioned(
          left: 20,
          bottom: 20,
          child: Container(
            padding: EdgeInsets.all(10),
            decoration: BoxDecoration(
              color: Colors.grey.withAlpha(50),
              borderRadius: BorderRadiusGeometry.all(Radius.circular(20)),
            ),
            child: Row(
              children: [
                Icon(Icons.play_circle, color: VColors.colorIcon),
                SizedBox(width: 20),
                Column(
                  children: [
                    Text(
                      "Continue Watching",
                      style: TextStyle(color: Colors.white),
                    ),
                    SizedBox(height: 10),
                    Text(
                      _movieName,
                      style: TextStyle(
                        fontWeight: FontWeight.bold,
                        color: Colors.white,
                      ),
                    ),
                  ],
                ),
                SizedBox(width: 10),
              ],
            ),
          ),
        ),
      ],
    );
  }
}
