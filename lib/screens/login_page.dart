import 'dart:async';

import 'package:flutter/cupertino.dart'; 
import 'package:flutter/material.dart'; 
import 'package:go_router/go_router.dart'; 
import 'package:authentication_ui/router/router.dart'; 
import 'package:authentication_ui/screens/fade_animationtest.dart'; 
import 'package:authentication_ui/utils/text_styles.dart'; 
import 'package:authentication_ui/utils/utils.dart'; 
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
autocorrect: false, 
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
 
class LoginPage extends StatefulWidget { 
  const LoginPage({super.key}); 
 
  @override 
  State<LoginPage> createState() => _LoginPageState(); 
} 
 
class _LoginPageState extends State<LoginPage> { 
  final _emailController = TextEditingController(); 
  final _passwordController = TextEditingController(); 
  final _formKey = GlobalKey<FormState>(); 
  bool _obscureText = true; 
 
  void _login(context) { 
    if (_formKey.currentState?.validate() ?? false) { 
      String email = _emailController.text.trim(); 
      String password = _passwordController.text.trim(); 
 
      if (email == "test@example.com" && password == "password") { 
      } else { 
        showMessage(context, 'Invalid email or password'); 
      } 
    } 
  } 
 
  @override 
  Widget build(BuildContext context) { 
    return Scaffold( 
      body: SafeArea( 
        child: SingleChildScrollView( 
          child: Padding( 
            padding: const EdgeInsets.all(10.0), 
            child: Column( 
              crossAxisAlignment: CrossAxisAlignment.start, 
              mainAxisAlignment: MainAxisAlignment.start, 
              children: [ 
                FadeInAnimation( 
                  delay: 1, 
                  child: IconButton( 
                    onPressed: () { 
                      GoRouter.of(context) 
                          .pushNamed(Routers.authenticationpage.name); 
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
                          "Welcome back", 
                          style: titleTheme.copyWith( 
                            color: const Color(0xFF731C65), 
                          ), 
                        ), 
                      ), 
                      FadeInAnimation( 
                        delay: 1.3, 
                        child: Text( 
                          "   Enter your credentials to login", 
                          style: hinttext, 
                        ), 
                      ), 
                    ], 
                  ), 
                ), 
                const SizedBox(height: 10), 
                Padding( 
                  padding: const EdgeInsets.all(25.0), 
                  child: Form( 
                    key: _formKey, 
                    child: Column( 
                      children: [ 
                        FadeInAnimation( 
                          delay: 1.5, 
                          child: CustomTextFormField( 
                            controller: _emailController, 
                            hinttext: 'Enter your Email', 
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
                        const SizedBox(height: 25), 
                        FadeInAnimation( 
                          delay: 2.2, 
                          child: TextFormField( 
                            controller: _passwordController, 
                            obscureText: _obscureText, 
                            decoration: InputDecoration( 
                              contentPadding: const EdgeInsets.all(18), 
                              hintText: "Enter your Password", 
                              hintStyle: hinttext, 
                              border: OutlineInputBorder( 
                                  borderRadius: BorderRadius.circular(18), 
                                  borderSide: BorderSide.none), 
                              fillColor: 
                                  const Color(0xFF731C65).withOpacity(0.1), 
                              filled: true, 
                              focusedBorder: OutlineInputBorder( 
                                borderSide: const BorderSide( 
                                    color: const Color(0xFF731C65), width: 2.0), 
                                borderRadius: BorderRadius.circular(12), 
                              ), 
                              suffixIcon: IconButton( 
                                onPressed: () { 
                                  setState(() { 
                                    _obscureText = !_obscureText; 
                                  }); 
                                }, 
                                icon: Icon( 
                                  _obscureText 
                                      ? Icons.visibility_off 
                                      : Icons.visibility, 
                                  color: const Color(0xFF731C65), 
                                ), 
                              ), 
                            ), 
                            validator: (value) { 
                              if (value == null || value.isEmpty) { 
                                return 'Please enter your password'; 
                              } 
                              return null; 
                            }, 
                          ), 
                        ), 
                        const SizedBox(height: 25), 
                        FadeInAnimation( 
                          delay: 2.5, 
                          child: Align( 
                            alignment: Alignment.centerRight, 
                            child: GestureDetector( 
                              onTap: () { 
                                GoRouter.of(context) 
                                    .pushNamed(Routers.forgetpassword.name); 
                              }, 
                              child: const Text( 
                                "Forgot Password?", 
                                style: TextStyle( 
                                  fontSize: 15, 
                                  fontWeight: FontWeight.w700, 
                                  fontFamily: "Urbanist-SemiBold", 
                                  color: Color(0xFF3831ee), 
                                ), 
                              ), 
                            ), 
                          ), 
                        ), 
                        const SizedBox(height: 50), 
                        FadeInAnimation( 
                          delay: 2.8, 
                          child: CustomElevatedButton( 
                            message: "Login", 
                            function: () { 
                              _login(context); 
                            }, 
                          ), 
                        ), 
                      ], 
                    ), 
                  ), 
                ), 
                const SizedBox(height: 100), 
                FadeInAnimation( 
                  delay: 2.8, 
                  child: Padding( 
                    padding: const EdgeInsets.only(left: 50), 
                    child: Row( 
                      crossAxisAlignment: CrossAxisAlignment.center, 
                      children: [ 
                        Text( 
                          "Don’t have an account?", 
                          style: hinttext, 
                        ), 
                        TextButton( 
                          onPressed: () { 
                            GoRouter.of(context) 
                                .pushNamed(Routers.signuppage.name); 
                          }, 
                          child: Text("Register Now", 
                              style: mediumTheme.copyWith( 
                                color: Color(0xFF3831ee), 
                              )), 
                        ) 
                      ], 
                    ), 
                  ), 
                ) 
              ], 
            ), 
          ), 
        ), 
      ), 
    ); 
  } 
} 