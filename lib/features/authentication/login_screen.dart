import 'package:flutter/material.dart';

import '../../core/theme/app_colors.dart';
import '../../core/theme/text_styles.dart';
import 'otp_screen.dart';

class LoginScreen extends StatelessWidget {
  const LoginScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.background,

      appBar: AppBar(
        title: const Text('Parent Login'),
        centerTitle: true,
      ),

      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(24),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [

              const SizedBox(height: 20),

              Image.asset(
                'assets/images/cubs_corner_logo.png',
                height: 120,
              ),

              const SizedBox(height: 30),

              Text(
                'Welcome Back!',
                textAlign: TextAlign.center,
                style: AppTextStyles.textTheme.headlineMedium,
              ),

              const SizedBox(height: 10),

              Text(
                'Enter your registered mobile number',
                textAlign: TextAlign.center,
                style: AppTextStyles.textTheme.bodyMedium,
              ),

              const SizedBox(height: 40),

              TextField(
                keyboardType: TextInputType.phone,
                decoration: const InputDecoration(
                  labelText: 'Mobile Number',
                  prefixIcon: Icon(Icons.phone),
                ),
              ),

              const SizedBox(height: 30),

              ElevatedButton(
                onPressed: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (_) => const OtpScreen(),
                    ),
                  );
                },
                child: const Padding(
                  padding: EdgeInsets.symmetric(vertical: 16),
                  child: Text('Send OTP'),
                ),
              ),

            ],
          ),
        ),
      ),
    );
  }
}