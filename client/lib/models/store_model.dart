class Store {
  int store;
  double lat;
  double lng;
  String name;
  double distance;

  Store({
    required this.store,
    required this.lat,
    required this.lng,
    required this.name,
    required this.distance
  });

  factory Store.fromJson(Map<String, dynamic> json) {
    return Store(
      store: json['store'],
      lat: json['lat'],
      lng: json['lng'],
      name: json['name'],
      distance: json['distance']
    );
  }
} 