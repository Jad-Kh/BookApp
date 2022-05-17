import 'package:flutter/material.dart';
import 'package:client/models/book_model.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'modify_lists_screen.dart';

class BookScreen extends StatefulWidget {
  final Book book;
  BookScreen({required this.book});

  @override
  _BookScreenState createState() => _BookScreenState();
}

class _BookScreenState extends State<BookScreen> {
  double _containerHeight = 535;
  double _textHeight = 80;
  double _paddingBelow = 125;
  double _paddingInfo = 375;
  double _infoSize = 145;
  double _fontSize = 13;
  bool _large = true;

  _updateState() {
    setState(() {
      if (_large) {
        _containerHeight = 350;
        _paddingBelow = 310;
        _fontSize = 18;
        _textHeight = 200;
        _paddingInfo = 150;
        _infoSize = 95;
      } else {
        _containerHeight = 535;
        _paddingBelow = 125;
        _fontSize = 13;
        _textHeight = 80;
        _paddingInfo = 375;
        _infoSize = 145;
      }
      _large = !_large;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        children: <Widget>[
          Stack(
            children: <Widget>[
              AnimatedContainer(
                duration: Duration(milliseconds: 0),
                width: MediaQuery.of(context).size.width,
                height: _containerHeight,
                color: Colors.white,
                child: Hero(
                  tag: widget.book.isbn,
                  child: ClipRRect(
                    child: Opacity(
                      opacity: 0.5,
                      child: widget.book.thumbnail.isEmpty
                          ? Placeholder()
                          : Image.network(
                              "${widget.book.thumbnail}",
                              width: 100,
                              fit: BoxFit.fill,
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
                        _large
                            ? Container(
                                decoration: BoxDecoration(
                                  color: Color.fromARGB(175, 130, 130, 130),
                                  borderRadius: BorderRadius.circular(15.0),
                                ),
                                child: IconButton(
                                    icon: Icon(FontAwesomeIcons.sortAmountUp),
                                    iconSize: 25.0,
                                    color: Theme.of(context).primaryColor,
                                    onPressed: () => _updateState()),
                              )
                            : Container(
                                decoration: BoxDecoration(
                                  color: Color.fromARGB(175, 130, 130, 130),
                                  borderRadius: BorderRadius.circular(15.0),
                                ),
                                child: IconButton(
                                    icon: Icon(FontAwesomeIcons.sortAmountDown),
                                    iconSize: 25.0,
                                    color: Theme.of(context).primaryColor,
                                    onPressed: () => _updateState()),
                              ),
                      ],
                    ),
                  ],
                ),
              ),
              Padding(
                padding: const EdgeInsets.all(100.0),
                child: Visibility(
                  visible: _large,
                  maintainState: true,
                  maintainAnimation: true,
                  maintainSize: false,
                  child: Container(
                    width: MediaQuery.of(context).size.width / 2,
                    height: 250,
                    child: Hero(
                      tag: widget.book.thumbnail,
                      child: ClipRRect(
                        child: widget.book.thumbnail.isEmpty
                            ? Placeholder()
                            : Image.network(
                                "${widget.book.thumbnail}",
                                width: 100,
                                fit: BoxFit.fill,
                              ),
                      ),
                    ),
                  ),
                ),
              ),
              Row(
                children: <Widget>[
                  Padding(
                    padding: EdgeInsets.only(left: 20.0, top: _paddingInfo),
                    child: Container(
                      height: _infoSize,
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
                                  widget.book.publisher == "none"
                                    ? " "
                                    : widget.book.publisher,
                                  style: TextStyle(
                                    fontSize: 13.0,
                                    color: Theme.of(context).primaryColor,
                                  ),
                                ),
                              ],
                            ),
                            Visibility(
                              visible: _large,
                              child: Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
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
                                            color:
                                                Theme.of(context).primaryColor,
                                          ),
                                        ),
                                        Padding(
                                          padding:
                                              const EdgeInsets.only(top: 10.0),
                                          child: Text(
                                            widget.book.ratingaverage == 0.001
                                              ? "??"
                                              : widget.book.ratingaverage
                                                .toString(),
                                            style: TextStyle(
                                              fontSize: 17.0,
                                              color: Theme.of(context)
                                                  .primaryColor,
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
                                            color:
                                                Theme.of(context).primaryColor,
                                          ),
                                        ),
                                        Padding(
                                          padding:
                                              const EdgeInsets.only(top: 10.0),
                                          child: Text(
                                            widget.book.date,
                                            style: TextStyle(
                                              fontSize: 17.0,
                                              color: Theme.of(context)
                                                  .primaryColor,
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
                                            color:
                                                Theme.of(context).primaryColor,
                                          ),
                                        ),
                                        Padding(
                                          padding:
                                              const EdgeInsets.only(top: 10.0),
                                          child: Text(
                                            widget.book.pages == 0 
                                              ? "??"
                                              : widget.book.pages
                                                .toString(),
                                            style: TextStyle(
                                              fontSize: 17.0,
                                              color: Theme.of(context)
                                                  .primaryColor,
                                            ),
                                          ),
                                        ),
                                      ],
                                    ),
                                  ),
                                ],
                              ),
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
                            Scrollbar(
                              child: SingleChildScrollView(
                                child: Container(
                                  height: _textHeight,
                                  width: 320.0,
                                  child: Padding(
                                    padding: const EdgeInsets.only(
                                        top: 10.0, left: 15.0),
                                    child: Text(
                                      widget.book.description,
                                      style: TextStyle(
                                        fontSize: _fontSize,
                                        color: Theme.of(context).primaryColor,
                                      ),
                                    ),
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
                padding: EdgeInsets.only(top: _paddingBelow, left: 15.0),
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
                    GestureDetector(
                      child: Container(
                        height: 50.0,
                        width: 255.0,
                        decoration: BoxDecoration(
                          color: Theme.of(context).accentColor,
                          borderRadius: BorderRadius.circular(5.0),
                        ),
                        child: Padding(
                          padding:
                              const EdgeInsets.only(top: 13.0, left: 105.0),
                          child: Text(
                            'Add',
                            style: TextStyle(
                              fontSize: 20.0,
                              color: Theme.of(context).primaryColor,
                            ),
                          ),
                        ),
                      ),
                      onTap: () => {
                        MaterialPageRoute(
                         builder: (context) => ModifyListScreen(action: "addbook", book: widget.book)
                         ),
                      },
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
