import 'package:flutter/material.dart';
import 'package:client/models/user_model.dart';
import 'package:client/models/book_model.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

import '../screens/book_screen.dart';

class BookList extends StatefulWidget {
  final User user;
  BookList({required this.user});

  @override
  _BookListState createState() => _BookListState();
}

class _BookListState extends State<BookList> {
  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Padding(
          padding: EdgeInsets.symmetric(horizontal: 0.0),
          child: Expanded(
            child: SizedBox(
              height: 430,
              child: ListView.builder(
                padding: EdgeInsets.only(top: 10.0, bottom: 15.0),
                itemCount: books_list.length,
                itemBuilder: (BuildContext context, int index) {
                  Book book = books_list[index];
                  return Stack(
                    children: <Widget>[
                      Container(
                        margin: EdgeInsets.fromLTRB(40.0, 0.0, 20.0, 0.0),
                        height: 180.0,
                        width: double.infinity,
                        decoration: BoxDecoration(
                          color: Theme.of(context).scaffoldBackgroundColor,
                          borderRadius: BorderRadius.circular(20.0),
                        ),
                        child: Padding(
                          padding: EdgeInsets.fromLTRB(88.0, 1.0, 4.0, 3.0),
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: <Widget>[
                              Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: <Widget>[
                                  Container(
                                    width: 180.0,
                                    height: 75.0,
                                    child: Text(
                                      book.title,
                                      style: TextStyle(
                                        color: Theme.of(context).primaryColor,
                                        fontSize: 18.0,
                                        fontWeight: FontWeight.w600,
                                      ),
                                      overflow: TextOverflow.ellipsis,
                                      maxLines: 2,
                                    ),
                                  ),
                                  Column(
                                    children: <Widget>[
                                      Icon(
                                        FontAwesomeIcons.bookmark,
                                        color: Theme.of(context)
                                            .secondaryHeaderColor,
                                        size: 18.0,
                                      ),
                                    ],
                                  ),
                                ],
                              ),
                              Text(
                                book.publisher,
                                style: TextStyle(
                                  color: Colors.grey,
                                  fontSize: 12.0,
                                ),
                              ),
                              SizedBox(height: 3.0),
                              Row(
                                children: <Widget>[
                                  Icon(
                                    FontAwesomeIcons.solidStar,
                                    color:
                                        Theme.of(context).secondaryHeaderColor,
                                    size: 15.0,
                                  ),
                                  SizedBox(width: 5.0),
                                  Padding(
                                    padding: const EdgeInsets.only(top: 3.0),
                                    child: Text(
                                      book.ratingaverage.toString() + "   | ",
                                      style: TextStyle(
                                        color: Theme.of(context)
                                            .secondaryHeaderColor,
                                        fontSize: 15.0,
                                      ),
                                    ),
                                  ),
                                  SizedBox(width: 10.0),
                                  Icon(
                                    FontAwesomeIcons.readme,
                                    color:
                                        Theme.of(context).secondaryHeaderColor,
                                    size: 15.0,
                                  ),
                                  SizedBox(width: 5.0),
                                  Padding(
                                    padding: const EdgeInsets.only(top: 3.0),
                                    child: Text(
                                      book.ratingnumber.toString(),
                                      style: TextStyle(
                                        color: Theme.of(context)
                                            .secondaryHeaderColor,
                                        fontSize: 15.0,
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                              SizedBox(height: 5.0),
                              Row(
                                children: <Widget>[
                                  Container(
                                    padding: EdgeInsets.all(5.0),
                                    width: 95.0,
                                    decoration: BoxDecoration(
                                      color: Color.fromARGB(255, 15, 5, 158),
                                      borderRadius: BorderRadius.circular(5.0),
                                    ),
                                    alignment: Alignment.center,
                                    child: Text(
                                      book.categories[0],
                                      style: TextStyle(
                                        color: Color.fromARGB(255, 8, 23, 228),
                                        fontSize: 12.0,
                                      ),
                                    ),
                                  ),
                                  SizedBox(width: 10.0),
                                  Container(
                                    padding: EdgeInsets.all(5.0),
                                    width: 95.0,
                                    decoration: BoxDecoration(
                                      color: Color.fromARGB(255, 158, 5, 5),
                                      borderRadius: BorderRadius.circular(5.0),
                                    ),
                                    alignment: Alignment.center,
                                    child: Text(
                                      book.categories[1],
                                      style: TextStyle(
                                        color: Color.fromARGB(255, 228, 8, 8),
                                        fontSize: 12.0,
                                      ),
                                    ),
                                  ),
                                ],
                              )
                            ],
                          ),
                        ),
                      ),
                      Positioned(
                        left: 20.0,
                        top: 15.0,
                        bottom: 15.0,
                        child: ClipRRect(
                          borderRadius: BorderRadius.circular(7.0),
                          child: Image(
                            width: 100.0,
                            image: AssetImage(
                              book.thumbnail,
                            ),
                            fit: BoxFit.cover,
                          ),
                        ),
                      ),
                    ],
                  );
                },
              ),
            ),
          ),
        ),
      ],
    );
  }
}