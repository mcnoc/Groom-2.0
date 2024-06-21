import 'package:bubble/bubble.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';

import '../../data_models/message_model.dart';
import '../../utils/time_ago.dart';


Widget bubbleTextFromUser(ChatMessage chatContent, String imageURL) {
  return Column(
    children: [
      TimeAgo.isSameDay(chatContent.timeStamp)
          ? Container()
          : Text(TimeAgo.timeAgoSinceDate(chatContent.timeStamp)),
      Row(
        children: [
          SizedBox(
            width: 20,
          ),
          CircleAvatar(
            radius: 20,
            backgroundColor: Colors.transparent,
            child: CachedNetworkImage(
              imageUrl: imageURL,
            ),
          ),
          Expanded(
            child: Bubble(
              margin: const BubbleEdges.only(top: 10.0),
              alignment: Alignment.topLeft,
              nip: BubbleNip.leftBottom,
              color:Color(0xFFFF6222),
              child: Padding(
                padding: const EdgeInsets.all(6.0),
                child: Text(
                  chatContent.content,
                  softWrap: true,
                  style: const TextStyle(
                      color: Color(0xFF2B3454),
                      fontSize: 14,
                      fontWeight: FontWeight.w700),
                  textAlign: TextAlign.left,
                ),
              ),
            ),
          ),
        ],
      ),
    ],
  );
}

Widget bubbleTextToUser(ChatMessage chatContent) {
  return Column(
    children: [
      TimeAgo.isSameDay(chatContent.timeStamp)
          ? Container()
          : Text(TimeAgo.timeAgoSinceDate(chatContent.timeStamp)),
      Bubble(
        margin: const BubbleEdges.only(top: 10.0),
        alignment: Alignment.topRight,
        nip: BubbleNip.rightBottom,
        color: Color(0xFFF2F2F2),
        child: Padding(
          padding: const EdgeInsets.all(6.0),
          child: Text(
            chatContent.content,
            style: const TextStyle(
                color: Color(0xFFFF6222),
                fontWeight: FontWeight.w500,
                fontSize: 14),
            textAlign: TextAlign.left,
          ),
        ),
      ),
    ],
  );
}

Widget bubbleImageFromUser(ChatMessage chatContent) {
  return Column(
    children: [
      TimeAgo.isSameDay(chatContent.timeStamp)
          ? Container()
          : Text(TimeAgo.timeAgoSinceDate(chatContent.timeStamp)),
      Bubble(
        margin: const BubbleEdges.only(top: 10.0),
        alignment: Alignment.topLeft,
        nip: BubbleNip.leftBottom,
        color: Colors.black,
        child: Column(
          children: [
            Image.network("${chatContent.pictureLink}"),
            Text(
              chatContent.content,
              style: const TextStyle(
                color: Colors.white,
              ),
              textAlign: TextAlign.right,
            ),
          ],
        ),
      ),
    ],
  );
}

Widget bubbleImageToUser(ChatMessage chatContent) {
  return Column(
    children: [
      TimeAgo.isSameDay(chatContent.timeStamp)
          ? Container()
          : Text(TimeAgo.timeAgoSinceDate(chatContent.timeStamp)),
      Bubble(
        margin: const BubbleEdges.only(top: 10.0),
        alignment: Alignment.topRight,
        nip: BubbleNip.leftBottom,
        color: Colors.yellow,
        child: Text(
          chatContent.content,
          style: const TextStyle(
            color: Colors.white,
          ),
          textAlign: TextAlign.left,
        ),
      ),
    ],
  );
}