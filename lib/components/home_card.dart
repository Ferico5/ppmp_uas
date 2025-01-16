import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
// import '../components/my_button.dart';
// Removed import '../flutter_flow/flutter_flow_theme.dart';

class HomeCard extends StatelessWidget {
  final String title;
  final List<Widget> buttons;
  final int animationIndex;

  const HomeCard({
    super.key,
    required this.title,
    required this.buttons,
    this.animationIndex = 0,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsetsDirectional.fromSTEB(16, 40, 16, 12),
      child: Container(
        width: double.infinity,
        decoration: BoxDecoration(
          gradient: const LinearGradient(
            colors: [Color(0xFFB2DFDB), Color(0xFF00A896)],
            stops: [0, 1],
            begin: AlignmentDirectional(1, -1),
            end: AlignmentDirectional(-1, 1),
          ),
          borderRadius: BorderRadius.circular(16),
        ),
        child: Padding(
          padding: const EdgeInsets.all(12),
          child: Column(
            mainAxisSize: MainAxisSize.max,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Padding(
                padding: const EdgeInsetsDirectional.fromSTEB(0, 0, 0, 20),
                child: Text(
                  title,
                  style: const TextStyle(
                    fontFamily: 'Lexend',
                    fontSize: 24,
                    color: Colors.white,
                    letterSpacing: 0.0,
                    fontWeight: FontWeight.w600,
                  ),
                ),
              ),
              Row(
                mainAxisSize: MainAxisSize.max,
                children: buttons,
              ),
            ],
          ),
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