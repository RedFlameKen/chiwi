import 'package:chiwi/style/colors.dart';
import 'package:flutter/material.dart';

class LandingPage extends StatelessWidget {
  const LandingPage({super.key});

  @override
  Widget build(BuildContext context) {
    final appBar = AppBar(
      title: Text("CHIWI AI", style: TextStyle(fontWeight: FontWeight.bold)),
      backgroundColor: ChiwiColors.CHAI,
    );
    final screenHeight = MediaQuery.of(context).size.height;
    final appBarHeight = appBar.preferredSize.height;
    final ctaHeight = screenHeight - appBarHeight;
    return Scaffold(
      appBar: appBar,
      body: Container(
        decoration: BoxDecoration(
          gradient: LinearGradient(
            colors: [ChiwiColors.VANILLA, ChiwiColors.ALMOND],
          ),
        ),
        child: ListView(
          children: [
            Row(
              mainAxisSize: MainAxisSize.min,
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Expanded(
                  child: SizedBox(
                    height: ctaHeight,
                    child: FittedBox(
                      child: Column(
                        mainAxisSize: MainAxisSize.min,
                        mainAxisAlignment: MainAxisAlignment.spaceAround,
                        children: [
                          Image(
                            fit: BoxFit.cover,
                            image: NetworkImage(
                              "https://i.imgflip.com/77e8vi.png",
                            ),
                          ),
                          Text("CHIWI AI", style: TextStyle(fontSize: 50)),
                        ],
                      ),
                    ),
                  ),
                ),
                Expanded(
                  child: Container(
                    alignment: AlignmentGeometry.center,
                    child: ElevatedButton(
                      style: ElevatedButton.styleFrom(
                        backgroundColor: ChiwiColors.MATCHA,
                        padding: EdgeInsetsGeometry.only(
                          top: 25,
                          bottom: 25,
                          left: 150,
                          right: 150,
                        ),
                      ),
                      onPressed: () {},
                      child: Text(
                        "Get Started",
                        style: TextStyle(
                          color: ChiwiColors.ALMOND,
                          fontSize: 36,
                        ),
                      ),
                    ),
                  ),
                ),
              ],
            ),
            Text("breh"),
          ],
        ),
      ),
    );
  }
}
