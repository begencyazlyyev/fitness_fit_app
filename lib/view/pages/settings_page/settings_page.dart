// ignore_for_file: deprecated_member_use

import 'dart:io';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_application_1/cubit/user_cubit.dart';
import 'package:flutter_application_1/components/text_style_widget.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:gap/gap.dart';

class SettingsPage extends StatefulWidget {
  const SettingsPage({super.key});

  @override
  State<SettingsPage> createState() => _SettingsPageState();
}

class _SettingsPageState extends State<SettingsPage> {
  String _selectedLanguage = 'English';

  final List<String> _languages = ['English', 'Russian', 'Turkmen'];

  @override
  Widget build(BuildContext context) {
    final userState = context.watch<UserCubit>().state;
    final user = userState.users.isNotEmpty ? userState.users.last : null;

    return SingleChildScrollView(
      child: Column(
        children: [
          Container(
            margin: const EdgeInsets.only(top: 30, left: 20, right: 20),
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(20),
              color: Colors.white,
              boxShadow: [
                BoxShadow(
                  blurRadius: 2,
                  color: Colors.grey.shade300,
                  spreadRadius: 2,
                  offset: const Offset(0, 2),
                ),
              ],
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const Gap(20),

                // ── Profile Row ──────────────────────────────────────
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 20),
                  child: Row(
                    children: [
                      CircleAvatar(
                        radius: 36,
                        backgroundImage: user?.imagePath != null
                            ? FileImage(File(user!.imagePath!))
                            : const AssetImage("assets/images/profile.jpg")
                                  as ImageProvider,
                      ),
                      const Gap(16),
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            user != null
                                ? "${user.name} ${user.surname}"
                                : "Guest",
                            style: KTextStyle.fitStyle.copyWith(fontSize: 20),
                          ),
                          const Gap(4),
                          Text(
                            user?.email ?? "",
                            style: TextStyle(
                              fontSize: 13,
                              color: Colors.grey[500],
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
                const Gap(16),
                const Divider(thickness: 2, color: Color(0xFFE5E7EB)),
                const Gap(16),

                // ── Language Dropdown ────────────────────────────────
                Padding(
                  padding: const EdgeInsets.symmetric(
                    horizontal: 20,
                    vertical: 8,
                  ),
                  child: Text(
                    "Language",
                    style: KTextStyle.fitnessStyle.copyWith(
                      color: Colors.black,
                      fontSize: 16,
                    ),
                  ),
                ),
                const Gap(8),
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 20),
                  child: Container(
                    width: double.infinity,
                    padding: const EdgeInsets.symmetric(horizontal: 16),
                    decoration: BoxDecoration(
                      border: Border.all(color: const Color(0xFFE5E7EB)),
                      borderRadius: BorderRadius.circular(12),
                    ),
                    child: DropdownButtonHideUnderline(
                      child: DropdownButton<String>(
                        value: _selectedLanguage,
                        icon: const Icon(Icons.keyboard_arrow_down),
                        style: const TextStyle(
                          fontSize: 15,
                          color: Colors.black87,
                        ),
                        items: _languages.map((lang) {
                          return DropdownMenuItem(
                            value: lang,
                            child: Text(lang),
                          );
                        }).toList(),
                        onChanged: (val) {
                          if (val != null) {
                            setState(() => _selectedLanguage = val);
                          }
                        },
                      ),
                    ),
                  ),
                ),
                const Gap(25),
                const Divider(
                  indent: 30,
                  endIndent: 30,
                  thickness: 2,
                  color: Color(0xFFE5E7EB),
                ),
                const Gap(25),

                // ── Privacy Policy ───────────────────────────────────
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 8),
                  child: ListTile(
                    onTap: () => _openBottomSheet(
                      context,
                      "Privacy Policy",
                      _privacyPolicyText,
                    ),
                    leading: const Icon(
                      Icons.privacy_tip_outlined,
                      color: Colors.black87,
                    ),
                    title: const Text(
                      "Privacy Policy",
                      style: TextStyle(
                        fontSize: 18,
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                    trailing: const Icon(
                      Icons.arrow_forward_ios,
                      size: 16,
                      color: Colors.grey,
                    ),
                  ),
                ),

                // ── Terms and Conditions ─────────────────────────────
                Padding(
                  padding: const EdgeInsets.symmetric(
                    horizontal: 8,
                    vertical: 8,
                  ),
                  child: ListTile(
                    onTap: () => _openBottomSheet(
                      context,
                      "Terms and Conditions",
                      _termsText,
                    ),
                    leading: const Icon(
                      Icons.description_outlined,
                      color: Colors.black87,
                    ),
                    title: const Text(
                      "Terms and Conditions",
                      style: TextStyle(
                        fontSize: 18,
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                    trailing: const Icon(
                      Icons.arrow_forward_ios,
                      size: 16,
                      color: Colors.grey,
                    ),
                  ),
                ),
                const Gap(8),
                const Divider(
                  indent: 30,
                  endIndent: 30,
                  thickness: 2,
                  color: Color(0xFFE5E7EB),
                ),
                const Gap(40),

                // ── FitnessFit Logo ──────────────────────────────────
              ],
            ),
          ),
          const Gap(30),
          Center(
            child: SizedBox(
              width: 60,
              height: 60,
              child: SvgPicture.asset(
                'assets/svg/logo.svg',
                color: Colors.grey,
                fit: BoxFit.contain,
              ),
            ),
          ),
          const Gap(10),
          Center(
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text("Fitness", style: KTextStyle.fitnessStyle),
                Text("Fit", style: KTextStyle.fitStyle),
              ],
            ),
          ),
          const Gap(30),

          Center(
            child: Text(
              "All rıghts are reserved",
              style: TextStyle(fontSize: 14, color: Colors.grey),
            ),
          ),
          const Gap(16),

          Center(
            child: Text(
              "Copyright C 2026",
              style: TextStyle(fontSize: 14, color: Colors.black54),
            ),
          ),
        ],
      ),
    );
  }
}

// ── Bottom Sheet ───────────────────────────────────────────────
void _openBottomSheet(BuildContext context, String title, String content) {
  showModalBottomSheet(
    context: context,
    isScrollControlled: true,
    shape: const RoundedRectangleBorder(
      borderRadius: BorderRadius.vertical(top: Radius.circular(20)),
    ),
    builder: (_) => DraggableScrollableSheet(
      expand: false,
      initialChildSize: 0.75,
      maxChildSize: 0.95,
      minChildSize: 0.4,
      builder: (_, scrollController) => Column(
        children: [
          // Handle bar
          Container(
            margin: const EdgeInsets.symmetric(vertical: 12),
            width: 40,
            height: 4,
            decoration: BoxDecoration(
              color: Colors.grey[300],
              borderRadius: BorderRadius.circular(2),
            ),
          ),
          // Title
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 20),
            child: Text(
              title,
              style: KTextStyle.fitStyle.copyWith(fontSize: 18),
            ),
          ),
          const Gap(8),
          const Divider(color: Color(0xFFE5E7EB)),
          // Scrollable content
          Expanded(
            child: SingleChildScrollView(
              controller: scrollController,
              padding: const EdgeInsets.fromLTRB(20, 8, 20, 30),
              child: Text(
                content,
                style: const TextStyle(
                  fontSize: 14,
                  color: Colors.black87,
                  height: 1.7,
                ),
              ),
            ),
          ),
        ],
      ),
    ),
  );
}

// ── Text Templates ───────────────────────────────────────────
const String _privacyPolicyText = """
Privacy Policy

Last updated: January 1, 2025

1. Information We Collect
We collect information you provide directly to us when you create an account, such as your name, email address, date of birth, gender, and profile photo.

2. How We Use Your Information
We use the information we collect to provide, maintain, and improve our services, personalize your fitness experience, and communicate with you about updates.

3. Data Storage
Your personal data is stored securely on our servers. We implement appropriate technical and organizational measures to protect your information against unauthorized access.

4. Sharing of Information
We do not sell, trade, or otherwise transfer your personal information to third parties without your consent, except as described in this policy.

5. Your Rights
You have the right to access, correct, or delete your personal information at any time through your profile settings.

6. Changes to This Policy
We may update this Privacy Policy from time to time. We will notify you of any changes by posting the new policy on this page.

7. Contact Us
If you have any questions about this Privacy Policy, please contact us at support@fitnessfit.com.
""";

const String _termsText = """
Terms and Conditions

Last updated: January 1, 2025

1. Acceptance of Terms
By accessing and using FitnessFit, you accept and agree to be bound by the terms and conditions outlined here.

2. Use of the Application
FitnessFit is intended for personal, non-commercial use. You agree not to misuse the application or help anyone else do so.

3. User Accounts
You are responsible for maintaining the confidentiality of your account credentials and for all activities that occur under your account.

4. Health Disclaimer
FitnessFit provides fitness information for general wellness purposes only. Always consult a qualified healthcare professional before starting any new exercise program.

5. Intellectual Property
All content, features, and functionality of FitnessFit are owned by FitnessFit and are protected by applicable intellectual property laws.

6. Limitation of Liability
FitnessFit shall not be liable for any indirect, incidental, or consequential damages resulting from your use of the application.

7. Termination
We reserve the right to terminate or suspend your account at our discretion if you violate these terms.

8. Governing Law
These terms shall be governed by and construed in accordance with applicable laws.

9. Contact Us
For any questions regarding these Terms and Conditions, please contact us at support@fitnessfit.com.
""";
