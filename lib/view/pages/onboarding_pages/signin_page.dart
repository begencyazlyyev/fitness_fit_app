import 'package:flutter/material.dart';
import 'package:flutter_application_1/components/button_widget.dart';
import 'package:flutter_application_1/components/google_sign_widget.dart';
import 'package:flutter_application_1/components/text_field_widget.dart';
import 'package:flutter_application_1/components/text_style_widget.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:gap/gap.dart';

class AccauntSignPage extends StatelessWidget {
  const AccauntSignPage({super.key});

  @override
  Widget build(BuildContext context) {
    final TextEditingController usernameController = TextEditingController();
    return Scaffold(
      appBar: AppBar(),
      body: SingleChildScrollView(
        child: GestureDetector(
          behavior: HitTestBehavior.opaque,
          onTap: () {
            FocusScope.of(context).unfocus();
          },
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              // Logo
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
                  "Hi, Welcome Back!",
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
                  "Hope you are doing fine",
                  style: TextStyle(color: Colors.grey[600], fontSize: 16),
                ),
              ),
              Gap(34),

              // Text Field starts here
              TextFieldWidget(
                labelText: "Your Email",
                icons: Icons.email_outlined,
                controller: usernameController,
              ),
              Gap(22),
              TextFieldWidget(
                labelText: "Password",
                icons: Icons.lock_outline,
                controller: usernameController,
              ),
              Gap(8),

              ButtonWidget(
                label: "Sign In",
                onPressed: () {
                  Navigator.pushNamed(context, '/');
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

              GoogleSignButton(onPressed: () {}),
              Center(
                child: TextButton(
                  onPressed: () {},
                  child: Text(
                    "Forgot password?",
                    style: TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.w500,
                      color: Colors.blue,
                    ),
                  ),
                ),
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    "Don't you have an account yet?",
                    style: TextStyle(fontSize: 16, color: Colors.grey[600]),
                  ),
                  TextButton(
                    onPressed: () {},
                    child: Text(
                      "Sign Up",
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
