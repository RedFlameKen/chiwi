import 'dart:async';

import 'package:chiwi/style/colors.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widget_previews.dart';

class ChatPanel extends StatefulWidget {
  final StreamController<ChatData> chatStreamController;

  ChatPanel({required this.chatStreamController});

  @override
  State<StatefulWidget> createState() => _ChatPanelState();
}

class _ChatPanelState extends State<ChatPanel> {
  List<ChatData> chats = .empty(growable: true);
  final ScrollController _scrollController = ScrollController();
  late StreamSubscription _streamSubscription;

  @override
  void initState() {
    super.initState();
    if (!widget.chatStreamController.hasListener) {
      _streamSubscription = widget.chatStreamController.stream.listen((
        chat,
      ) async {
        setState(() {
          chats.add(chat);
        });
        WidgetsBinding.instance.addPostFrameCallback((duration) async {
          await _scrollController.animateTo(
            _scrollController.position.maxScrollExtent,
            duration: Duration(milliseconds: 500),
            curve: Curves.fastOutSlowIn,
          );
        });
      });
    }
  }

  @override
  void dispose() {
    super.dispose();
    _streamSubscription.cancel();
    widget.chatStreamController.close();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.all(12),
      padding: EdgeInsets.all(12),
      decoration: BoxDecoration(
        color: ChiwiColors.ALMOND,
        borderRadius: .circular(5),
      ),
      child: ListView.builder(
        controller: _scrollController,
        itemCount: chats.length,
        itemBuilder: (context, index) {
          return ChatBubble(chatData: chats[index]);
        },
      ),
    );
  }
}

@Preview(name: "ChatBubble")
Widget chatBubblePreview() {
  return ChatBubble(
    chatData: ChatData(message: "Hello, World", timeSent: .now(), isMe: true),
  );
}

@immutable
class ChatBubble extends StatelessWidget {
  final ChatData chatData;

  const ChatBubble({super.key, required this.chatData});

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: chatData.isMe ? .start : .end,
      children: [
        Padding(
          padding: .all(10),
          child: Container(
            decoration: BoxDecoration(
              borderRadius: .all(.circular(10)),
              color: chatData.isMe ? ChiwiColors.PISTACHE : ChiwiColors.CHAI,
            ),
            child: Padding(
              padding: const EdgeInsets.all(12),
              child: Text(chatData.message, style: TextStyle(fontSize: 16)),
            ),
          ),
        ),
      ],
    );
  }
}

class ChatData {
  String message;
  DateTime timeSent;
  bool isMe;

  ChatData({required this.message, required this.timeSent, this.isMe = true});
}
