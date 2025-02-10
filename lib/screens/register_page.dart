import 'dart:math';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:authentication_ui/screens/otp_verification.dart';
import 'package:authentication_ui/utils/text_styles.dart';
import 'package:authentication_ui/utils/utils.dart';
import 'dart:async';

import '../router/router.dart';
import 'fade_animationtest.dart';

class CustomTextFormField extends StatefulWidget {
  final String hinttext;
  final bool obsecuretext;
  final String? Function(String?)? validator;
  final TextEditingController? controller;
  const CustomTextFormField({
    Key? key,
    required this.hinttext,
    required this.obsecuretext,
    this.controller,
    this.validator,
  }) : super(key: key);

  @override
  State<CustomTextFormField> createState() => _CustomTextFormFieldState();
}

class _CustomTextFormFieldState extends State<CustomTextFormField> {
  @override
  Widget build(BuildContext context) {
    return TextFormField(
      controller: widget.controller,
      obscureText: widget.obsecuretext,
      decoration: InputDecoration(
        contentPadding: const EdgeInsets.all(18),
        border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(18),
            borderSide: BorderSide.none),
        fillColor: const Color(0xFF731C65).withOpacity(0.1),
        filled: true,
        focusedBorder: OutlineInputBorder(
          borderSide:
              const BorderSide(color: const Color(0xFF731C65), width: 2.0),
          borderRadius: BorderRadius.circular(12),
        ),
        hintText: widget.hinttext,
        hintStyle: hinttext,
      ),
      validator: widget.validator,
    );
  }
}

class CustomElevatedButton extends StatefulWidget {
  final String message;
  final FutureOr<void> Function() function;
  final Color? color;

  const CustomElevatedButton({
    Key? key,
    required this.message,
    required this.function,
    this.color = Colors.white,
  }) : super(key: key);

  @override
  State<CustomElevatedButton> createState() => _CustomElevatedButtonState();
}

class _CustomElevatedButtonState extends State<CustomElevatedButton> {
  bool loading = false;
  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
      onPressed: () async {
        setState(() {
          loading = true;
        });

        try {
          // ignore: unnecessary_null_comparison
          if (widget.function != null) {
            await widget.function();
          }
        } catch (e) {
          // print("Error executing function: $e");
        }

        setState(() {
          loading = false;
        });
      },
      style: ButtonStyle(
          shape: WidgetStateProperty.all(
              RoundedRectangleBorder(borderRadius: BorderRadius.circular(10))),
          fixedSize: WidgetStateProperty.all(const Size.fromWidth(300)),
          padding: WidgetStateProperty.all(
            const EdgeInsets.symmetric(vertical: 15),
          ),
          backgroundColor: WidgetStateProperty.all(
            const Color(0xFF731C65),
          )),
      child: loading
          ? const CupertinoActivityIndicator()
          : FittedBox(
              child: Text(
              widget.message,
              style: semiboldwhite,
            )),
    );
  }
}

class SignupPage extends StatefulWidget {
  const SignupPage({super.key});

  @override
  State<SignupPage> createState() => _SignupPageState();
}

class _SignupPageState extends State<SignupPage> {
  final _usernameController = TextEditingController();
  final _registrationNumberController = TextEditingController();
  final _emailController = TextEditingController();
  final _passwordController = TextEditingController();
  final _confirmPasswordController = TextEditingController();
  final _formKey = GlobalKey<FormState>();

  bool _obscurepasswordText = true;
  bool _obscureconfirmpasswordText = true;

  _verifyEmail() async {
    if (_formKey.currentState?.validate() ?? false) {
      var rng = Random();
      int otp = rng.nextInt(9000) + 1000;
     
      showMessage(context, 'OTP has been sent! Please check your email.');

      Navigator.of(context).push(
        MaterialPageRoute(
          builder: (context) => OtpVerificationPage(
            onSuccess: _register,
            otp: otp,
            goRouteRouteName: '/login',
          ),
        ),
      );
    }
  }

  Future<void> _register() async {
    if (_formKey.currentState?.validate() ?? false) {
      showMessage(context,
          'Registration successful! Please login with your credentials!');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: SingleChildScrollView(
          padding: const EdgeInsets.all(5.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              FadeInAnimation(
                delay: 0.6,
                child: IconButton(
                  onPressed: () {
                    GoRouter.of(context).pop();
                  },
                  icon: const Icon(
                    CupertinoIcons.back,
                    size: 35,
                  ),
                ),
              ),
              Padding(
                padding: const EdgeInsets.all(12.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    FadeInAnimation(
                      delay: 1.3,
                      child: Text(
                        " Register",
                        style: titleTheme.copyWith(
                          color: const Color(0xFF731C65),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
              Padding(
                padding: const EdgeInsets.all(25.0),
                child: Form(
                  key: _formKey,
                  child: Column(
                    children: [
                      FadeInAnimation(
                        delay: 1.5,
                        child: CustomTextFormField(
                          controller: _registrationNumberController,
                          hinttext: 'Registration Number',
                          obsecuretext: false,
                          validator: (value) {
                            if (value == null || value.isEmpty) {
                              return 'Please enter your Reg.Number';
                            }
                            return null;
                          },
                        ),
                      ),
                      const SizedBox(height: 5),
                      FadeInAnimation(
                        delay: 1.5,
                        child: CustomTextFormField(
                          controller: _usernameController,
                          hinttext: 'Username',
                          obsecuretext: false,
                          validator: (value) {
                            if (value == null || value.isEmpty) {
                              return 'Please enter your username';
                            }
                            return null;
                          },
                        ),
                      ),
                      const SizedBox(height: 5),
                      FadeInAnimation(
                        delay: 1.8,
                        child: CustomTextFormField(
                          controller: _emailController,
                          hinttext: 'Email',
                          obsecuretext: false,
                          validator: (value) {
                            String trimmedValue = value?.trim() ?? '';
                            if (trimmedValue.isEmpty) {
                              return 'Please enter your email';
                            }

                            final emailRegExp = RegExp(
                              r'^[a-zA-Z0-9._%+-]+@[a-zA-Z0-9.-]+\.[a-zA-Z]{2,}$',
                              caseSensitive: false,
                              multiLine: false,
                            );

                            if (!emailRegExp.hasMatch(trimmedValue)) {
                              return 'Please enter a valid email';
                            }

                            return null;
                          },
                        ),
                      ),
                      const SizedBox(height: 5),
                      FadeInAnimation(
                        delay: 2.2,
                        child: TextFormField(
                          enableInteractiveSelection: false,
                          controller: _passwordController,
                          obscureText: _obscurepasswordText,
                          decoration: InputDecoration(
                            contentPadding: const EdgeInsets.all(18),
                            hintText: "Password",
                            hintStyle: hinttext,
                            border: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(18),
                                borderSide: BorderSide.none),
                            fillColor: const Color(0xFF731C65).withOpacity(0.1),
                            filled: true,
                            focusedBorder: OutlineInputBorder(
                              borderSide: const BorderSide(
                                  color: const Color(0xFF731C65), width: 2.0),
                              borderRadius: BorderRadius.circular(12),
                            ),
                            suffixIcon: IconButton(
                              onPressed: () {
                                setState(() {
                                  _obscurepasswordText = !_obscurepasswordText;
                                });
                              },
                              icon: Icon(
                                _obscurepasswordText
                                    ? Icons.visibility_off
                                    : Icons.visibility,
                                color: const Color(0xFF731C65),
                              ),
                            ),
                          ),
                          validator: (value) {
                            if (value == null || value.isEmpty) {
                              return 'Please enter a password';
                            }
                            return null;
                          },
                        ),
                      ),
                      const SizedBox(height: 5),
                      FadeInAnimation(
                        delay: 2.5,
                        child: TextFormField(
                          enableInteractiveSelection: false,
                          controller: _confirmPasswordController,
                          obscureText: _obscureconfirmpasswordText,
                          decoration: InputDecoration(
                            contentPadding: const EdgeInsets.all(18),
                            hintText: "Confirm Password",
                            hintStyle: hinttext,
                            border: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(18),
                                borderSide: BorderSide.none),
                            fillColor: const Color(0xFF731C65).withOpacity(0.1),
                            filled: true,
                            focusedBorder: OutlineInputBorder(
                              borderSide: const BorderSide(
                                  color: const Color(0xFF731C65), width: 2.0),
                              borderRadius: BorderRadius.circular(12),
                            ),
                            suffixIcon: IconButton(
                              onPressed: () {
                                setState(() {
                                  _obscureconfirmpasswordText =
                                      !_obscureconfirmpasswordText;
                                });
                              },
                              icon: Icon(
                                _obscureconfirmpasswordText
                                    ? Icons.visibility_off
                                    : Icons.visibility,
                                color: const Color(0xFF731C65),
                              ),
                            ),
                          ),
                          validator: (value) {
                            if (value == null || value.isEmpty) {
                              return 'Please confirm your password';
                            }
                            if (value != _passwordController.text) {
                              return 'Passwords do not match';
                            }
                            return null;
                          },
                        ),
                      ),
                      const SizedBox(height: 20),
                      FadeInAnimation(
                        delay: 2.7,
                        child: CustomElevatedButton(
                          message: "Register",
                          function: _verifyEmail,
                          color: Color(0xFF0660c3),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
              const SizedBox(height: 70),
              FadeInAnimation(
                delay: 3.6,
                child: Padding(
                  padding: const EdgeInsets.only(left: 50),
                  child: Row(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      Text(
                        "Already have an account?",
                        style: hinttext,
                      ),
                      TextButton(
                        onPressed: () {
                          GoRouter.of(context)
                              .pushNamed(Routers.loginpage.name);
                        },
                        child: Text(
                          "Login Now",
                          style: mediumTheme.copyWith(
                            color: Color(0xFF3831ee),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
