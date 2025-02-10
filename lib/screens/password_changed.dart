import 'package:go_router/go_router.dart';
import 'package:authentication_ui/router/router.dart';
import 'package:authentication_ui/screens/fade_animationtest.dart';
import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';
import 'dart:async';
import 'package:flutter/cupertino.dart';
import 'package:authentication_ui/utils/text_styles.dart';

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
         
          await widget.function();
                } catch (e) {
          print("Error executing function: $e");
        }

        setState(() {
          loading = false;
        });
      },
      style: ButtonStyle(
        shape: WidgetStatePropertyAll(
            RoundedRectangleBorder(borderRadius: BorderRadius.circular(10))),
        fixedSize: const WidgetStatePropertyAll(Size.fromWidth(300)),
        padding:
            const WidgetStatePropertyAll(EdgeInsets.symmetric(vertical: 15)),
        backgroundColor: const WidgetStatePropertyAll(Color(0xFF731C65)),
      ),
      child: loading
          ? const CupertinoActivityIndicator()
          : FittedBox(
              child: Text(
                widget.message,
                style: semiboldwhite,
              ),
            ),
    );
  }
}

class PasswordChangesPage extends StatefulWidget {
  const PasswordChangesPage({super.key});

  @override
  State<PasswordChangesPage> createState() => _PasswordChangesPageState();
}

class _PasswordChangesPageState extends State<PasswordChangesPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Column(
          children: [
            LottieBuilder.asset("assets/images/ticker.json"),
            FadeInAnimation(
              delay: 1,
              child: Text(
                "Password Changed!",
                style: titleTheme,
              ),
            ),
            FadeInAnimation(
              delay: 1,
              child: Text(
                "Your password has been changed successfully",
                style: mediumThemeblack,
              ),
            ),
            const SizedBox(height: 30),
            FadeInAnimation(
              delay: 2,
              child: CustomElevatedButton(
                message: "Back to Login",
                function: () {
                  GoRouter.of(context).pushReplacement(Routers.loginpage.name);
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}
