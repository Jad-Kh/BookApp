import 'package:flutter/material.dart';
import 'package:dio/dio.dart';
import 'package:geocoding/geocoding.dart';
import 'package:geolocator/geolocator.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import '../models/directions_model.dart';
import 'package:flutter_polyline_points/flutter_polyline_points.dart';
import '../providers/directions_repository.dart';

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

  Future setStores() async {
    var response = await Dio().get(
        'http://10.0.2.2:5050/api/map/33.886961122036865/35.50566136837005');
    for (var item in response.data) {
      //_addMarker(LatLng(item.lat, item.lng), "store");
    }
    ;
  }

  @override
  void dispose() {
    _googleMapController.dispose();
    super.dispose();
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
      body: Container(
        alignment: Alignment.center,
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
          },
          onLongPress: _addMarker,
        ),
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
      });
      final directions = await DirectionsRepository()
          .getDirections(origin: _origin.position, destination: pos);
      setState(() => _info = directions);
    };
  }
}
