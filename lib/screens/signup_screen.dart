import "package:flutter/material.dart";
import "package:twitch/resources/auth_methods.dart";
import "package:twitch/screens/home_screen.dart";
import "package:twitch/widgets/custom_button.dart";
import "package:twitch/widgets/custom_textfield.dart";
import "package:twitch/widgets/loading_indicator.dart";

class SignupScreen extends StatefulWidget {
  static const String routeName = '/signup';
  const SignupScreen({Key? key}) : super(key: key);

  @override
  _SignupScreenState createState() => _SignupScreenState();
}

class _SignupScreenState extends State<SignupScreen> {
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwardController = TextEditingController();
  final TextEditingController _usernameController = TextEditingController();

  final AuthMethods _authMethods = AuthMethods();

  bool _isLoading = false;

  void signUpUser() async {
    setState(() {
      _isLoading = true;
    });
    bool res = await _authMethods.signUpUser(context, _emailController.text,
        _usernameController.text, _passwardController.text);
    setState(() {
      _isLoading = false;
    });

    if (res) {
      Navigator.pushNamed(context, HomeScreen.routeName);
    }
  }

  @override
  void dispose() {
    _emailController.dispose();
    _passwardController.dispose();
    _usernameController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    return Scaffold(
        appBar: AppBar(
            title: const Text(
          "Sign Up",
          textAlign: TextAlign.center,
        )),
        body: _isLoading
            ? const LoadingIndicator()
            : SingleChildScrollView(
                child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 18.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    SizedBox(
                      height: size.height * 0.1,
                    ),
                    const Text(
                      "Email",
                      style: TextStyle(
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.symmetric(vertical: 8.0),
                      child: CustomTextField(controller: _emailController),
                    ),
                    const SizedBox(height: 20),
                    const Text(
                      "UserName",
                      style: TextStyle(
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.symmetric(vertical: 8.0),
                      child: CustomTextField(controller: _usernameController),
                    ),
                    const SizedBox(height: 20),
                    const Text(
                      "Password",
                      style: TextStyle(
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.symmetric(vertical: 8.0),
                      child: CustomTextField(controller: _passwardController),
                    ),
                    const SizedBox(height: 20),
                    CustomButton(onTap: signUpUser, text: "Sign Up"),
                  ],
                ),
              )));
  }
}
