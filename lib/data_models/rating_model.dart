class RatingModel {
  double ratingValue = 0.0;
  String userId = "";
  int createdOn = 0;

  RatingModel(
      {required this.ratingValue,
      required this.userId,
      required this.createdOn});

  RatingModel.fromJson(Map<String, dynamic> json) {
    ratingValue = double.parse(json['ratingValue']);
    userId = json['userId'];
    createdOn = int.parse(json['createdOn']);
  }

  Map<String, dynamic> toJson() {
    final data = <String, dynamic>{};
    data['ratingValue'] = ratingValue;
    data['userId'] = userId;
    data['createdOn'] = createdOn;
    return data;
  }
}
