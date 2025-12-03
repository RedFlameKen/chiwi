import 'dart:async';

import 'package:chiwi/reviewer/answer.dart';
import 'package:chiwi/reviewer/flashcard.dart';
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
          return _buildChat(chats[index]);
        },
      ),
    );
  }

  Widget _buildChat(ChatData chat) {
    if (chat.data is List<Flashcard>) {
      return FlashcardListChat(flashcards: chat.data);
    }

    return ChatBubble(chatData: chat);
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
        Flexible(
          child: Padding(
            padding: .all(10),
            child: Container(
              decoration: BoxDecoration(
                borderRadius: .all(.circular(10)),
                color: chatData.isMe ? ChiwiColors.PISTACHE : ChiwiColors.CHAI,
              ),
              child: Padding(
                padding: const EdgeInsets.all(12),
                child: SelectionArea(
                  child: Text(chatData.message, 
                  softWrap: true,
                  style: TextStyle(fontSize: 16)),
                ),
              ),
            ),
          ),
        ),
      ],
    );
  }
}

class ChatData<T> {
  String message;
  DateTime timeSent;
  bool isMe;
  T? data;

  ChatData({
    required this.message,
    required this.timeSent,
    this.isMe = true,
    this.data,
  });
}

class FlashcardListChat extends StatelessWidget {
  final List<Flashcard> flashcards;

  FlashcardListChat({required this.flashcards});

  Widget _buildList(List<Flashcard> flashcards) {
    return ListView.builder(
      physics: NeverScrollableScrollPhysics(),
      shrinkWrap: true,
      itemCount: flashcards.length,
      itemBuilder: (context, index) {
        return _buildFlashcardItem(flashcards[index]);
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    List<Flashcard> list = List.from(flashcards);
    return _buildList(list);
  }
}

Widget _buildFlashcardItem(Flashcard flashcard) {
  return Card(
    color: ChiwiColors.VANILLA,
    child: Padding(
      padding: .only(top: 5, bottom: 5, left: 15, right: 15),
      child: SelectionArea(
        child: Column(
          crossAxisAlignment: .start,
          children: [
            Text(
              flashcard.question ?? "no question",
              style: TextStyle(fontWeight: .bold, color: ChiwiColors.MATCHA),
            ),
            Text(
              flashcard.answers[0].answer ?? "No Answer",
              style: TextStyle(color: ChiwiColors.CAROB),
            ),
          ],
        ),
      ),
    ),
  );
}

@Preview(name: "FlashcardItem")
Widget previewFlaschardItem() {
  List<Flashcard> flashcards = [
    Flashcard(
      id: 0,
      question: "Sino si Lapu-Lapu?",
      type: .SIMPLE,
      answers: [Answer(id: 0, answer: "Hindi Ako")],
    ),
    Flashcard(
      id: 0,
      question: "What is 2+2?",
      type: .SIMPLE,
      answers: [Answer(id: 0, answer: "4")],
    ),
  ];

  return ListView.builder(
    itemCount: flashcards.length,
    itemBuilder: (context, index) {
      return _buildFlashcardItem(flashcards[index]);
    },
  );
}
