import 'package:client/models/store_model.dart';
import 'package:flutter/material.dart';
import 'package:dio/dio.dart';
import 'package:geolocator/geolocator.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

class StoreScreen extends StatefulWidget {
  const StoreScreen({Key? key}) : super(key: key);

  @override
  _StoreScreenState createState() => _StoreScreenState();
}

class _StoreScreenState extends State<StoreScreen> {
  late Position _currentPosition;
  late String _currentAddress;
  late CameraPosition _initialCameraPosition;
  final Geolocator geolocator = Geolocator();
  late GoogleMapController _googleMapController;
  var _origin;
  var _destination;
  var _info;
  var _polyline;

  @override
  void dispose() {
    _googleMapController.dispose();
    super.dispose();
  }

  Future<List<Store>> getStores() async {
    List<Store> list = [];
    var response = await Dio().get(
        'http://10.0.2.2:5050/api/map/33.886961122036865/35.50566136837005');
    for (var item in response.data) {
      Store store = Store.fromJson(item);
      list.add(store);
    }
    ;
    return list;
  }

  _getCurrentLocation() {
    Geolocator.getCurrentPosition(desiredAccuracy: LocationAccuracy.best)
        .then((Position position) {
      _currentPosition = position;
    }).catchError((e) {
      print(e);
    });
  }

  @override
  void initState() {
    _addMarker(LatLng(33.886961122036865, 35.50566136837005));
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    _initialCameraPosition = CameraPosition(
      target: LatLng(33.886961122036865, 35.50566136837005),
      zoom: 13.5,
    );
    return Scaffold(
      floatingActionButtonLocation: FloatingActionButtonLocation.miniEndTop,
      appBar: AppBar(
        centerTitle: false,
        automaticallyImplyLeading: false,
        backgroundColor: Theme.of(context).scaffoldBackgroundColor,
        title: Text(
          'Google Maps',
          style: TextStyle(color: Theme.of(context).primaryColor),
        ),
      ),
      body: Column(
        children: [
          Container(
            height: 350,
            child: GoogleMap(
              myLocationButtonEnabled: false,
              zoomControlsEnabled: false,
              initialCameraPosition: _initialCameraPosition,
              onMapCreated: (controller) => _googleMapController = controller,
              markers: {
                if (_origin != null) _origin,
                if (_destination != null) _destination,
              },
              polylines: {
                if (_info != null)
                  Polyline(
                    polylineId: const PolylineId('overview_polyline'),
                    color: Colors.red,
                    width: 5,
                    points: _info.polylinePoints
                        .map((e) => LatLng(e.latitude, e.longitude))
                        .toList(),
                  ),
                if (_polyline != null) _polyline,
              },
              onLongPress: _addMarker,
            ),
          ),
          Padding(
            padding: const EdgeInsets.only(top: 15.0, left: 15.0),
            child: Container(
              alignment: Alignment.topLeft,
              child: Text(
                "Five Closest Bookstores:",
                style: TextStyle(fontSize: 20.0),
              ),
            ),
          ),
          Padding(
            padding: const EdgeInsets.only(top: 10.0),
            child: FutureBuilder<List<Store>>(
                future: getStores(),
                builder: (context, snapshot) {
                  if (snapshot.connectionState == ConnectionState.done) {
                    return Column(
                      children: [
                        Padding(
                          padding: EdgeInsets.symmetric(horizontal: 0.0),
                          child: Expanded(
                            child: SizedBox(
                              height: 200,
                              child: ListView.builder(
                                padding:
                                    EdgeInsets.only(top: 10.0, bottom: 15.0),
                                itemCount: 5,
                                itemBuilder: (BuildContext context, int index) {
                                  Store store = snapshot.data!.elementAt(index);
                                  return Stack(
                                    children: <Widget>[
                                      Container(
                                        margin: EdgeInsets.fromLTRB(
                                            40.0, 0.0, 20.0, 0.0),
                                        height: 120.0,
                                        width: double.infinity,
                                        decoration: BoxDecoration(
                                          color: Theme.of(context)
                                              .scaffoldBackgroundColor,
                                          borderRadius:
                                              BorderRadius.circular(20.0),
                                        ),
                                        child: Padding(
                                          padding: EdgeInsets.fromLTRB(
                                              88.0, 0.0, 4.0, 3.0),
                                          child: Column(
                                            mainAxisAlignment:
                                                MainAxisAlignment.center,
                                            crossAxisAlignment:
                                                CrossAxisAlignment.start,
                                            children: <Widget>[
                                              Row(
                                                mainAxisAlignment:
                                                    MainAxisAlignment
                                                        .spaceBetween,
                                                crossAxisAlignment:
                                                    CrossAxisAlignment.start,
                                                children: <Widget>[
                                                  Container(
                                                    width: 180.0,
                                                    height: 55.0,
                                                    child: Text(
                                                      store.name,
                                                      style: TextStyle(
                                                        color: Theme.of(context)
                                                            .primaryColor,
                                                        fontSize: 18.0,
                                                        fontWeight:
                                                            FontWeight.w600,
                                                      ),
                                                      overflow:
                                                          TextOverflow.ellipsis,
                                                      maxLines: 2,
                                                    ),
                                                  ),
                                                  Column(
                                                    children: <Widget>[
                                                      IconButton(
                                                        onPressed: () => _addMarker(LatLng(store.lat, store.lng)), 
                                                      icon:Icon(
                                                          Icons.center_focus_strong,
                                                          color: Theme.of(context).secondaryHeaderColor,
                                                          size: 26.0,
                                                        ),
                                                      ),
                                                    ],
                                                  ),
                                                ],
                                              ),
                                              Container(
                                                padding: EdgeInsets.all(5.0),
                                                width: 125.0,
                                                decoration: BoxDecoration(
                                                  color: Color.fromARGB(255, 158, 74, 5),
                                                  borderRadius:
                                                      BorderRadius.circular(
                                                          5.0),
                                                ),
                                                alignment: Alignment.center,
                                                child: Text(
                                                  store.distance.toString().substring(0,4) + " Km",
                                                  style: TextStyle(
                                                    color: Color.fromARGB(255, 228, 107, 8),
                                                    fontSize: 18.0,
                                                  ),
                                                ),
                                              )
                                            ],
                                          ),
                                        ),
                                      ),
                                      Container(
                                        decoration: BoxDecoration(
                                          color: Colors.white,
                                          borderRadius:
                                              BorderRadius.circular(20.0),
                                          boxShadow: [
                                            BoxShadow(
                                              color: Colors.black26,
                                              offset: Offset(0.0, 2.0),
                                              blurRadius: 6.0,
                                            ),
                                          ],
                                        ),
                                        child: ClipRRect(
                                          borderRadius:
                                              BorderRadius.circular(20.0),
                                          child: Image.asset(
                                            'assets/images/Shoplogo.jpg',  
                                            height: 120.0,
                                            width: 120.0,
                                            fit: BoxFit.fill,
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
                }),
          )
        ],
      ),
      floatingActionButton: FloatingActionButton(
        mini: true,
        backgroundColor: Theme.of(context).primaryColor,
        foregroundColor: Colors.black,
        onPressed: () => _googleMapController.animateCamera(
          _info != null
              ? CameraUpdate.newLatLngBounds(_info.bounds, 100.0)
              : CameraUpdate.newCameraPosition(_initialCameraPosition),
        ),
        child: const Icon(Icons.center_focus_strong),
      ),
    );
  }

  void _addMarker(LatLng pos) async {
    if (_origin == null) {
      setState(() {
        _origin = Marker(
          markerId: const MarkerId('location'),
          infoWindow: const InfoWindow(title: 'Your Location'),
          icon:
              BitmapDescriptor.defaultMarkerWithHue(BitmapDescriptor.hueGreen),
          position: pos,
        );
      });
    } else {
      setState(() {
        _destination = (Marker(
          markerId: const MarkerId('store'),
          infoWindow: const InfoWindow(title: 'Store'),
          icon: BitmapDescriptor.defaultMarkerWithHue(BitmapDescriptor.hueBlue),
          position: pos,
        ));
        _polyline = Polyline(
          polylineId: const PolylineId('free_polyline'),
          color: Colors.red,
          width: 5,
          points: [
            LatLng(_origin.position.latitude, _origin.position.longitude),
            LatLng(_destination.position.latitude,
                _destination.position.longitude),
          ],
        );
      });
      // final directions = await DirectionsRepository()
      //     .getDirections(origin: _origin.position, destination: pos);
      // setState(() => _info = directions);
    }
    ;
  }
}
