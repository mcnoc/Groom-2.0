class ChatMessage {
  int timeStamp = 0;
  String senderId = '';
  String name= '';
  String content= '';
  String uid= '';
  String? pictureLink = '';
  bool? picture;

  ChatMessage(
      { this.picture,required this.timeStamp,required this.senderId,required this.name,required this.content,required this.uid});

  ChatMessage.fromJson(Map<String, dynamic> json) {
    timeStamp = json["timeStamp"];
    senderId = json['senderId'];
    name = json['name'];
    content = json['content'];
    uid = json['uid'];
    picture = json['picture'];
    pictureLink = json['picturelink'];

  }
  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data["timeStamp"] = timeStamp;
    data["name"] = name;
    data["senderId"] = senderId;  // Fix the case here
    data["content"] = content;
    data['uid'] = uid;
    return data;
  }


}