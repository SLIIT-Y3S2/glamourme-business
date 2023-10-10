import 'package:flutter/material.dart';
import 'package:glamourmebusiness/data/onboarding_data_set.dart';

class OnBoardingContent extends StatelessWidget {
  const OnBoardingContent({super.key, required this.currentIndex});

  final int currentIndex;

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      top: false,
      child: Stack(
        fit: StackFit.expand,
        children: [
          //Background Image
          Image.asset(
            onBoardingData[currentIndex].image,
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
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 40.0),
                child: Text(
                  onBoardingData[currentIndex].text,
                  style: Theme.of(context).textTheme.bodyLarge!.copyWith(
                        color: Theme.of(context).colorScheme.onPrimary,
                        fontSize: 33,
                        fontWeight: FontWeight.bold,
                        letterSpacing: 0.25,
                      ),
                  textAlign: TextAlign.start,
                ),
              ),
              const SizedBox(height: 50),
              const SizedBox(height: 150),
            ],
          ),
        ],
      ),
    );
  }
}
