import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:meetme/components/width_btn.dart';
import 'package:meetme/providers/user_provider.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  final _formKey = GlobalKey<FormState>();

  String _email = "";
  String _password = "";

  var _isLoading = false;

  void _submit() async {
    setState(() {
      _isLoading = true;
    });
    if (!_formKey.currentState!.validate()) {
      setState(() {
        _isLoading = false;
      });
      return;
    }
    _formKey.currentState!.save();

    try {
      await UserProvider.instance.login(_email, _password);
      if (!mounted) return;
      Navigator.pushNamed(context, "/");
    } on DioException catch (error) {
      if (!mounted) return;
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text(error.response != null
              ? error.response.toString()
              : "An error occured"),
          backgroundColor: Colors.red,
        ),
      );
      setState(() {
        _isLoading = false;
      });
      return;
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text("Login")),
      body: Form(
        key: _formKey,
        child: Padding(
          padding: const EdgeInsets.all(25.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              TextFormField(
                decoration: const InputDecoration(labelText: "Email"),
                keyboardType: TextInputType.emailAddress,
                autocorrect: false,
                textCapitalization: TextCapitalization.none,
                validator: (val) {
                  if (val == null || val.isEmpty) {
                    return "Please enter your email";
                  }
                  return null;
                },
                onSaved: (val) {
                  _email = val!;
                },
              ),
              TextFormField(
                decoration: const InputDecoration(labelText: "Password"),
                keyboardType: TextInputType.visiblePassword,
                obscureText: true,
                autocorrect: false,
                textCapitalization: TextCapitalization.none,
                validator: (val) {
                  if (val == null || val.isEmpty) {
                    return "Please enter a password";
                  }
                  return null;
                },
                onSaved: (val) {
                  _password = val!;
                },
              ),
              const SizedBox(height: 20),
              _isLoading
                  ? const CircularProgressIndicator()
                  : WidthBtn(title: "Submit", action: _submit),
            ],
          ),
        ),
      ),
    );
  }
}
