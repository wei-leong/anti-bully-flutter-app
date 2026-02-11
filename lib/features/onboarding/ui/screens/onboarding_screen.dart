import 'package:apu_assignment/core/theme/sizes.dart';
import 'package:apu_assignment/features/auth/presentation/screens/auth_gate.dart';
import 'package:apu_assignment/features/onboarding/ui/widgets/dynamic_svg.dart';
import 'package:flutter/material.dart';
import 'package:smooth_page_indicator/smooth_page_indicator.dart';
import 'package:shared_preferences/shared_preferences.dart';

class OnboardingContent {
  final String image;
  final String title;
  final String subtitle;

  OnboardingContent({
    required this.image,
    required this.title,
    required this.subtitle,
  });
}

class OnboardingScreen extends StatefulWidget {
  const OnboardingScreen({super.key});

  @override
  State<OnboardingScreen> createState() => _OnboardingScreenState();
}

class _OnboardingScreenState extends State<OnboardingScreen> {
  final PageController _controller = PageController();
  bool _isLastPage = false;

  Future<void> _completeOnboarding() async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setBool('seenOnboarding', true);

    if (!mounted) return;
    // Navigate to AuthGate and Remove Onboarding Page to Free Up Space
    Navigator.pushReplacement(
      context,
      MaterialPageRoute(builder: (context) => AuthGate()),
    );
  }

  final List<OnboardingContent> _contents = [
    OnboardingContent(
      image: "assets/images/onboard_screen_1.svg",
      title: "Speak Up Safely",
      subtitle:
          "Report bullying incidents anonymously. Your identity is protected, and your voice matters.",
    ),
    OnboardingContent(
      image: "assets/images/onboard_screen_2.svg",
      title: "Expert Guidance",
      subtitle:
          "Connect directly with school counselors and get the support you need.",
    ),
    OnboardingContent(
      image: "assets/images/onboard_screen_3.svg",
      title: "Empower Yourself",
      subtitle:
          "Access a library of resources to help you navigate difficult situations.",
    ),
  ];

  @override
  Widget build(BuildContext context) {
    final colorScheme = Theme.of(context).colorScheme;
    final textTheme = Theme.of(context).textTheme;
    return Scaffold(
      body: SafeArea(
        child: Column(
          children: [
            Align(
              alignment: Alignment.topRight,
              child: TextButton(
                onPressed: _completeOnboarding,
                child: Text("Skip"),
              ),
            ),
            Expanded(
              child: PageView.builder(
                controller: _controller,
                itemCount: _contents.length,
                onPageChanged: (index) {
                  setState(() {
                    _isLastPage = index == _contents.length - 1;
                  });
                },
                itemBuilder: (context, index) {
                  return Padding(
                    padding: const EdgeInsets.all(kOnboardContentPadding),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Expanded(
                          flex: 3,
                          child: DynamicSvg(
                            path: _contents[index].image,
                            replaceColorHex: '#92E3A9',
                          ),
                        ),
                        Text(
                          _contents[index].title,
                          style: textTheme.headlineMedium?.copyWith(
                            fontWeight: FontWeight.bold,
                            color: colorScheme.onSurface,
                          ),
                        ),
                        const SizedBox(height: 16),
                        Text(
                          _contents[index].subtitle,
                          textAlign: TextAlign.center,
                          style: textTheme.bodyLarge?.copyWith(
                            color: colorScheme.onSurfaceVariant,
                          ),
                        ),
                      ],
                    ),
                  );
                },
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(kDefaultPadding),
              child: Column(
                children: [
                  SmoothPageIndicator(
                    controller: _controller,
                    count: _contents.length,
                    effect: ExpandingDotsEffect(
                      activeDotColor: colorScheme.primary,
                      dotColor: colorScheme.surfaceContainerHighest,
                      dotHeight: 8,
                      dotWidth: 8,
                    ),
                  ),
                  kGap8,
                  SizedBox(
                    width: double.infinity,
                    height: 50,
                    child: TextButton(
                      onPressed: () {
                        _controller.previousPage(
                          duration: const Duration(milliseconds: 300),
                          curve: Curves.easeInOut,
                        );
                      },
                      child: Text("Prev"),
                    ),
                  ),
                  kGap8,
                  // Dot Indicator
                  SizedBox(
                    width: double.infinity,
                    height: 50,
                    child: FilledButton(
                      onPressed: () {
                        if (_isLastPage) {
                          _completeOnboarding();
                        } else {
                          _controller.nextPage(
                            duration: const Duration(milliseconds: 300),
                            curve: Curves.easeInOut,
                          );
                        }
                      },
                      child: Text(_isLastPage ? "Get Started" : "Next"),
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
