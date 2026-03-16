import 'package:apu_assignment/core/theme/sizes.dart';
import 'package:apu_assignment/features/profile/presentation/widgets/contact_title.dart';
import 'package:apu_assignment/features/profile/presentation/widgets/faq_title.dart';
import 'package:apu_assignment/features/profile/presentation/widgets/info_card.dart';
import 'package:apu_assignment/features/profile/presentation/widgets/section_title.dart';
import 'package:flutter/material.dart';

class HelpSupportPage extends StatelessWidget{
  const HelpSupportPage({super.key});

  @override
  Widget build(BuildContext context) {
    final colorScheme = Theme.of(context).colorScheme;
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          'Help & Support',
        ),
        backgroundColor: Colors.transparent,
        elevation: 0,
        centerTitle: true,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back),
          onPressed: () => Navigator.pop(context),
        ),
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(kDefaultPadding),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // const SectionTitle(title: "Frequently Asked Questions"),
            // const SizedBox(height: 12),
            // const FaqTile(
            //   question: "How do I report an incident?",
            //   answer: "You can tap the 'Report Incident' button on your dashboard. Fill in the location, date, and description. You can choose to submit it entirely anonymously.",
            // ),
            // const FaqTile(
            //   question: "Is my report completely confidential?",
            //   answer: "Yes. Your safety and privacy are our top priorities. Reports are stored securely and only accessible by authorized counselors and administration.",
            // ),
            // const FaqTile(
            //   question: "How can I contact a counselor?",
            //   answer: "Tap the 'Get Help' or 'Counselor List' option on your dashboard. You can view available counselors and start a secure, private chat with them directly.",
            // ),
            // const FaqTile(
            //   question: "What happens after I submit a report?",
            //   answer: "Your report will be reviewed by the authorities. You can track the status of your report (Pending, In Progress, Completed) from your 'My Reports' tab.",
            // ),
            const SectionTitle(title: "Contact Us"),
            kGap16,
            ContactTile(
              icon: Icons.email_outlined,
              title: "Email Support",
              subtitle: "support@echoapp.com",
              onTap: () {},
            ),
            ContactTile(
              icon: Icons.phone_outlined,
              title: "Emergency Hotline",
              subtitle: "Call Campus Security",
              onTap: () {},
            ),
            ContactTile(
              icon: Icons.language_rounded,
              title: "Visit Website",
              subtitle: "www.echoapp.com",
              onTap: () {},
            ),
            const SectionTitle(title: "App Information"),
            kGap16,
            const InfoCard(label: "Version", value: "1.0.0 (Build 2026)"),
            const InfoCard(label: "Terms of Service", value: "Read our terms"),
            const InfoCard(label: "Privacy Policy", value: "Read our policy"),
            
            const SizedBox(height: 40),
            Center(
              child: Text(
                "© 2026 Echo App",
                style: TextStyle(
                  color: colorScheme.onSurfaceVariant,
                  fontSize: 12,
                ),
              ),
            ),
            const SizedBox(height: 20),
          ]
        ),
      ),
    );
  }
}