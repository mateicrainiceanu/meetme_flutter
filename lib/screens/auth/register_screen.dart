import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:meetme/components/width_btn.dart';
import 'package:meetme/models/auth_user.dart';
import 'package:meetme/providers/user_provider.dart';

class RegisterScreen extends StatefulWidget {
  const RegisterScreen({super.key});

  @override
  State<RegisterScreen> createState() => _RegisterScreenState();
}

class _RegisterScreenState extends State<RegisterScreen> {
  final _formKey = GlobalKey<FormState>();

  var _fname = "";
  var _lname = "";
  var _email = "";
  var _password = "";
  var _passConfirm = "";
  var _username = "";
  DateTime? _dateOfBirth;

  var _isLoading = false;

  void _selectDate() async {
    final DateTime? picked = await showDatePicker(
      context: context,
      initialDate: DateTime.now(),
      firstDate: DateTime(1900),
      lastDate: DateTime.now(),
    );
    if (picked != null) {
      setState(() {
        _dateOfBirth = picked;
      });
    }
  }

  void _submit() async {
    setState(() {
      _isLoading = true;
    });

    print(!_formKey.currentState!.validate());

    if (!_formKey.currentState!.validate() || _dateOfBirth == null) {
      setState(() {
        _isLoading = false;
      });
      return;
    }
    _formKey.currentState!.save();

    if (_password != _passConfirm) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text("Passwords do not match"),
          backgroundColor: Colors.red,
        ),
      );
      setState(() {
        _isLoading = false;
      });
      return;
    }

    try {
      await UserProvider.instance.register(
          _fname, _lname, _email, _password, _username, _dateOfBirth!);
    } on DioException catch (error) {
      if (!mounted) return;
      setState(() {
        _isLoading = false;
      });
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text(error.response != null
              ? error.response.toString()
              : "An error occured"),
          backgroundColor: Colors.red,
        ),
      );
      return;
    }
    if (!mounted) return;
    Navigator.pushNamed(context, "/");
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text("Register")),
      body: SingleChildScrollView(
        child: Form(
          key: _formKey,
          child: Padding(
            padding: const EdgeInsets.all(25.0),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                TextFormField(
                  decoration: const InputDecoration(labelText: "First Name"),
                  validator: (val) {
                    if (val == null || val.isEmpty || val.length < 2) {
                      return "Invalid Name";
                    }
                    return null;
                  },
                  onSaved: (val) {
                    _fname = val!;
                  },
                ),
                TextFormField(
                  decoration: const InputDecoration(labelText: "Last Name"),
                  validator: (val) {
                    if (val == null || val.isEmpty) {
                      return "Invalid Name";
                    }
                    return null;
                  },
                  onSaved: (val) {
                    _lname = val!;
                  },
                ),
                const SizedBox(height: 20),
                TextFormField(
                  decoration: const InputDecoration(labelText: "Username"),
                  textCapitalization: TextCapitalization.none,
                  autocorrect: false,
                  validator: (val) {
                    if (val == null || val.isEmpty) {
                      return "Invalid Name";
                    }
                    return null;
                  },
                  onSaved: (val) {
                    _username = val!;
                  },
                ),
                const SizedBox(height: 20),
                SizedBox(
                  width: double.infinity,
                  child: ElevatedButton(
                      onPressed: _selectDate,
                      child: Text(_dateOfBirth != null
                          ? _dateOfBirth
                              .toString()
                              .substring(0, 10)
                              .split("-")
                              .reversed
                              .join(".")
                          : "Pick a date")),
                ),
                const SizedBox(height: 20),
                TextFormField(
                  decoration: const InputDecoration(labelText: "Email"),
                  keyboardType: TextInputType.emailAddress,
                  autocorrect: false,
                  textCapitalization: TextCapitalization.none,
                  validator: (val) {
                    if (val == null ||
                        val.isEmpty ||
                        !val.contains("@") ||
                        !val.contains(".")) {
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
                    if (val == null || val.isEmpty || val.length < 6) {
                      return "Please enter a password with at least 6 characters";
                    }
                    return null;
                  },
                  onSaved: (val) {
                    _password = val!;
                  },
                ),
                TextFormField(
                  decoration:
                      const InputDecoration(labelText: "Repeat Password"),
                  keyboardType: TextInputType.visiblePassword,
                  obscureText: true,
                  autocorrect: false,
                  textCapitalization: TextCapitalization.none,
                  validator: (val) {
                    if (val == null || val.isEmpty || val.length < 6) {
                      return "Please enter a password with at least 6 characters";
                    }
                    return null;
                  },
                  onSaved: (val) {
                    _passConfirm = val!;
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
      ),
    );
  }
}
