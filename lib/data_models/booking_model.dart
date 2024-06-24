class BookingModel {
  String bookingId = '', clientId = '', providerId = '';
  int createdOn = 0;

  BookingModel(
      {required this.bookingId,
      required this.clientId,
      required this.providerId,required this.createdOn});

  BookingModel.fromJson(Map<String, dynamic> json) {
    bookingId = json['bookingId'];
    clientId = json['clientId'];
    providerId = json ['providerId'];
    createdOn = int.parse(json['createdOn'].toString());
  }
}
