import 'dart:async';

import 'package:flutter/material.dart';

import '../../core/theme/app_colors.dart';
import '../../core/theme/text_styles.dart';
import 'welcome_screen.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {

  double opacity = 0;

  @override
  void initState() {
    super.initState();

    Future.delayed(const Duration(milliseconds: 300), () {
      setState(() {
        opacity = 1;
      });
    });

    Timer(
      const Duration(seconds: 3),
          () {
        Navigator.pushReplacement(
          context,
          MaterialPageRoute(
            builder: (_) => const WelcomeScreen(),
          ),
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {

    return Scaffold(
      backgroundColor: AppColors.background,

      body: Center(
        child: AnimatedOpacity(
          duration: const Duration(milliseconds: 1200),
          opacity: opacity,

          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,

            children: [

              Image.asset(
                'assets/images/swayyam_logo.png',
                height: 130,
              ),

              const SizedBox(height: 30),

              Text(
                'SWAYYAM EDUCATION FOUNDATION',
                style: AppTextStyles.textTheme.titleLarge,
                textAlign: TextAlign.center,
              ),

              const SizedBox(height: 50),

              Image.asset(
                'assets/images/cubs_corner_logo.png',
                height: 140,
              ),

              const SizedBox(height: 20),

              Text(
                'Cubs Corner Connect',
                style: AppTextStyles.textTheme.headlineMedium,
              ),

              const SizedBox(height: 12),

              Text(
                'Every Smile. Every Step. Every Day.',
                style: AppTextStyles.textTheme.bodyMedium,
              ),
            ],
          ),
        ),
      ),
    );
  }
}