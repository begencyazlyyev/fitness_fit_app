import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart'; // ← add
import 'package:flutter_application_1/components/button_widget.dart';
import 'package:flutter_application_1/components/google_button.dart';
import 'package:flutter_application_1/components/text_field_widget.dart';
import 'package:flutter_application_1/components/text_style_widget.dart';
import 'package:flutter_application_1/cubit/user_cubit.dart'; // ← add
import 'package:flutter_svg/flutter_svg.dart';
import 'package:gap/gap.dart';

class CreateAccaunt extends StatefulWidget {
  // ← StatelessWidget → StatefulWidget
  const CreateAccaunt({super.key});

  @override
  State<CreateAccaunt> createState() => _CreateAccauntState();
}

class _CreateAccauntState extends State<CreateAccaunt> {
  final TextEditingController usernameController =
      TextEditingController(); // ← separate controllers
  final TextEditingController emailController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();

  @override
  void dispose() {
    usernameController.dispose();
    emailController.dispose();
    passwordController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      body: SingleChildScrollView(
        child: GestureDetector(
          behavior: HitTestBehavior.opaque,
          onTap: () => FocusScope.of(context).unfocus(),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              Center(
                child: SizedBox(
                  width: 70,
                  height: 70,
                  child: SvgPicture.asset(
                    'assets/svg/logo.svg',
                    fit: BoxFit.contain,
                  ),
                ),
              ),
              Gap(15),
              Center(
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text("Fitness", style: KTextStyle.fitnessStyle),
                    Text("Fit", style: KTextStyle.fitStyle),
                  ],
                ),
              ),
              Gap(30),
              Center(
                child: Text(
                  "Create Account",
                  style: TextStyle(
                    fontSize: 24,
                    color: Color(0xFF111928),
                    fontWeight: FontWeight.w600,
                  ),
                ),
              ),
              Gap(10),
              Center(
                child: Text(
                  "We are here to help you!",
                  style: TextStyle(color: Colors.grey[600], fontSize: 16),
                ),
              ),
              Gap(34),
              TextFieldWidget(
                labelText: "Username",
                icons: Icons.person_outline,
                controller: usernameController, // ← correct controller
              ),
              Gap(22),
              TextFieldWidget(
                labelText: "Your Email",
                icons: Icons.email_outlined,
                controller: emailController, // ← correct controller
              ),
              Gap(22),
              TextFieldWidget(
                labelText: "Password",
                icons: Icons.lock_outline,
                controller: passwordController, // ← correct controller
              ),
              Gap(8),
              ButtonWidget(
                label: "Create Account",
                onPressed: () {
                  if (emailController.text.isEmpty ||
                      passwordController.text.isEmpty) {
                    ScaffoldMessenger.of(context).showSnackBar(
                      SnackBar(
                        content: Text(
                          emailController.text.isEmpty
                              ? "Please enter your email address."
                              : "Please enter a password.",
                          style: const TextStyle(color: Colors.white),
                        ),
                        backgroundColor: const Color(0xFFE74C3C),
                        behavior: SnackBarBehavior.floating,
                        duration: const Duration(seconds: 2),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(10),
                        ),
                      ),
                    );
                    return;
                  }
                  context.read<UserCubit>().setCredentials(
                    email: emailController.text.trim(),
                    password: passwordController.text,
                  );
                  Navigator.pushNamed(context, '/user_details');
                },
              ),
              Row(
                children: <Widget>[
                  Expanded(
                    child: Divider(
                      indent: 24,
                      endIndent: 24,
                      thickness: 2,
                      color: Colors.grey.shade300,
                    ),
                  ),
                  Text(
                    "or",
                    style: TextStyle(fontSize: 18, color: Colors.grey[600]),
                  ),
                  Expanded(
                    child: Divider(
                      indent: 24,
                      endIndent: 24,
                      thickness: 2,
                      color: Colors.grey.shade300,
                    ),
                  ),
                ],
              ),
              GoogleButton(onPressed: () {}),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    "Do you have an account?",
                    style: TextStyle(fontSize: 16, color: Colors.grey[600]),
                  ),
                  TextButton(
                    onPressed: () {
                      Navigator.pushNamed(context, '/signing_page');
                    },
                    child: Text(
                      "Sign In",
                      style: TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.w500,
                        color: Colors.blue,
                      ),
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
