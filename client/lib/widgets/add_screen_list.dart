import 'package:client/fragments/latest_fragment.dart';
import 'package:client/fragments/magazines_fragment.dart';
import 'package:client/fragments/types_fragment.dart';
import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:client/models/user_model.dart';
import 'package:client/models/book_model.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../models/list_model.dart';
import '../providers/lists_provider.dart';
import '../screens/book_screen.dart';

class AddSearchList extends StatefulWidget {
  final String search;
  final int index;
  UserList list;
  AddSearchList(
      {required this.search, required this.index, required this.list});

  @override
  _AddSearchListState createState() => _AddSearchListState();
}

class _AddSearchListState extends State<AddSearchList> {
  List<Book> list = [];
  var response;
  Future<List<Book>> getBooks() async {
    list = [];
    if (widget.index == 0) {
      response =
          await Dio().get('http://10.0.2.2:5050/api/books/' + widget.search);
    } else if (widget.index == 1) {
      response = await Dio()
          .get('http://10.0.2.2:5050/api/books/title/' + widget.search);
    } else if (widget.index == 2) {
      response = await Dio()
          .get('http://10.0.2.2:5050/api/books/publisher/' + widget.search);
    } else if (widget.index == 3) {
      response = await Dio()
          .get('http://10.0.2.2:5050/api/books/author/' + widget.search);
    }
    for (var item in response.data) {
      Book newBook = Book.fromJson(item);
      list.add(newBook);
    }
    ;
    return list;
  }

  @override
  Widget build(BuildContext context) {
    if (widget.search != "") {
      return FutureBuilder<List<Book>>(
          future: getBooks(),
          builder: (context, snapshot) {
            if (snapshot.connectionState == ConnectionState.done) {
              return Column(
                children: [
                  Padding(
                    padding: EdgeInsets.symmetric(horizontal: 0.0),
                    child: Expanded(
                      child: SizedBox(
                        height: 430,
                        child: ListView.builder(
                          padding: EdgeInsets.only(top: 10.0, bottom: 15.0),
                          itemCount: list.length,
                          itemBuilder: (BuildContext context, int index) {
                            Book book = snapshot.data!.elementAt(index);
                            return Stack(
                              children: <Widget>[
                                Container(
                                  margin:
                                      EdgeInsets.fromLTRB(40.0, 0.0, 20.0, 0.0),
                                  height: 180.0,
                                  width: double.infinity,
                                  decoration: BoxDecoration(
                                    color: Theme.of(context)
                                        .scaffoldBackgroundColor,
                                    borderRadius: BorderRadius.circular(20.0),
                                  ),
                                  child: Padding(
                                    padding: EdgeInsets.fromLTRB(
                                        88.0, 1.0, 4.0, 3.0),
                                    child: Column(
                                      mainAxisAlignment:
                                          MainAxisAlignment.center,
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: <Widget>[
                                        Row(
                                          mainAxisAlignment:
                                              MainAxisAlignment.spaceBetween,
                                          crossAxisAlignment:
                                              CrossAxisAlignment.start,
                                          children: <Widget>[
                                            Container(
                                              width: 180.0,
                                              height: 75.0,
                                              child: Text(
                                                book.title,
                                                style: TextStyle(
                                                  color: Theme.of(context)
                                                      .primaryColor,
                                                  fontSize: 18.0,
                                                  fontWeight: FontWeight.w600,
                                                ),
                                                overflow: TextOverflow.ellipsis,
                                                maxLines: 2,
                                              ),
                                            ),
                                            GestureDetector(
                                              onTap: () async {
                                                List<UserList> userLists = [];
                                                var listResponse = await Dio().put(
                                                    'http://10.0.2.2:5050/api/lists/add/' +
                                                        widget.list.title,
                                                    data: {"isbn": book.isbn});
                                                final prefs =
                                                    await SharedPreferences
                                                        .getInstance();
                                                prefs.setInt('flag', 0);
                                                setState(() {});
                                                Navigator.pop(context);
                                              },
                                              child: Column(
                                                children: <Widget>[
                                                  Icon(
                                                    FontAwesomeIcons.plusCircle,
                                                    color: Theme.of(context)
                                                        .secondaryHeaderColor,
                                                    size: 18.0,
                                                  ),
                                                ],
                                              ),
                                            ),
                                          ],
                                        ),
                                        Text(
                                          book.publisher != "none"
                                              ? book.publisher
                                              : " ",
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
                                              color: Theme.of(context)
                                                  .secondaryHeaderColor,
                                              size: 15.0,
                                            ),
                                            SizedBox(width: 5.0),
                                            Padding(
                                              padding: const EdgeInsets.only(
                                                  top: 3.0),
                                              child: Text(
                                                book.ratingaverage != 0.001
                                                    ? book.ratingaverage
                                                            .toString() +
                                                        "   | "
                                                    : "??    | ",
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
                                              color: Theme.of(context)
                                                  .secondaryHeaderColor,
                                              size: 15.0,
                                            ),
                                            SizedBox(width: 5.0),
                                            Padding(
                                              padding: const EdgeInsets.only(
                                                  top: 3.0),
                                              child: Text(
                                                book.ratingnumber != 0
                                                    ? book.ratingnumber
                                                        .toString()
                                                    : "??",
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
                                        book.categories.length != 0
                                            ? Row(
                                                children: <Widget>[
                                                  book.categories.length >= 1
                                                      ? Container(
                                                          padding:
                                                              EdgeInsets.all(
                                                                  5.0),
                                                          width: 95.0,
                                                          decoration:
                                                              BoxDecoration(
                                                            color:
                                                                Color.fromARGB(
                                                                    255,
                                                                    15,
                                                                    5,
                                                                    158),
                                                            borderRadius:
                                                                BorderRadius
                                                                    .circular(
                                                                        5.0),
                                                          ),
                                                          alignment:
                                                              Alignment.center,
                                                          child: Text(
                                                            book.categories[
                                                                        0] !=
                                                                    "none"
                                                                ? book
                                                                    .categories[0]
                                                                : " ",
                                                            style: TextStyle(
                                                              color: Color
                                                                  .fromARGB(
                                                                      255,
                                                                      8,
                                                                      23,
                                                                      228),
                                                              fontSize: 12.0,
                                                            ),
                                                          ),
                                                        )
                                                      : Container(),
                                                  SizedBox(width: 10.0),
                                                  book.categories.length >= 2
                                                      ? Container(
                                                          padding:
                                                              EdgeInsets.all(
                                                                  5.0),
                                                          width: 95.0,
                                                          decoration:
                                                              BoxDecoration(
                                                            color:
                                                                Color.fromARGB(
                                                                    255,
                                                                    158,
                                                                    5,
                                                                    5),
                                                            borderRadius:
                                                                BorderRadius
                                                                    .circular(
                                                                        5.0),
                                                          ),
                                                          alignment:
                                                              Alignment.center,
                                                          child: Text(
                                                            book.categories[
                                                                        1] ==
                                                                    "none"
                                                                ? book
                                                                    .categories[1]
                                                                : " ",
                                                            style: TextStyle(
                                                              color: Color
                                                                  .fromARGB(
                                                                      255,
                                                                      228,
                                                                      8,
                                                                      8),
                                                              fontSize: 12.0,
                                                            ),
                                                          ),
                                                        )
                                                      : Container(),
                                                ],
                                              )
                                            : Row()
                                      ],
                                    ),
                                  ),
                                ),
                                Positioned(
                                  left: 20.0,
                                  top: 15.0,
                                  bottom: 15.0,
                                  child: GestureDetector(
                                    onTap: () => Navigator.push(
                                      context,
                                      MaterialPageRoute(
                                        builder: (_) => BookScreen(
                                          book: book,
                                        ),
                                      ),
                                    ),
                                    child: ClipRRect(
                                      borderRadius: BorderRadius.circular(7.0),
                                      child: book.thumbnail == 'none'
                                          ? Image.asset(
                                              'assets/images/notfound.jpg',
                                              width: 100.0,
                                              fit: BoxFit.fill,
                                            )
                                          : Image.network(
                                              "${book.thumbnail}",
                                              width: 100,
                                              fit: BoxFit.fill,
                                            ),
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
            } else {
              return Container();
            }
          });
    } else {
      return Container();
    }
  }
}
