import 'package:flutter/material.dart';
import 'package:movie_app/core/colors/VColors.dart';
import 'package:movie_app/utils/constants.dart';

class MovieDetailsScreen extends StatefulWidget {
  final String _movieSlug;

  const MovieDetailsScreen({super.key, required String movieSlug})
    : _movieSlug = movieSlug;

  @override
  State<MovieDetailsScreen> createState() => _MovieDetailsScreenState();
}

class _MovieDetailsScreenState extends State<MovieDetailsScreen> {
  late double _screenHeight;
  late double _screenWidth;

  @override
  void initState() {
    super.initState();
  }

  @override
  void dispose() {
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    _screenHeight = Constants.getHeightScreen(context);
    _screenWidth = Constants.getWidthScreen(context);
    final heightImage = 0.4 * _screenHeight;
    final marginContent = 0.35 * _screenHeight;
    final secondaryTitle = Constants.calculateFontSize(context, 1.1);
    return Scaffold(
      body: Stack(
        children: [
          Image.asset("assets/images/try.png", height: heightImage),
          Container(
            decoration: BoxDecoration(
              color: VColors.blackBackground,
              borderRadius: BorderRadiusGeometry.only(
                topLeft: Radius.circular(40),
                topRight: Radius.circular(40),
              ),
            ),
            margin: EdgeInsets.only(top: marginContent),
            width: double.infinity,
            padding: const EdgeInsets.all(20),
            child: Column(
              mainAxisSize: MainAxisSize.max,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  children: [
                    Text(
                      "Movie Name",
                      style: TextStyle(
                        color: Colors.white,
                        fontWeight: FontWeight.bold,
                        fontSize: Constants.calculateFontSize(context, 1.4),
                      ),
                    ),
                    SizedBox(width: 10),
                    Container(
                      decoration: BoxDecoration(
                        borderRadius: const BorderRadiusGeometry.all(
                          Radius.circular(10),
                        ),
                        color: VColors.greySearch,
                      ),
                      padding: const EdgeInsets.all(6),
                      child: Text("HD", style: TextStyle(color: Colors.white)),
                    ),
                  ],
                ),
                const SizedBox(height: 10),
                Row(
                  children: [
                    const Icon(Icons.timer, color: VColors.colorIcon),
                    const SizedBox(width: 5),
                    Text("Time", style: TextStyle(color: Colors.white)),
                    const SizedBox(width: 20),
                    const Icon(Icons.star, color: VColors.colorIcon),
                    Text("9.0", style: TextStyle(color: Colors.white)),
                  ],
                ),
                const SizedBox(height: 10),
                Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          "Release date",
                          style: TextStyle(
                            color: Colors.white,
                            fontSize: secondaryTitle,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        const SizedBox(height: 5),
                        Text(
                          "10-10-1010",
                          style: TextStyle(color: Colors.white),
                        ),
                      ],
                    ),
                    const SizedBox(width: 20),
                    Expanded(
                      child: Column(
                        mainAxisSize: MainAxisSize.min,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            "Genre",
                            style: TextStyle(
                              color: Colors.white,
                              fontWeight: FontWeight.bold,
                              fontSize: secondaryTitle,
                            ),
                          ),
                          const SizedBox(height: 5),
                          Wrap(
                            spacing: 5,
                            runSpacing: 5,
                            children: [
                              Container(
                                padding: const EdgeInsets.all(8),
                                decoration: BoxDecoration(
                                  borderRadius: const BorderRadiusGeometry.all(
                                    Radius.circular(20),
                                  ),
                                  border: BoxBorder.all(
                                    width: 1,
                                    color: Colors.white,
                                  ),
                                  color: VColors.greySearch,
                                ),
                                child: Text(
                                  "Actioádasdn",
                                  style: TextStyle(color: Colors.white),
                                ),
                              ),
                              Container(
                                padding: const EdgeInsets.all(8),
                                decoration: BoxDecoration(
                                  borderRadius: const BorderRadiusGeometry.all(
                                    Radius.circular(20),
                                  ),
                                  border: BoxBorder.all(
                                    width: 1,
                                    color: Colors.white,
                                  ),
                                  color: VColors.greySearch,
                                ),
                                child: Text(
                                  "Actiádon",
                                  style: TextStyle(color: Colors.white),
                                ),
                              ),
                              Container(
                                padding: const EdgeInsets.all(8),
                                decoration: BoxDecoration(
                                  borderRadius: const BorderRadiusGeometry.all(
                                    Radius.circular(20),
                                  ),
                                  border: BoxBorder.all(
                                    width: 1,
                                    color: Colors.white,
                                  ),
                                  color: VColors.greySearch,
                                ),
                                child: Text(
                                  "âsd",
                                  style: TextStyle(color: Colors.white),
                                ),
                              ),
                              Container(
                                padding: const EdgeInsets.all(8),
                                decoration: BoxDecoration(
                                  borderRadius: const BorderRadiusGeometry.all(
                                    Radius.circular(20),
                                  ),
                                  border: BoxBorder.all(
                                    width: 1,
                                    color: Colors.white,
                                  ),
                                  color: VColors.greySearch,
                                ),
                                child: Text(
                                  "ádasd",
                                  style: TextStyle(color: Colors.white),
                                ),
                              ),
                              Container(
                                padding: const EdgeInsets.all(8),
                                decoration: BoxDecoration(
                                  borderRadius: const BorderRadiusGeometry.all(
                                    Radius.circular(20),
                                  ),
                                  border: BoxBorder.all(
                                    width: 1,
                                    color: Colors.white,
                                  ),
                                  color: VColors.greySearch,
                                ),
                                child: Text(
                                  "Action",
                                  style: TextStyle(color: Colors.white),
                                ),
                              ),
                              Container(
                                padding: const EdgeInsets.all(8),
                                decoration: BoxDecoration(
                                  borderRadius: const BorderRadiusGeometry.all(
                                    Radius.circular(20),
                                  ),
                                  border: BoxBorder.all(
                                    width: 1,
                                    color: Colors.white,
                                  ),
                                  color: VColors.greySearch,
                                ),
                                child: Text(
                                  "Action",
                                  style: TextStyle(color: Colors.white),
                                ),
                              ),
                              Container(
                                padding: const EdgeInsets.all(8),
                                decoration: BoxDecoration(
                                  borderRadius: const BorderRadiusGeometry.all(
                                    Radius.circular(20),
                                  ),
                                  border: BoxBorder.all(
                                    width: 1,
                                    color: Colors.white,
                                  ),
                                  color: VColors.greySearch,
                                ),
                                child: Text(
                                  "Action",
                                  style: TextStyle(color: Colors.white),
                                ),
                              ),
                              Container(
                                padding: const EdgeInsets.all(8),
                                decoration: BoxDecoration(
                                  borderRadius: const BorderRadiusGeometry.all(
                                    Radius.circular(20),
                                  ),
                                  color: VColors.greySearch,
                                  border: BoxBorder.all(
                                    width: 1,
                                    color: Colors.white,
                                  ),
                                ),
                                child: Text(
                                  "Action",
                                  style: TextStyle(color: Colors.white),
                                ),
                              ),
                            ],
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 10),
                Text(
                  "Synopsis",
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: secondaryTitle,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                Text(
                  "alsjdlasjdlaksjdlasjdlasjdasjdasjdpaosjdpaosjdasjdpaosjdpaosjdpaosjdpasjdpaosjdaposjdaospjdapso",
                  style: TextStyle(color: Colors.white),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
