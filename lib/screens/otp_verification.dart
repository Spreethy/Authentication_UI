import 'dart:async';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:pinput/pinput.dart';
import 'package:go_router/go_router.dart';
import 'package:authentication_ui/router/router.dart';
import 'package:authentication_ui/screens/fade_animationtest.dart';
import 'package:authentication_ui/utils/text_styles.dart';
import 'package:authentication_ui/utils/utils.dart';

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
          shape: WidgetStateProperty.all(
              RoundedRectangleBorder(borderRadius: BorderRadius.circular(10))),
          fixedSize: WidgetStateProperty.all(Size.fromWidth(300)),
          padding: WidgetStateProperty.all(
            EdgeInsets.symmetric(vertical: 15),
          ),
          backgroundColor: WidgetStateProperty.all(
            Color(0xFF731C65),
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

class OtpVerificationPage extends StatefulWidget {
  const OtpVerificationPage({
    super.key,
    this.onSuccess,
    this.otp,
    this.goRouteRouteName,
  });
  final Function? onSuccess;
  final int? otp;
  final String? goRouteRouteName;
  @override
  State<OtpVerificationPage> createState() => _OtpVerificationPageState();
}

class _OtpVerificationPageState extends State<OtpVerificationPage> {
  final TextEditingController _otpTextController = TextEditingController();
  void _verifyOTP() {
    if (_otpTextController.text.toString() == widget.otp.toString()) {
      widget.onSuccess!();
    } else {
      showMessage(context, 'Invalid OTP');
      return;
    }
    GoRouter.of(context)
        .pushNamed(widget.goRouteRouteName ?? Routers.newpassword.name);
  }

  @override
  Widget build(BuildContext context) {
    final defaultPinTheme = PinTheme(
      width: 56,
      height: 56,
      textStyle: const TextStyle(
          fontSize: 20, color: Colors.grey, fontWeight: FontWeight.w600),
      decoration: BoxDecoration(
        border: Border.all(color: const Color(0xFF731C65)),
        borderRadius: BorderRadius.circular(20),
      ),
    );

    final focusedPinTheme = defaultPinTheme.copyDecorationWith(
      border: Border.all(
        color: const Color(0xFF731C65),
        width: 2.0,
      ),
      borderRadius: BorderRadius.circular(8),
    );

    final submittedPinTheme = defaultPinTheme.copyWith(
      decoration: defaultPinTheme.decoration?.copyWith(
        color: const Color(0xFF731C65).withOpacity(0.1),
      ),
    );

    return Scaffold(
      body: SafeArea(
        child: SingleChildScrollView(
          padding: const EdgeInsets.all(10.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              FadeInAnimation(
                delay: 1,
                child: IconButton(
                    onPressed: () {
                      GoRouter.of(context).pop();
                    },
                    icon: const Icon(
                      CupertinoIcons.back,
                      size: 35,
                    )),
              ),
              Padding(
                padding: const EdgeInsets.all(12.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    FadeInAnimation(
                      delay: 1.3,
                      child: Text(
                        "OTP Verification",
                        style: titleTheme.copyWith(
                          color: const Color(0xFF731C65),
                        ),
                      ),
                    ),
                    FadeInAnimation(
                      delay: 1.6,
                      child: Text(
                        "Enter the verification code we just sent on your email address.",
                        style: mediumThemeblack,
                      ),
                    )
                  ],
                ),
              ),
              Padding(
                padding:
                    const EdgeInsets.symmetric(horizontal: 12.0, vertical: 50),
                child: Center(
                  child: Form(
                    child: Column(
                      children: [
                        FadeInAnimation(
                          delay: 1.9,
                          child: Pinput(
                            crossAxisAlignment: CrossAxisAlignment.center,
                            defaultPinTheme: defaultPinTheme,
                            focusedPinTheme: focusedPinTheme,
                            submittedPinTheme: submittedPinTheme,
                            validator: (s) {
                              return s == widget.otp.toString()
                                  ? null
                                  : 'Pin is incorrect';
                            },
                            pinputAutovalidateMode:
                                PinputAutovalidateMode.onSubmit,
                            showCursor: true,
                            onCompleted: (pin) {
                              _otpTextController.text = pin;
                            },
                          ),
                        ),
                        const SizedBox(
                          height: 50,
                        ),
                        FadeInAnimation(
                          delay: 2.1,
                          child: CustomElevatedButton(
                            message: "Verify",
                            //function: _verifyOTP,
                            function: () {
                              GoRouter.of(context)
                                  .pushNamed(Routers.newpassword.name);
                            },
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ),
              const SizedBox(height: 200),
              FadeInAnimation(
                delay: 2.4,
                child: Padding(
                  padding: const EdgeInsets.only(left: 50),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      Text(
                      "Didn't receive code?",
                        style: hinttext,
                      ),
                      TextButton(
                        onPressed: () {
                          // No backend action, just simulate resend
                          ScaffoldMessenger.of(context).showSnackBar(
                            const SnackBar(content: Text('Code Resent!')),
                          );
                        },
                        child: Text(
                          "Resend",
                          style: mediumTheme.copyWith(
                            color: Color(0xFF3831ee),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
              const SizedBox(height: 20),
            ],
          ),
        ),
      ),
    );
  }
}
