import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:project/utils/utils.dart';

class CreateAccountButton extends StatelessWidget {
  const CreateAccountButton({
    super.key,
    required this.text,
    required this.onPressed,
  });

  final String text;
  final VoidCallback onPressed;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: double.infinity,
      child: ElevatedButton(
        style: ElevatedButton.styleFrom(
          padding: AppSpacings.verticalMedium,
          backgroundColor: Colors.black,
        ),
        onPressed: onPressed,
        child: Text(
          text,
          style: Theme.of(context).textTheme.labelLarge?.copyWith(
            fontSize: 16,
            fontWeight: FontWeight.bold,
            color: Colors.white,
            fontFamily: GoogleFonts.roboto().fontFamily,
          ),
        ),
      ),
    );
  }
}