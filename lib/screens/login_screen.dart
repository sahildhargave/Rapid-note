import "package:flutter/material.dart";
import "package:twitch/resources/auth_methods.dart";
import "package:twitch/screens/home_screen.dart";
import "package:twitch/widgets/custom_button.dart";
import "package:twitch/widgets/custom_textfield.dart";
import "package:twitch/widgets/loading_indicator.dart";

class LoginScreen extends StatefulWidget {
  static const String routeName = '/login';
  const LoginScreen({Key? key}) : super(key: key);

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwardController = TextEditingController();
  // final TextEditingController _nameController = TextEditingController();
  final AuthMethods _authMethods = AuthMethods();

  bool _isLoading = false;

  loginUser() async {
    setState(() {
      _isLoading = true;
    });
    bool res = await _authMethods.loginUser(
      context,
      _emailController.text,
      _passwardController.text,
    );

    setState(() {
      _isLoading = false;
    });

    if (res) {
      Navigator.pushReplacementNamed(context, HomeScreen.routeName);
    }
  }

  @override
  void dispose() {
    _emailController.dispose();
    _passwardController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    return Scaffold(
        appBar: AppBar(
            title: const Text(
          "Login",
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
                    CustomButton(onTap: loginUser, text: "Login")
                  ],
                ),
              )));
  }
}
