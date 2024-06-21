class ChatInfo {
  final String friendName;
  final String friendId;
  late String createId;
  final String lastMessage;
  final String createName;
  late int createDate;
  late int lastUpdated;
  late String friendImage;
  late String createdImage;

  ChatInfo({
    required this.lastUpdated,
    required this.friendName,
    required this.friendId,
    required this.createId,
    required this.lastMessage,
    required this.createName,
    required this.createDate,
    required this.friendImage,
    required this.createdImage,
  });

  factory ChatInfo.fromJson(Map<String, dynamic> json) {
    return ChatInfo(
      lastUpdated: json['lastupdated'],
      friendName: json['friendname'],
      friendId: json['friendId'],
      createId: json['createId'],
      lastMessage: json['lastmessage'],
      createName: json['createname'],
      createDate: json['createdate'],
      friendImage: json['friendImage'],
      createdImage: json['createdImage'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'lastupdated': lastUpdated,
      'friendname': friendName,
      'friendId': friendId,
      'createId': createId,
      'lastmessage': lastMessage,
      'createname': createName,
      'createdate': createDate,
      'friendImage': friendImage,
      'createdImage': createdImage,
    };
  }
}