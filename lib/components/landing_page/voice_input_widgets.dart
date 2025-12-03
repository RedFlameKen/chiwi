import 'package:flutter/material.dart';

class VoiceInputWidgets extends StatelessWidget{
  final VoidCallback? listenButton;
  final VoidCallback? stopButton;

  const VoiceInputWidgets({
    super.key,
    required this.listenButton,
    required this.stopButton
  });

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Expanded(
          child: Padding(
            padding: const EdgeInsetsGeometry.symmetric(horizontal: 8.0),
            child: ElevatedButton(
              onPressed: listenButton, 
              style: ElevatedButton.styleFrom(
                backgroundColor: Colors.lightGreenAccent,//button color
                foregroundColor: Colors.black,//text color
                padding: EdgeInsets.symmetric(vertical: 15),
                textStyle: TextStyle(fontSize: 20)
                ),
              child: Text('Chiwi Listen'),
            )
          )
        ),
        Expanded(
          child: Padding(
            padding: const EdgeInsetsGeometry.symmetric(horizontal: 8.0),
            child: ElevatedButton(
              onPressed: stopButton, 
              style: ElevatedButton.styleFrom(
              backgroundColor: Colors.red,//button color
              foregroundColor: Colors.white,//text color
              padding: EdgeInsets.symmetric(vertical: 15),
              textStyle: TextStyle(fontSize: 20)
              ),
              child: Text('Chiwi Stop'),
            )
          )
        ),
      ],
    );
  }

}
