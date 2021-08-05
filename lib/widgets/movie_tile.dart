import 'dart:io';
import 'package:flutter/material.dart';

class MovieTile extends StatelessWidget {
  final String movieName;
  final String director;
  final String imagePath;
  final LinearGradient gradient;
  final Widget otherChild;

  const MovieTile(
      {Key key,
      @required this.gradient,
      @required this.movieName,
      @required this.director,
      @required this.imagePath,
      @required this.otherChild})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 180.0,
      width: double.infinity,
      padding: EdgeInsets.all(12.0),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(12.0),
        gradient: gradient,
      ),
      child: Row(
        children: [
          Container(
            height: double.infinity,
            width: 120.0,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(8.0),
              color: Colors.white,
              boxShadow: [
                imagePath != null && imagePath != ''
                    ? BoxShadow(
                        color: Colors.black38,
                        offset: Offset(0.0, 3.0),
                      )
                    : BoxShadow(
                        color: Colors.transparent,
                        offset: Offset(0.0, 0.0),
                      ),
              ],
            ),
            child: imagePath != null && imagePath != ''
                ? ClipRRect(
                    borderRadius: BorderRadius.circular(8.0),
                    child: Image.file(
                      File(imagePath),
                      fit: BoxFit.cover,
                    ),
                  )
                : Icon(
                    Icons.image,
                    size: 40.0,
                  ),
          ),
          const SizedBox(width: 12.0),
          Expanded(
            child: Container(
              padding: EdgeInsets.only(top: 2.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          movieName.isNotEmpty ? movieName : 'Movie Name',
                          style: const TextStyle(
                            color: Colors.white,
                            fontWeight: FontWeight.w600,
                            fontSize: 18.0,
                          ),
                          maxLines: 3,
                        ),
                        const SizedBox(height: 3.0),
                        RichText(
                          text: TextSpan(
                            children: [
                              TextSpan(
                                text: 'directed by ',
                                style: TextStyle(
                                  color: Colors.white,
                                  fontStyle: FontStyle.italic,
                                ),
                              ),
                              TextSpan(
                                text:
                                    director.isNotEmpty ? director : 'Director',
                                style: const TextStyle(
                                  color: Colors.white,
                                  fontWeight: FontWeight.w500,
                                  fontSize: 15.0,
                                ),
                              ),
                            ],
                          ),
                          maxLines: 3,
                        ),
                      ],
                    ),
                  ),
                  otherChild,
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
