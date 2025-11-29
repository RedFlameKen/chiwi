import 'package:chiwi/style/colors.dart';
import 'package:flutter/material.dart';

class QuizEndInfo extends StatelessWidget{
  const QuizEndInfo({super.key});

  @override
  Widget build(BuildContext context) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        Expanded(
          child: Container(
            margin: const EdgeInsets.all(10),
            padding: const EdgeInsets.all(12),
            decoration: BoxDecoration(
              color: ChiwiColors.ALMOND,
              borderRadius: BorderRadius.circular(5),
            ),
            child: const Text(
              //replace this to show answered questions from flashcards
              "Sino Pumatay kay Lapu-Lapu?\nAnswer: DI AKO SIR",
              style: TextStyle(
                fontSize: 16,
                color: Colors.black,
              ),
            ),
          ) 
        ),
        Expanded(
          child: Column(
            //this is to display chiwi
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              const Text(
                "Woof! :D",
                style: TextStyle(
                  fontSize: 25,
                  fontWeight: FontWeight.bold,
                  color: Colors.black,
                ),
              ),
              Expanded(
                child: Image.network(
                  "https://i.imgflip.com/77e8vi.png",
                  fit: BoxFit.contain,
                ),
              ),
            ],
          )
        ),
        Expanded(
          //this is the score display box
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Flexible(
                  flex: 1,
                  child: Container(
                    margin: const EdgeInsets.all(12),
                    decoration: BoxDecoration(
                      color: ChiwiColors.ALMOND,
                      border: Border.all(
                        color: ChiwiColors.MATCHA,
                        width: 7,
                      ),
                      borderRadius: BorderRadius.circular(5),
                    ),
                    alignment: Alignment.center,
                  child: Text(
                    "60/60",
                    style: const TextStyle(
                      fontSize: 27,
                      fontWeight: FontWeight.bold,
                      color: Colors.black,
                    ),
                  ),
                )
              )
            ],
          ),
        ),
      ],
    );
  }
}