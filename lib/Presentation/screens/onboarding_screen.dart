import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:smooth_page_indicator/smooth_page_indicator.dart';
import 'package:weather_pro/Data/Model/onboarding_items.dart';
import 'package:weather_pro/Presentation/screens/location_screen.dart';

class OnBoradingScreen extends StatefulWidget {
  const OnBoradingScreen({super.key});

  @override
  State<OnBoradingScreen> createState() => _OnBoradingScreenState();
}

class _OnBoradingScreenState extends State<OnBoradingScreen> {
  final controller = OnboardingItems();
  final pageController = PageController();

  bool isLastPage = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      bottomSheet: Container(
        color: Colors.white,
        padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 10),
        child: isLastPage ? getStarted() : Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [

            // Skip Button
            TextButton(
                onPressed: () => pageController.jumpToPage(controller.items.length - 1),
                child: const Text("Skip")),

            // Indicator
            SmoothPageIndicator(
              controller: pageController,
              count: controller.items.length,
              onDotClicked: (index) => pageController.animateToPage(index,
                  duration: const Duration(milliseconds: 600), curve: Curves.easeIn),
              effect: const WormEffect(
                dotHeight: 12,
                dotWidth: 12,
                activeDotColor: Color.fromARGB(255, 12, 66, 172),
              ),
            ),

            // Next Button
            TextButton(
                onPressed: () => pageController.nextPage(
                    duration: const Duration(milliseconds: 600), curve: Curves.easeIn),
                child: const Text("Next")),
          ],
        ),
      ),
      body: Container(
        margin: const EdgeInsets.symmetric(horizontal: 15),
        child: PageView.builder(
          onPageChanged: (index) => setState(() => isLastPage = controller.items.length - 1 == index),
          itemCount: controller.items.length,
          controller: pageController,
          itemBuilder: (context, index) {
            final onboardingInfo = controller.items[index];
            return Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                // Wrapping the image in a Flexible widget to prevent overflow
                Flexible(
                  child: Image.asset(
                    onboardingInfo.image,
                    width: onboardingInfo.width,  // Use custom width
                    height: onboardingInfo.height,  // Use custom height
                    fit: BoxFit.contain,
                  ),
                ),
                const SizedBox(height: 15),
                Text(
                  onboardingInfo.title,
                  style: const TextStyle(fontSize: 30, fontWeight: FontWeight.bold),
                ),
                const SizedBox(height: 15),
                Text(
                  onboardingInfo.descriptions,
                  style: const TextStyle(color: Colors.grey, fontSize: 17),
                  textAlign: TextAlign.center,
                ),
              ],
            );
          },
        ),
      ),
    );
  }

  // Get started button
  Widget getStarted() {
    return Container(
      margin: const EdgeInsets.only(bottom: 20,left: 20,right: 20),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(8),
      ),
      width: MediaQuery.of(context).size.width * .9,
      height: 55,
      child: TextButton(
        style: ButtonStyle(
          backgroundColor: WidgetStateProperty.all<Color>(const Color.fromARGB(255, 12, 66, 172)),
        ),
        onPressed: () async {
          final pres = await SharedPreferences.getInstance();
          pres.setBool("onboarding", false);

          if (!mounted) return;
          Navigator.pushReplacement(context, MaterialPageRoute(builder: (context) => const LocationScreen()));
        },
        child: const Text("Get started", style: TextStyle(color: Colors.white)),
      ),
    );
  }
}
