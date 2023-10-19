import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:pandawatest/screens/shared/errortext.dart';
import 'package:pandawatest/services/apiservice.dart';
import 'package:pandawatest/model/exception/networkexception.dart';
import 'package:pandawatest/services/valuepreferences.dart';

class RegisterPage extends StatefulWidget {
  const RegisterPage({super.key});

  @override
  State<RegisterPage> createState() => _RegisterPageState();
}

class _RegisterPageState extends State<RegisterPage> {
  TextEditingController usernameController = TextEditingController();
  TextEditingController passwordController = TextEditingController();
  TextEditingController emailController = TextEditingController();
  final GlobalKey<FormState> registerKey = GlobalKey<FormState>();
  APIService apiService = APIService();
  String? errorMessage;
  bool isPasswordVisible = false;
  @override
  void initState() {
    super.initState();
  }

  void doRegister() async {
    if (mounted) {
      setState(() {
        errorMessage = null;
      });
    }
    try {
      await apiService.postRegister(emailController.text,
          usernameController.text, passwordController.text);
      await ValuePreferences.saveValue('token',
          'WtILxkBgyhDltTqEQ1w7r7RBbic5GWU0jhIjv7WSSbL4Ua29Y8ZxKoLxX21sMSwx');
      if (mounted) {
        setState(() {
          Navigator.pushReplacementNamed(context, '/home');
        });
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
        appBar: AppBar(title: const Text("Register")),
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
                key: registerKey,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    TextFormField(
                      controller: emailController,
                      validator: (value) =>
                          value!.isEmpty ? "Enter Email" : null,
                      decoration: InputDecoration(
                        hintText: 'Email',
                        contentPadding: const EdgeInsets.symmetric(
                            horizontal: 16.0, vertical: 8.0),
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(32.0),
                        ),
                      ),
                      keyboardType: TextInputType.emailAddress,
                    ),
                    const SizedBox(
                      height: 8.0,
                    ),
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
                  if (registerKey.currentState!.validate()) {
                    doRegister();
                  }
                },
                child: const Text(
                  "Register",
                  style: TextStyle(color: Colors.white),
                ),
              ),
            ),
            TextButton(
                onPressed: () {
                  Navigator.pushReplacementNamed(context, '/login');
                },
                child: const Text(
                  "Already have an account? Login here",
                  style: TextStyle(color: Colors.green),
                )),
            errorMessage != null
                ? ErrorText(
                    text: errorMessage!,
                  )
                : Container(),
          ],
        ),
      ),
    );
  }
}
