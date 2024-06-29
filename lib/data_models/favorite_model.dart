class FavoriteModel {
  DateTime addedOn = DateTime(1999);

  String serviceId = "";

  FavoriteModel(this.addedOn, this.serviceId);

  FavoriteModel.fromJson(Map<String, dynamic> json) {
    addedOn = json['addedOn'];
    serviceId = json['serviceId'];
  }

  Map<String, dynamic> toJson() {
    final data = <String, dynamic>{};
    data['addedOn'] = addedOn;
    data['serviceId'] = serviceId;
    return data;
  }
}
