import 'package:chiwi/auth/account.dart';
import 'package:chiwi/components/input/button.dart';
import 'package:chiwi/components/input/text_input.dart';
import 'package:chiwi/pages/main_menu_page.dart';
import 'package:flutter/material.dart';

class LoginForm extends StatefulWidget {
  @override
  State<StatefulWidget> createState() => _LoginFormState();
}

class _LoginFormState extends State<LoginForm> {
  final _formKey = GlobalKey<FormState>();

  late TextEditingController usernameInputController = TextEditingController();
  late TextEditingController passwordInputController = TextEditingController();

  late TextInput usernameInput;
  late TextInput passwordInput;

  void disposeInputs() {
    usernameInputController.dispose();
    passwordInputController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    initInputs();
    return Form(
      key: _formKey,
      child: Column(
        mainAxisSize: .max,
        mainAxisAlignment: .start,
        children: [
          Expanded(
            flex: 1,
            child: Row(
              children: [
                Spacer(),
                Expanded(
                  flex: 2,
                  child: FittedBox(
                    child: Text(
                      "Welcome Back!",
                      textAlign: .center,
                      style: TextStyle(fontWeight: .bold, fontSize: 36),
                    ),
                  ),
                ),
                Spacer(),
              ],
            ),
          ),
          Expanded(
            flex: 2,
            child: Container(
              padding: .only(left: 50, right: 50, top: 25, bottom: 25),
              child: Column(
                mainAxisSize: .max,
                mainAxisAlignment: .spaceEvenly,
                children: [usernameInput, passwordInput],
              ),
            ),
          ),
          Expanded(
            flex: 1,
            child: FittedBox(
              child: Padding(
                padding: .only(left: 25, right: 25, top: 15, bottom: 15),
                child: Button(onPressed: onSubmit, text: "Log In"),
              ),
            ),
          ),
        ],
      ),
    );
  }

  void onSubmit() async {
    if (_formKey.currentState!.validate()) {
      await AccountManager.INSTANCE.loginWithUsernameAndPassword(
        username: usernameInputController.text,
        password: passwordInputController.text,
        onSuccess: (message) {
          Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) {
                return MainMenuPage();
              },
            ),
          );
          ScaffoldMessenger.of(
            context,
          ).showSnackBar(SnackBar(content: Text("logged in")));
          disposeInputs();
        },
        onFail: (message) {
          String msg = message ?? "failed to log in";
          ScaffoldMessenger.of(
            context,
          ).showSnackBar(SnackBar(content: Text(msg)));
        },
      );
    }
  }

  void initInputs() {
    usernameInput = TextInput(
      hint: "username",
      textController: usernameInputController,
      validator: (value) {
        if (value == null || value.isEmpty) {
          return "Do not leave this empty";
        }
        return null;
      },
    );

    passwordInput = TextInput(
      hint: "password",
      textController: passwordInputController,
      obscureText: true,
      validator: (value) {
        if (value == null || value.isEmpty) {
          return "Do not leave this empty";
        }
        return null;
      },
    );
  }
}
