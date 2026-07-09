import 'package:flutter/material.dart';

import '../../core/theme/app_colors.dart';
import '../../core/theme/text_styles.dart';

class OtpScreen extends StatelessWidget {
  const OtpScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.background,
      appBar: AppBar(
        title: const Text('OTP Verification'),
      ),
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 28),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              const SizedBox(height: 30),

              const Icon(
                Icons.verified_user_rounded,
                size: 80,
                color: AppColors.swayyamGreen,
              ),

              const SizedBox(height: 24),

              Text(
                'Verify your mobile number',
                style: AppTextStyles.textTheme.headlineMedium,
                textAlign: TextAlign.center,
              ),

              const SizedBox(height: 12),

              Text(
                'Enter the 6-digit verification code sent to your registered mobile number.',
                textAlign: TextAlign.center,
                style: AppTextStyles.textTheme.bodyMedium,
              ),

              const SizedBox(height: 40),

              TextField(
                keyboardType: TextInputType.number,
                textAlign: TextAlign.center,
                maxLength: 6,
                style: AppTextStyles.textTheme.headlineSmall,
                decoration: const InputDecoration(
                  hintText: '123456',
                  counterText: '',
                ),
              ),

              const SizedBox(height: 24),

              SizedBox(
                width: double.infinity,
                child: ElevatedButton(
                  onPressed: () {
                    // Dashboard comes next
                  },
                  child: const Padding(
                    padding: EdgeInsets.symmetric(vertical: 16),
                    child: Text('Verify OTP'),
                  ),
                ),
              ),

              const SizedBox(height: 16),

              TextButton(
                onPressed: () {},
                child: const Text("Resend Code"),
              ),
            ],
          ),
        ),
      ),
    );
  }
}