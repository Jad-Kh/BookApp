import 'package:flutter/material.dart';
import 'package:client/models/book_model.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

class BookScreen extends StatefulWidget {
  final Book book;
  BookScreen({required this.book});

  @override
  _BookScreenState createState() => _BookScreenState();
}

class _BookScreenState extends State<BookScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        children: <Widget>[
          Stack(
            children: <Widget>[
              Container(
                width: MediaQuery.of(context).size.width,
                height: 535,
                color: Colors.white,
                child: Hero(
                  tag: widget.book.id,
                  child: ClipRRect(
                    child: Opacity(
                      opacity: 0.5,
                      child: Image(
                        image: AssetImage(widget.book.thumbnail),
                        colorBlendMode: BlendMode.modulate,
                        fit: BoxFit.cover,
                      ),
                    ),
                  ),
                ),
              ),
              Padding(
                padding: EdgeInsets.symmetric(horizontal: 10.0, vertical: 50.0),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: <Widget>[
                    Container(
                      decoration: BoxDecoration(
                        color: Color.fromARGB(175, 130, 130, 130),
                        borderRadius: BorderRadius.circular(15.0),
                      ),
                      child: IconButton(
                        icon: Icon(Icons.arrow_back),
                        iconSize: 30.0,
                        color: Theme.of(context).primaryColor,
                        onPressed: () => Navigator.pop(context),
                      ),
                    ),
                    Row(
                      children: <Widget>[
                        Container(
                          decoration: BoxDecoration(
                            color: Color.fromARGB(175, 130, 130, 130),
                            borderRadius: BorderRadius.circular(15.0),
                          ),
                          child: IconButton(
                            icon: Icon(FontAwesomeIcons.sortAmountDown),
                            iconSize: 25.0,
                            color: Theme.of(context).primaryColor,
                            onPressed: () => Navigator.pop(context),
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
              Padding(
                padding: const EdgeInsets.all(100.0),
                child: Container(
                  width: MediaQuery.of(context).size.width / 2,
                  height: 250,
                  child: Hero(
                    tag: widget.book.thumbnail,
                    child: ClipRRect(
                      child: Image(
                        image: AssetImage(widget.book.thumbnail),
                        colorBlendMode: BlendMode.modulate,
                        fit: BoxFit.cover,
                      ),
                    ),
                  ),
                ),
              ),
              Row(
                children: <Widget>[
                  Padding(
                    padding: const EdgeInsets.only(left: 20.0, top: 375),
                    child: Container(
                      height: 145.0,
                      width: 320.0,
                      decoration: BoxDecoration(
                        color: Color.fromARGB(175, 130, 130, 130),
                        borderRadius: BorderRadius.circular(15.0),
                      ),
                      child: Padding(
                        padding: const EdgeInsets.all(12.0),
                        child: Column(
                          children: [
                            Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Text(
                                  widget.book.title,
                                  style: TextStyle(
                                    fontSize: 24.0,
                                    color: Theme.of(context).primaryColor,
                                  ),
                                ),
                              ],
                            ),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Text(
                                  widget.book.publisher,
                                  style: TextStyle(
                                    fontSize: 13.0,
                                    color: Theme.of(context).primaryColor,
                                  ),
                                ),
                              ],
                            ),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: <Widget>[
                                Padding(
                                  padding: const EdgeInsets.only(top: 27.0),
                                  child: Column(
                                    children: <Widget>[
                                      Container(
                                        height: 20.0,
                                        width: 35.0,
                                        child: Icon(
                                          FontAwesomeIcons.solidStar,
                                          size: 20.0,
                                          color: Theme.of(context).primaryColor,
                                        ),
                                      ),
                                      Padding(
                                        padding:
                                            const EdgeInsets.only(top: 10.0),
                                        child: Text(
                                          widget.book.ratingaverage.toString(),
                                          style: TextStyle(
                                            fontSize: 17.0,
                                            color:
                                                Theme.of(context).primaryColor,
                                          ),
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                                Padding(
                                  padding: const EdgeInsets.only(top: 27.0),
                                  child: Column(
                                    children: <Widget>[
                                      Container(
                                        height: 20.0,
                                        width: 35.0,
                                        child: Icon(
                                          FontAwesomeIcons.solidCalendar,
                                          size: 20.0,
                                          color: Theme.of(context).primaryColor,
                                        ),
                                      ),
                                      Padding(
                                        padding:
                                            const EdgeInsets.only(top: 10.0),
                                        child: Text(
                                          widget.book.date,
                                          style: TextStyle(
                                            fontSize: 17.0,
                                            color:
                                                Theme.of(context).primaryColor,
                                          ),
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                                Padding(
                                  padding: const EdgeInsets.only(top: 27.0),
                                  child: Column(
                                    children: <Widget>[
                                      Container(
                                        height: 20.0,
                                        width: 35.0,
                                        child: Icon(
                                          FontAwesomeIcons.bookOpen,
                                          size: 20.0,
                                          color: Theme.of(context).primaryColor,
                                        ),
                                      ),
                                      Padding(
                                        padding:
                                            const EdgeInsets.only(top: 10.0),
                                        child: Text(
                                          widget.book.pages.toString(),
                                          style: TextStyle(
                                            fontSize: 17.0,
                                            color:
                                                Theme.of(context).primaryColor,
                                          ),
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                              ],
                            ),
                          ],
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ],
          ),
          Stack(
            children: <Widget>[
              Padding(
                padding: const EdgeInsets.only(top: 15.0, left: 15.0),
                child: Column(
                  children: <Widget>[
                    Row(
                      children: [
                        Text(
                          "Description: ",
                          style: TextStyle(
                            fontSize: 18.0,
                            color: Theme.of(context).primaryColor,
                          ),
                        ),
                      ],
                    ),
                    Row(
                      children: [
                        Stack(
                          children: <Widget>[
                            Container(
                              height: 80.0,
                              width: 320.0,
                              child: Padding(
                                padding: const EdgeInsets.only(top: 10.0, left: 25.0),
                                child: Text(
                                  widget.book.description,
                                  style: TextStyle(
                                    fontSize: 13.0,
                                    color: Theme.of(context).primaryColor,
                                  ),
                                ),
                              ),
                            ),
                          ],
                        ),
                      ],
                    )
                  ],
                ),
              ),
              Padding(
                padding: const EdgeInsets.only(top: 125.0, left: 15.0),
                child: Row(
                  children: <Widget>[
                    Container(
                      height: 50.0,
                      width: 50.0,
                      decoration: BoxDecoration(
                        color: Theme.of(context).secondaryHeaderColor,
                        borderRadius: BorderRadius.circular(5.0),
                      ),
                      child: Icon(
                        Icons.bookmark_add_outlined,
                        size: 22.0,
                        color: Theme.of(context).primaryColor,
                      ),
                    ),
                    SizedBox(width: 20.0),
                    Container(
                      height: 50.0,
                      width: 255.0,
                      decoration: BoxDecoration(
                        color: Theme.of(context).accentColor,
                        borderRadius: BorderRadius.circular(5.0),
                      ),
                      child: Padding(
                        padding: const EdgeInsets.only(top: 13.0, left: 105.0),
                        child: Text(
                          'Add',
                          style: TextStyle(
                            fontSize: 20.0,
                            color: Theme.of(context).primaryColor,
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
