import 'package:chiwi/auth/account.dart';
import 'package:chiwi/components/input/button.dart';
import 'package:chiwi/components/input/text_input.dart';
import 'package:flutter/material.dart';

class SignupForm extends StatefulWidget {
  @override
  State<StatefulWidget> createState() => _SignupFormState();
}

class _SignupFormState extends State<SignupForm> {
  final _formKey = GlobalKey<FormState>();

  late TextEditingController usernameInputController = TextEditingController();
  late TextEditingController passwordInputController = TextEditingController();
  late TextEditingController reenterInputController = TextEditingController();

  late TextInput usernameInput;
  late TextInput passwordInput;
  late TextInput reenterInput;

  void disposeInputs() {
    usernameInputController.dispose();
    passwordInputController.dispose();
    reenterInputController.dispose();
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
                  child: Text(
                    "Create a Username and Password",
                    textAlign: .center,
                    style: TextStyle(fontWeight: .bold, fontSize: 36),
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
                children: [usernameInput, passwordInput, reenterInput],
              ),
            ),
          ),
          Expanded(
            flex: 1,
            child: Center(
              child: Button(onPressed: onSubmit, text: "Create Account"),
            ),
          ),
        ],
      ),
    );
  }

  void onSubmit() async {
    if (_formKey.currentState!.validate()) {
      await AccountManager.INSTANCE.signup(
        username: usernameInputController.text,
        password: passwordInputController.text,
        onSuccess: (message) {
          ScaffoldMessenger.of(
            context,
          ).showSnackBar(SnackBar(content: Text("signed up!")));
          Navigator.pop(context);
          dispose();
        },
        onFail: (message) {
          String msg = message ?? "failed to sign up";
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

    reenterInput = TextInput(
      hint: "re-enter password",
      textController: reenterInputController,
      obscureText: true,
      validator: (value) {
        if (value == null || value.isEmpty) {
          return "Do not leave this empty";
        }

        if (value != passwordInputController.text) {
          return "password did not match";
        }

        return null;
      },
    );
  }
}
