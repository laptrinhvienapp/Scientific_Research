import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class CustomShowDialog extends StatelessWidget {
  const CustomShowDialog({
    super.key,
    required this.title,
    required this.onConfirm,
    required this.onCancel,
    required this.titleConfirm,
    required this.titleCancel,
    required this.image,
  });

  final String title;
  final String titleConfirm;
  final String titleCancel;
  final VoidCallback onConfirm;
  final VoidCallback onCancel;
  final Image image;

  @override
  Widget build(BuildContext context) {
    final double screenWidth = MediaQuery.of(context).size.width;

    return Dialog(
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(15.0),
      ),
      elevation: 10,
      child: Container(
        width: screenWidth * 0.8,
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(15.0),
          boxShadow: [
            BoxShadow(
              color: Colors.black26,
              blurRadius: 10.0,
              offset: Offset(0, 4),
            ),
          ],
        ),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Container(
              padding: const EdgeInsets.symmetric(
                vertical: 12.0,
                horizontal: 10.0,
              ),
              decoration: const BoxDecoration(
                color: Colors.green,
                borderRadius: BorderRadius.only(
                  topLeft: Radius.circular(15.0),
                  topRight: Radius.circular(15.0),
                ),
              ),
              child: Center(
                child: Text(
                  title,
                  style: GoogleFonts.lobster(
                    fontSize: 24,
                    color: Colors.white,
                  ),
                ),
              ),
            ),
            // Nội dung với khả năng cuộn
            Flexible(
              child: SingleChildScrollView(
                child: Padding(
                  padding: const EdgeInsets.all(16.0),
                  child: image,
                ),
              ),
            ),
            Row(
              mainAxisSize: MainAxisSize.max,
              children: [
                Expanded(
                  child: ElevatedButton(
                    style: ElevatedButton.styleFrom(
                      padding: const EdgeInsets.all(15.0),
                      backgroundColor: Colors.blue,
                      foregroundColor: Colors.white,
                      shape: const RoundedRectangleBorder(
                        borderRadius: BorderRadius.only(
                          bottomLeft: Radius.circular(15.0),
                        ),
                      ),
                    ),
                    onPressed: onConfirm,
                    child: Text(
                      titleConfirm,
                      style: GoogleFonts.lobster(
                        fontSize: 14,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                ),
                Expanded(
                  child: ElevatedButton(
                    style: ElevatedButton.styleFrom(
                      padding: const EdgeInsets.all(15.0),
                      backgroundColor: Colors.grey,
                      foregroundColor: Colors.white,
                      shape: const RoundedRectangleBorder(
                        borderRadius: BorderRadius.only(
                          bottomRight: Radius.circular(15.0),
                        ),
                      ),
                    ),
                    onPressed: onCancel,
                    child: Text(
                      titleCancel,
                      style: GoogleFonts.lobster(
                        fontSize: 14,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}