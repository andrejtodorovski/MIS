import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:lab3_201084/auth.dart';
import 'package:lab3_201084/login_page.dart';

class RegisterPage extends StatefulWidget {
  static const String id = "registerPage";

  const RegisterPage({super.key});

  @override
  State<RegisterPage> createState() => _RegisterPageState();
}

class _RegisterPageState extends State<RegisterPage> {
  String? errorMessage = '';
  bool hasError = false;

  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();

  Future<void> createUser() async {
    if (_emailController.text.isEmpty || _passwordController.text.isEmpty) {
      setState(() => errorMessage = 'Пополнете ги сите полиња');
      return;
    }

    try {
      await Auth()
          .createUserWithEmailAndPassword(
              _emailController.text, _passwordController.text)
          .then((value) => {
                Navigator.pushReplacement(context,
                    MaterialPageRoute(builder: (context) => const LoginPage()))
              });
    } on FirebaseAuthException catch (e) {
      hasError = true;
      setState(() {
        errorMessage = e.message;
      });
    }
  }

  Widget _title() => const Text('Регистрирај се');

  Widget _entryField(String title, TextEditingController controller,
      {bool isPassword = false}) {
    return Container(
      margin: const EdgeInsets.symmetric(vertical: 10),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(title,
              style:
                  const TextStyle(fontWeight: FontWeight.bold, fontSize: 15)),
          const SizedBox(height: 10),
          TextField(
            controller: controller,
            obscureText: isPassword,
            decoration: const InputDecoration(
                border: InputBorder.none,
                fillColor: Color(0xfff3f3f4),
                filled: true),
          )
        ],
      ),
    );
  }

  Widget _errorMessage() {
    return Container(
      padding: const EdgeInsets.symmetric(vertical: 10),
      alignment: Alignment.center,
      child: Text(errorMessage!,
          style: const TextStyle(color: Colors.red, fontSize: 13)),
    );
  }

  Widget _submitButton() {
    return ElevatedButton(
        onPressed: createUser,
        child: const Text('Регистрирај се', style: TextStyle(fontSize: 20)));
  }

  Widget _loginLink() {
    return RichText(
      text: TextSpan(
        children: <TextSpan>[
          const TextSpan(
              text: "Веќе имате сметка? ",
              style: TextStyle(color: Colors.black)),
          TextSpan(
            text: 'Најавете се тука.',
            style: const TextStyle(
                fontWeight: FontWeight.bold,
                color: Colors.blue,
                decoration: TextDecoration.none),
            recognizer: TapGestureRecognizer()
              ..onTap = () {
                Navigator.pushReplacement(context,
                    MaterialPageRoute(builder: (context) => const LoginPage()));
              },
          ),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: _title(),
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(20),
        child: Center(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              _entryField('Е-маил', _emailController),
              _entryField('Лозинка', _passwordController, isPassword: true),
              _errorMessage(),
              _submitButton(),
              const SizedBox(height: 20),
              _loginLink(),
            ],
          ),
        ),
      ),
    );
  }
}
