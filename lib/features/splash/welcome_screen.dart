import 'package:flutter/material.dart';

import '../../core/theme/app_colors.dart';
import '../../core/theme/text_styles.dart';
import '../authentication/login_screen.dart';

class WelcomeScreen extends StatelessWidget {
  const WelcomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.background,

      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 28),
          child: Column(
            children: [

              const Spacer(),

              // Swayyam Logo
              Image.asset(
                'assets/images/swayyam_logo.png',
                height: 90,
              ),

              const SizedBox(height: 18),

              Text(
                'SWAYYAM EDUCATION FOUNDATION',
                style: AppTextStyles.textTheme.titleLarge,
                textAlign: TextAlign.center,
              ),

              const SizedBox(height: 8),

              Text(
                'Curiosity Meets Opportunity',
                style: AppTextStyles.textTheme.bodyMedium?.copyWith(
                  color: AppColors.swayyamBlue,
                ),
              ),

              const SizedBox(height: 45),

              // Cubs Logo
              Image.asset(
                'assets/images/cubs_corner_logo.png',
                height: 140,
              ),

              const SizedBox(height: 25),

              Text(
                'Cubs Corner Connect',
                style: AppTextStyles.textTheme.headlineMedium,
                textAlign: TextAlign.center,
              ),

              const SizedBox(height: 14),

              Text(
                'A trusted companion for your\nchild\'s learning journey.',
                textAlign: TextAlign.center,
                style: AppTextStyles.textTheme.bodyMedium,
              ),

              const Spacer(),

              SizedBox(
                width: double.infinity,
                child: ElevatedButton(
                  onPressed: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (_) => const LoginScreen(),
                      ),
                    );
                  },
                  child: const Padding(
                    padding: EdgeInsets.symmetric(vertical: 16),
                    child: Text('Parent Login'),
                  ),
                ),
              ),

              const SizedBox(height: 18),

              TextButton(
                onPressed: () {
                  // About Swayyam screen later
                },
                child: Text(
                  'Learn about Swayyam',
                  style: AppTextStyles.textTheme.bodyMedium?.copyWith(
                    color: AppColors.swayyamBlue,
                    fontWeight: FontWeight.w600,
                  ),
                ),
              ),

              const SizedBox(height: 25),
            ],
          ),
        ),
      ),
    );
  }
}