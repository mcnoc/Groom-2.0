class MapModel {
  late final int id;
  late final String name;
  late final String address;
  late final int capacity;
  late final String city;
  late final bool isVirtualStation;
  late final double latitude;
  late final double longitude;
  late final String zip;

  MapModel(
      this.id,
      this.name,
      this.address,
      this.capacity,
      this.city,
      this.isVirtualStation,
      this.latitude,
      this.longitude,
      this.zip,
      );

  // fromJson method
  factory MapModel.fromJson(Map<String, dynamic> json) {
    return MapModel(
      json['id'],
      json['name'],
      json['address'],
      json['capacity'],
      json['city'],
      json['isVirtualStation'],
      json['latitude'],
      json['longitude'],
      json['zip'],
    );
  }

  // toJson method
  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'name': name,
      'address': address,
      'capacity': capacity,
      'city': city,
      'isVirtualStation': isVirtualStation,
      'latitude': latitude,
      'longitude': longitude,
      'zip': zip,
    };
  }
}