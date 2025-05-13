import 'package:bali_baci_order/utils/color_utils.dart';
import 'package:bali_baci_order/widgets/bottom_naviagtion.dart';
import 'package:bali_baci_order/widgets/input_field.dart';
import 'package:flutter/material.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({super.key});

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  final TextEditingController emailController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: SingleChildScrollView(
        padding: const EdgeInsets.symmetric(horizontal: 15),
        child: ConstrainedBox(
          constraints: BoxConstraints(
            minHeight: MediaQuery.of(context).size.height,
          ),
          child: IntrinsicHeight(
            child: SafeArea(
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 15),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const SizedBox(height: 32),
                    Image.asset(
                      "assets/icon/bali-baci-logo.png",
                      height: 60,
                    ),
                    const SizedBox(height: 40),
                    const Text(
                      "Let's Sign In 👋",
                      style: TextStyle(
                        fontSize: 32,
                        fontWeight: FontWeight.bold,
                        color: Color(0xFF260D01),
                      ),
                    ),
                    const SizedBox(height: 8),
                    const Text(
                      "Welcome back, you've been missed!",
                      style: TextStyle(fontSize: 16, color: Colors.grey),
                    ),
                    const SizedBox(height: 32),
                    InputField(label: "Email", controller: emailController, keyboardType: TextInputType.emailAddress,),
                    const SizedBox(height: 20),
                    InputField(label: "Password", controller: passwordController, obscureText: true,),
                    const SizedBox(height: 32),
                    Center(
                      child: ElevatedButton(
                        onPressed: () {
                          // TODO: Implement login logic
                          print("Login clicked");
                          Navigator.pushReplacement(
                            context,
                            MaterialPageRoute(
                                builder: (context) => BottomNavigation(initialIndex: 0,)),
                          );
                        },
                        style: ElevatedButton.styleFrom(
                          backgroundColor: AppColors.darkGrey,
                          padding: const EdgeInsets.symmetric(
                              horizontal: 100, vertical: 16),
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(12),
                          ),
                        ),
                        child: const Text(
                          "Login",
                          style: TextStyle(
                              color: Colors.white,
                              fontSize: 18,
                              fontWeight: FontWeight.bold),
                        ),
                      ),
                    ),
                    const Spacer(),
                    Center(
                      child: const Text(
                        "Bali Baci Admin Mobile",
                        style: TextStyle(color: Colors.grey),
                      ),
                    ),
                    const SizedBox(height: 16),
                  ],
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}

