import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:pandawatest/model/response/loginresponse.dart';
import 'package:pandawatest/screens/shared/errortext.dart';
import 'package:pandawatest/services/apiservice.dart';
import 'package:pandawatest/model/exception/networkexception.dart';
import 'package:pandawatest/services/valuepreferences.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({super.key});

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  TextEditingController usernameController = TextEditingController();
  TextEditingController passwordController = TextEditingController();
  final GlobalKey<FormState> loginKey = GlobalKey<FormState>();
  APIService apiService = APIService();
  String? errorMessage;
  String? token;
  bool isPasswordVisible = false;
  void checkToken() async {
    token = await ValuePreferences.getValue('token');
    if (token != null) {
      setState(() {
        Navigator.pushReplacementNamed(context, '/home');
      });
    }
  }

  @override
  void initState() {
    super.initState();
    checkToken();
  }

  void doLogin() async {
    if (mounted) {
      setState(() {
        errorMessage = null;
      });
    }

    try {
      LoginResponse? response = await apiService.postLogin(
          usernameController.text, passwordController.text);
      var login = await ValuePreferences.saveValue('token', response.token);
      if (mounted) {
        if (login) {
          setState(
            () {
              Navigator.pushReplacementNamed(context, '/home');
            },
          );
        }
      }
    } on DioException catch (e) {
      if (mounted) {
        setState(() {
          errorMessage = NetworkExceptions.getErrorMessageFromDioException(e);
        });
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        appBar: AppBar(title: const Text("Login")),
        body: Column(
          children: [
            const Padding(
              padding: EdgeInsets.all(16.0),
              child: CircleAvatar(
                radius: 96,
                backgroundImage: AssetImage(
                  'images/logo.png',
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(16.0),
              child: Form(
                key: loginKey,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    TextFormField(
                      controller: usernameController,
                      validator: (value) =>
                          value!.isEmpty ? "Enter Username" : null,
                      decoration: InputDecoration(
                        hintText: 'Username',
                        contentPadding: const EdgeInsets.symmetric(
                            horizontal: 16.0, vertical: 8.0),
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(32.0),
                        ),
                      ),
                      keyboardType: TextInputType.text,
                    ),
                    const SizedBox(
                      height: 8.0,
                    ),
                    TextFormField(
                      validator: (value) =>
                          value!.isEmpty ? "Enter Password" : null,
                      controller: passwordController,
                      obscureText: !isPasswordVisible,
                      keyboardType: TextInputType.visiblePassword,
                      decoration: InputDecoration(
                        contentPadding: const EdgeInsets.symmetric(
                            horizontal: 16.0, vertical: 8.0),
                        border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(32.0)),
                        hintText: "Password",
                        suffixIcon: IconButton(
                          onPressed: () {
                            setState(() {
                              isPasswordVisible = !isPasswordVisible;
                            });
                          },
                          icon: Icon(
                            isPasswordVisible
                                ? Icons.visibility
                                : Icons.visibility_off,
                            color: Colors.black,
                          ),
                        ),
                      ),
                    ),
                    const SizedBox(
                      height: 16.0,
                    ),
                  ],
                ),
              ),
            ),
            Container(
              width: double.infinity,
              padding: const EdgeInsets.all(16.0),
              child: ElevatedButton(
                style: const ButtonStyle(
                  backgroundColor: MaterialStatePropertyAll(
                    Color.fromARGB(255, 10, 140, 25),
                  ),
                ),
                onPressed: () {
                  if (loginKey.currentState!.validate()) {
                    doLogin();
                  }
                },
                child: const Text(
                  "Login",
                  style: TextStyle(color: Colors.white),
                ),
              ),
            ),
            TextButton(
              onPressed: () {
                Navigator.pushReplacementNamed(context, '/register');
              },
              child: const Text(
                "Don't have an account? Create here",
                style: TextStyle(color: Colors.green),
              ),
            ),
            errorMessage != null ? ErrorText(text: errorMessage!) : Container(),
          ],
        ),
      ),
    );
  }
}
