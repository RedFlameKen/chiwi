import 'dart:async';
import 'dart:typed_data';

import 'package:chiwi/components/chat/chat_component.dart';
import 'package:chiwi/components/landing_page/voice_input_widgets.dart';
import 'package:chiwi/recording/recording.dart';
import 'package:chiwi/style/colors.dart';
import 'package:flutter/material.dart';

class ListenerPanel extends StatefulWidget {
  final Function(StreamController<ChatData>)? onInit;
  final Function(Uint8List, StreamController<ChatData>, Function()) onListen;
  final Function(String, StreamController<ChatData>, Function())? onSubmit;
  final Function(Function())? onFinishRecording;
  final Function(Function())? onStoppedRecording;
  final String inputHint;

  const ListenerPanel({
    super.key,
    required this.onListen,
    this.onSubmit,
    this.onInit,
    this.inputHint = "Type Questions here...",
    this.onFinishRecording,
    this.onStoppedRecording,
  });

  @override
  State<StatefulWidget> createState() => _ListenerPanelState();
}

class _ListenerPanelState extends State<ListenerPanel> {
  StreamController<ChatData> _chatStreamController = StreamController();
  final Recorder _recorder = Recorder();

  final TextEditingController _inputController = TextEditingController();
  final FocusNode _inputFocus = FocusNode();

  bool _listenEnabled = true;
  bool _inputsEnabled = true;

  @override
  void initState() {
    super.initState();
    if (widget.onInit != null) {
      widget.onInit!(_chatStreamController);
    }
  }

  @override
  void dispose() {
    super.dispose();
    _chatStreamController.close();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      color: ChiwiColors.MATCHA,
      child: Column(
        children: [
          Expanded(
            child: SizedBox(
              width: double.infinity,
              child: ChatPanel(chatStreamController: _chatStreamController),
            ),
          ),
          Container(
            margin: EdgeInsets.all(8),
            child: TextField(
              enabled: _listenEnabled,
              focusNode: _inputFocus,
              controller: _inputController,
              onSubmitted: (input) {
                if (widget.onSubmit != null) {
                  widget.onSubmit!(input, _chatStreamController, () {
                    setState(() {
                      _listenEnabled = true;
                      _inputsEnabled = true;
                    });
                  });
                }
                setState(() {
                  _inputController.clear();
                });
                _inputFocus.requestFocus();
              },
              decoration: InputDecoration(
                hintText: widget.inputHint,
                filled: true,
                fillColor: ChiwiColors.ALMOND,
                contentPadding: EdgeInsets.symmetric(
                  vertical: 15,
                  horizontal: 10,
                ),
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(5),
                ),
              ),
            ),
          ),
          VoiceInputWidgets(
            listenButton: !_inputsEnabled
                ? null
                : !_listenEnabled
                ? null
                : () async {
                    setState(() {
                      _listenEnabled = false;
                    });
                    Uint8List recordingData = await _recorder.startRecording();
                    setState(() {
                      _inputsEnabled = false;
                    });
                    setState(() {
                      widget.onListen(recordingData, _chatStreamController, () {
                        setState(() {
                          _listenEnabled = true;
                          _inputsEnabled = true;
                        });
                      });
                    });
                  },
            stopButton: !_inputsEnabled
                ? null
                : () async {
                    await _recorder.stopRecording();
                    setState(() {
                      _inputsEnabled = false;
                    });
                  },
          ),
          SizedBox(height: 10),
        ],
      ),
    );
  }
}
