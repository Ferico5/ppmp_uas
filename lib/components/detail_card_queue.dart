import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import '../components/my_button.dart';
// Removed import '../flutter_flow/flutter_flow_theme.dart';

class DetailCardQueue extends StatelessWidget {
  final String patientName;
  final String queueNumber;
  final String text;
  final String buttonText;
  final VoidCallback onPressed;
  final int animationIndex;

  const DetailCardQueue({
    super.key,
    required this.patientName,
    required this.queueNumber,
    required this.text,
    required this.buttonText,
    required this.onPressed,
    this.animationIndex = 0,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsetsDirectional.fromSTEB(0, 0, 0, 12),
      child: Container(
        width: MediaQuery.sizeOf(context).width * 0.92,
        height: 70,
        decoration: BoxDecoration(
          color: Colors.white12,
          borderRadius: BorderRadius.circular(8),
        ),
        child: Row(
          mainAxisSize: MainAxisSize.max,
          children: [
            Padding(
              padding: const EdgeInsetsDirectional.fromSTEB(8, 0, 0, 0),
              child: Card(
                clipBehavior: Clip.antiAliasWithSaveLayer,
                color: const Color(0x6639D2C0),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(40),
                ),
                child: Padding(
                  padding: EdgeInsets.all(6),
                  child: Text(
                    '$animationIndex',
                    style: TextStyle(
                        fontFamily: 'Lexend',
                        fontSize: 14,
                        letterSpacing: 0.0,
                        fontWeight: FontWeight.w500,
                        color: Colors.white),
                  ),
                ),
              ),
            ),
            Expanded(
              child: Padding(
                padding: const EdgeInsetsDirectional.fromSTEB(12, 0, 0, 0),
                child: Row(
                  mainAxisSize: MainAxisSize.max,
                  children: [
                    Expanded(
                      child: RichText(
                        text: TextSpan(
                          children: [
                            TextSpan(
                              text: '$patientName, ',
                              style: const TextStyle(
                                fontFamily: 'Lexend',
                                fontSize: 22,
                                letterSpacing: 0.0,
                                color: Colors.white,
                              ),
                            ),
                            TextSpan(
                              text: 'Queue No: $queueNumber',
                              style: const TextStyle(
                                fontFamily: 'Lexend',
                                fontSize: 22,
                                letterSpacing: 0.0,
                                color: Colors.grey,
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                    MyButton(
                      text: buttonText,
                      onPressed: onPressed,
                      backgroundColor: const Color(0xFF00A896),
                      padding: const EdgeInsets.symmetric(
                        horizontal: 16,
                        vertical: 0,
                      ),
                      borderRadius: BorderRadius.circular(8),
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    )
      .animate(
        onPlay: (controller) => controller.forward(),
      )
      .fadeIn(duration: 600.ms)
      .move(duration: 600.ms, begin: const Offset(0, 60));
  }
}