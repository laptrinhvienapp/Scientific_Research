import 'package:flutter/material.dart';
import 'package:project/utils/utils.dart';
import 'package:url_launcher/url_launcher.dart';

class TermsAndConditions extends StatelessWidget {
  const TermsAndConditions({super.key});

  void _launchURL(String url) async {
    final Uri uri = Uri.parse(url);
    if (await canLaunchUrl(uri)) {
      await launchUrl(uri);
    } else {
      throw 'Could not launch $url';
    }
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Text(
          AppStrings.agreementMessage,
        ),
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            GestureDetector(
              onTap: () => _launchURL('https://policies.google.com/terms?hl=vi'),
              child: Text(
                AppStrings.termsOfService,
                style: TextStyle(
                  decoration: TextDecoration.underline,
                ),
              ),
            ),
            Padding(
              padding: AppSpacings.horizontalSmall,
              child: Text(
                AppStrings.orText,
              ),
            ),
            GestureDetector(
              onTap: () => _launchURL('https://policies.google.com/privacy?hl=vi'),
              child: Text(
                AppStrings.privacyPolicy,
                style: TextStyle(
                  decoration: TextDecoration.underline,
                ),
              ),
            ),
          ],
        ),
      ],
    );
  }
}