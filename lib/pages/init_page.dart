import 'package:chiwi/auth/account.dart';
import 'package:chiwi/pages/landing_page.dart';
import 'package:chiwi/pages/main_menu_page.dart';
import 'package:chiwi/style/colors.dart';
import 'package:flutter/material.dart';

class InitPage extends StatefulWidget {
  InitPage({super.key});

  @override
  State<StatefulWidget> createState() => _InitPageState();
}

class _InitPageState extends State<InitPage> {

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      _init();
    });
  }

  Future<void> _init() async {
    await AccountManager.INSTANCE.loginWithAuthToken(
      onSuccess: (message) {
        ScaffoldMessenger.of(
          context,
        ).showSnackBar(SnackBar(content: Text(message ?? "logged in")));
        Navigator.pushReplacement(
          context,
          MaterialPageRoute(builder: (context) => MainMenuPage()),
        );
      },
      onFail: (message) {
        Navigator.pushReplacement(
          context,
          MaterialPageRoute(
            builder: (_) {
              return LandingPage();
            },
          ),
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        color: ChiwiColors.VANILLA,
        child: Center(
          child: CircularProgressIndicator(color: ChiwiColors.MATCHA),
        ),
      ),
    );
  }
}
