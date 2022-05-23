import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../models/list_model.dart';
import '../models/user_model.dart';
import '../providers/lists_provider.dart';

class ListsCarousel extends StatefulWidget {
  final User user;
  ListsCarousel({required this.user});

  @override
  _ListsCarouselState createState() => _ListsCarouselState();
}

class _ListsCarouselState extends State<ListsCarousel> {
  @override
  Widget build(BuildContext context) {
    List<UserList> lists = Provider.of<ListProvider>(context).lists;
    return Column(
      children: <Widget>[
        Padding(
          padding: EdgeInsets.symmetric(horizontal: 20.0),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: <Widget>[
              Text(
                'Lists',
                style: TextStyle(
                  fontSize: 22.0,
                  fontWeight: FontWeight.bold,
                  letterSpacing: 1.5,
                  color: Theme.of(context).primaryColor,
                ),
              ),
            ],
          ),
        ),
        Container(
          height: 300.0,
          child: ListView.builder(
            scrollDirection: Axis.horizontal,
            itemCount: lists.length,
            itemBuilder: (BuildContext context, int index) {
              UserList list = lists[index];
              return Container(
                margin: EdgeInsets.all(10.0),
                width: 130.0,
                child: Stack(
                  alignment: Alignment.topCenter,
                  children: <Widget>[
                    Positioned(
                      bottom: 15.0,
                      child: Container(
                        height: 120.0,
                        width: 130.0,
                        decoration: BoxDecoration(
                          color: Theme.of(context).secondaryHeaderColor,
                          borderRadius: BorderRadius.circular(10.0),
                        ),
                        child: Padding(
                          padding: EdgeInsets.all(10.0),
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.end,
                            children: <Widget>[
                              Text(
                                list.title,
                                style: TextStyle(
                                  fontSize: 16.0,
                                  fontWeight: FontWeight.w600,
                                  letterSpacing: 1.2,
                                  color: Theme.of(context).primaryColor,
                                ),
                              ),
                              SizedBox(height: 2.0),
                              Text(
                                list.items.length.toString() + " Books",
                                style: TextStyle(
                                  color: Colors.grey,
                                ),
                              ),
                              SizedBox(height: 5.0),
                            ],
                          ),
                        ),
                      ),
                    ),
                    Container(
                      decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.circular(20.0),
                        boxShadow: [
                          BoxShadow(
                            color: Colors.black26,
                            offset: Offset(0.0, 2.0),
                            blurRadius: 6.0,
                          ),
                        ],
                      ),
                      child: ClipRRect(
                        borderRadius: BorderRadius.circular(20.0),
                        child: list.items.isEmpty
                            ? Image.asset(
                                'assets/images/notfound.jpg',
                                height: 180.0,
                                width: 220.0,
                                fit: BoxFit.fill,
                              )
                            : Image.network(
                                "${list.items[0].thumbnail}",
                                height: 180.0,
                                width: 220.0,
                                fit: BoxFit.fill,
                              ),
                      ),
                    )
                  ],
                ),
              );
            },
          ),
        ),
      ],
    );
  }
}
