import 'package:flutter/material.dart';
import 'package:client/models/book_model.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

import '../screens/book_screen.dart';

class DestinationCarousel extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Column(
      children: <Widget>[
        Padding(
          padding: EdgeInsets.symmetric(horizontal: 20.0),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: <Widget>[
              Text(
                'Explore',
                style: TextStyle(
                  color: Theme.of(context).primaryColor,
                  fontSize: 22.0,
                  fontWeight: FontWeight.bold,
                  letterSpacing: 1.5,
                ),
              ),
              GestureDetector(
                onTap: () => print('See More'),
                child: Text(
                  'See More',
                  style: TextStyle(
                    color: Theme.of(context).secondaryHeaderColor,
                    fontSize: 16.0,
                    fontWeight: FontWeight.w600,
                    letterSpacing: 1.0,
                  ),
                ),
              ),
            ],
          ),
        ),
        Container(
          height: 325.0,
          child: ListView.builder(
            scrollDirection: Axis.horizontal,
            itemCount: books_carousel.length,
            itemBuilder: (BuildContext context, int index) {
              Book book = books_carousel[index];
              return GestureDetector(
                onTap: () => Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (_) => BookScreen(
                      book: book,
                    ),
                  ),
                ),
                child: Container(
                  margin: EdgeInsets.only(top: 15.0, left: 15.0, bottom: 15.0),
                  width: 150.0,
                  child: Stack(
                    alignment: Alignment.topCenter,
                    children: <Widget>[
                      Positioned(
                        bottom: 10.0,
                        child: Container(
                          height: 50.0,
                          width: 200.0,
                          decoration: BoxDecoration(
                            color: Theme.of(context).scaffoldBackgroundColor,
                            borderRadius: BorderRadius.circular(10.0),
                          ),
                          child: Padding(
                            padding: EdgeInsets.only(top: 28.0, right: 40.0),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.end,
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: <Widget>[
                                Stack(
                                  children: [
                                    Padding(
                                      padding: const EdgeInsets.only(top: 1.0, left: 25.0),
                                      child: Icon(
                                        FontAwesomeIcons.clock,
                                        color: Theme.of(context).secondaryHeaderColor,
                                        size: 12.0,
                                      ),
                                    ),
                                    Padding(
                                      padding: const EdgeInsets.only(top: 1.0, left: 115.0),
                                      child: Icon(FontAwesomeIcons.book,
                                        color: Theme.of(context).secondaryHeaderColor,
                                        size: 12.0,
                                      ),
                                    ),
                                    Padding(
                                      padding: const EdgeInsets.only(left: 40.0),
                                      child: Text(
                                        book.date + " |",
                                        style: TextStyle(
                                          color: Theme.of(context).secondaryHeaderColor,
                                          fontSize: 13.0,
                                        ),
                                      ),
                                    ),
                                    Padding(
                                      padding: const EdgeInsets.only(left: 130.0),
                                      child: Text(
                                        book.pages.toString(),
                                        style: TextStyle(
                                          color: Theme.of(context).secondaryHeaderColor,
                                          fontSize: 13.0,
                                        ),
                                      ),
                                    ),
                                  ], 
                                ),
                              ],
                            ),
                          ),
                        ),
                      ),
                      Container(
                        decoration: BoxDecoration(
                          color: Theme.of(context).primaryColor,
                          borderRadius: BorderRadius.circular(20.0),
                          boxShadow: [
                            BoxShadow(
                              color: Colors.black26,
                              offset: Offset(0.0, 2.0),
                              blurRadius: 6.0,
                            ),
                          ],
                        ),
                        child: Stack(
                          children: <Widget>[
                            Hero(
                              tag: book.thumbnail,
                              child: ClipRRect(
                                borderRadius: BorderRadius.circular(10.0),
                                child: Image(
                                  height: 250.0,
                                  width: 200.0,
                                  image: AssetImage(book.thumbnail),
                                  fit: BoxFit.cover,
                                ),
                              ),
                            ),
                          ],
                        ),
                      )
                    ],
                  ),
                ),
              );
            },
          ),
        ),
      ],
    );
  }
}