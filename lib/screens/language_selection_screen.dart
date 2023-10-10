import 'package:flutter/material.dart';
import 'package:glamourmebusiness/screens/onboarding_screen.dart';

class LanguageSelectionScreen extends StatelessWidget {
  const LanguageSelectionScreen({super.key});

  @override
  Widget build(BuildContext context) {
    void navigateToOnBoarding() {
      Navigator.of(context).push(
        MaterialPageRoute(
          builder: (context) => const OnBoardingScreen(),
        ),
      );
    }

    return Scaffold(
      body: SafeArea(
        top: false,
        child: Stack(
          fit: StackFit.expand,
          children: [
            //Background Image
            Image.asset(
              'assets/images/image 1.png',
              width: double.infinity,
              height: double.infinity,
              fit: BoxFit.cover,
            ),
            //Background Tint
            Container(
              color: Colors.black54,
            ),
            //Content
            Column(
              mainAxisAlignment: MainAxisAlignment.center,
              mainAxisSize: MainAxisSize.min,
              children: [
                const Spacer(),
                Text(
                  'Welcome to GlamourMe',
                  style: Theme.of(context).textTheme.bodyLarge!.copyWith(
                        color: Colors.white,
                        fontSize: 33,
                        fontWeight: FontWeight.bold,
                      ),
                ),
                const Spacer(),
                Text(
                  'Select Language',
                  style: Theme.of(context).textTheme.bodyLarge!.copyWith(
                        color: Colors.white,
                        fontSize: 33,
                        fontWeight: FontWeight.bold,
                      ),
                ),
                const SizedBox(height: 50),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    OutlinedButton(
                      onPressed: navigateToOnBoarding,
                      child: const Text('English'),
                    ),
                    const SizedBox(
                      width: 100,
                    ),
                    OutlinedButton(
                      onPressed: navigateToOnBoarding,
                      child: const Text('Sinhala'),
                    ),
                  ],
                ),
                const SizedBox(height: 50)
              ],
            ),
          ],
        ),
      ),
    );
  }
}
