class UserModel {
  String uid;
  String email;
  String fullName;
  String photoURL;
  String contactNumber;
  bool isblocked;
  String review;
  int rate;
  int joinedOn;

  UserModel({
    required this.uid,
    required this.email,
    required this.isblocked,
    required this.rate,
    required this.review,
    required this.photoURL,
    required this.contactNumber,
    required this.fullName,
    required this.joinedOn,
  });

  Map<String, dynamic> toJson() => {
    'fullName': fullName,
    'isblocked': isblocked,
    'rate': rate,
    "review": review,
    'uid': uid,
    'email': email,
    'contactNumber': contactNumber,
    'photoURL': photoURL,
    'joinedOn': joinedOn,
  };

  factory UserModel.fromJson(Map<String, dynamic> json) {
    return UserModel(
      fullName: json['fullName'],
      review: json['review'],
      rate: json['rate'],
      uid: json['uid'],
      isblocked: json['isblocked'],
      email: json['email'],
      photoURL: json['photoURL'],
      contactNumber: json['contactNumber'],
      joinedOn:  json ['joinedOn'],
    );
  }

}