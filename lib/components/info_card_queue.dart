import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import '../components/my_button.dart';
// Removed import '../flutter_flow/flutter_flow_theme.dart';

class InfoCardQueue extends StatelessWidget {
  final String queue_no;
  final String queue_status;
  final String created_on;
  final String patient;
  final String doctor;
  final VoidCallback updateOnPressed;
  final VoidCallback deleteOnPressed;

  const InfoCardQueue({
    super.key,
    required this.queue_no,
    required this.queue_status,
    required this.created_on,
    required this.patient,
    required this.doctor,
    required this.updateOnPressed,
    required this.deleteOnPressed,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(16),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Container(
            width: MediaQuery.sizeOf(context).width * 0.9,
            decoration: BoxDecoration(
              color: Colors.white12,
              boxShadow: const [
                BoxShadow(
                  blurRadius: 4,
                  color: Color(0x3F14181B),
                  offset: Offset(
                    0.0,
                    3,
                  ),
                )
              ],
              borderRadius: BorderRadius.circular(8),
            ),
            child: Column(
              mainAxisSize: MainAxisSize.max,
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Padding(
                  padding: const EdgeInsetsDirectional.fromSTEB(12, 12, 12, 0),
                  child: Row(
                    mainAxisSize: MainAxisSize.max,
                    children: [
                      const Padding(
                        padding: EdgeInsetsDirectional.fromSTEB(0, 0, 10, 0),
                        child: Text(
                          "Queue No          :",
                          textAlign: TextAlign.start,
                          style: TextStyle(
                              fontFamily: 'Lexend',
                              fontSize: 18,
                              letterSpacing: 0.0,
                              fontWeight: FontWeight.w600,
                              color: Colors.white),
                        ),
                      ),
                      Padding(
                        padding:
                        const EdgeInsetsDirectional.fromSTEB(0, 8, 0, 12),
                        child: Text(queue_no,
                            textAlign: TextAlign.start,
                            style: const TextStyle(
                                fontFamily: 'Lexend',
                                fontSize: 18,
                                letterSpacing: 0.0,
                                fontWeight: FontWeight.normal,
                                color: Colors.white)),
                      ),
                    ],
                  ),
                ),
                Padding(
                  padding: const EdgeInsetsDirectional.fromSTEB(12, 12, 12, 0),
                  child: Row(
                    mainAxisSize: MainAxisSize.max,
                    children: [
                      const Padding(
                        padding: EdgeInsetsDirectional.fromSTEB(0, 0, 10, 0),
                        child: Text(
                          "Queue Status   :",
                          textAlign: TextAlign.start,
                          style: TextStyle(
                              fontFamily: 'Lexend',
                              fontSize: 18,
                              letterSpacing: 0.0,
                              fontWeight: FontWeight.w600,
                              color: Colors.white),
                        ),
                      ),
                      Padding(
                        padding:
                        const EdgeInsetsDirectional.fromSTEB(0, 8, 0, 12),
                        child: Text(
                          queue_status,
                          textAlign: TextAlign.start,
                          style: const TextStyle(
                              fontFamily: 'Lexend',
                              fontSize: 18,
                              letterSpacing: 0.0,
                              fontWeight: FontWeight.normal,
                              color: Colors.white),
                        ),
                      ),
                    ],
                  ),
                ),
                Padding(
                  padding: const EdgeInsetsDirectional.fromSTEB(12, 12, 12, 0),
                  child: Row(
                    mainAxisSize: MainAxisSize.max,
                    children: [
                      const Padding(
                        padding: EdgeInsetsDirectional.fromSTEB(0, 0, 10, 0),
                        child: Text(
                          "Created On       :",
                          textAlign: TextAlign.start,
                          style: TextStyle(
                              fontFamily: 'Lexend',
                              fontSize: 18,
                              letterSpacing: 0.0,
                              fontWeight: FontWeight.w600,
                              color: Colors.white),
                        ),
                      ),
                      Padding(
                        padding:
                        const EdgeInsetsDirectional.fromSTEB(0, 8, 0, 12),
                        child: Text(
                          created_on,
                          textAlign: TextAlign.start,
                          style: const TextStyle(
                              fontFamily: 'Lexend',
                              fontSize: 18,
                              letterSpacing: 0.0,
                              fontWeight: FontWeight.normal,
                              color: Colors.white),
                        ),
                      ),
                    ],
                  ),
                ),
                Padding(
                  padding: const EdgeInsetsDirectional.fromSTEB(12, 12, 12, 0),
                  child: Row(
                    mainAxisSize: MainAxisSize.max,
                    children: [
                      const Padding(
                        padding: EdgeInsetsDirectional.fromSTEB(0, 0, 10, 0),
                        child: Text(
                          "Patient              :",
                          textAlign: TextAlign.start,
                          style: TextStyle(
                              fontFamily: 'Lexend',
                              fontSize: 18,
                              letterSpacing: 0.0,
                              fontWeight: FontWeight.w600,
                              color: Colors.white),
                        ),
                      ),
                      Padding(
                        padding:
                        const EdgeInsetsDirectional.fromSTEB(0, 8, 0, 12),
                        child: Text(
                          patient,
                          textAlign: TextAlign.start,
                          style: const TextStyle(
                              fontFamily: 'Lexend',
                              fontSize: 18,
                              letterSpacing: 0.0,
                              fontWeight: FontWeight.normal,
                              color: Colors.white),
                        ),
                      ),
                    ],
                  ),
                ),
                Padding(
                  padding: const EdgeInsetsDirectional.fromSTEB(12, 12, 12, 0),
                  child: Row(
                    mainAxisSize: MainAxisSize.max,
                    children: [
                      const Padding(
                        padding: EdgeInsetsDirectional.fromSTEB(0, 0, 10, 0),
                        child: Text(
                          "Doctor               :",
                          textAlign: TextAlign.start,
                          style: const TextStyle(
                              fontFamily: 'Lexend',
                              fontSize: 18,
                              letterSpacing: 0.0,
                              fontWeight: FontWeight.w600,
                              color: Colors.white),
                        ),
                      ),
                      Padding(
                        padding:
                        const EdgeInsetsDirectional.fromSTEB(0, 8, 0, 12),
                        child: Text(
                          doctor,
                          textAlign: TextAlign.start,
                          style: const TextStyle(
                              fontFamily: 'Lexend',
                              fontSize: 18,
                              letterSpacing: 0.0,
                              fontWeight: FontWeight.normal,
                              color: Colors.white),
                        ),
                      ),
                    ],
                  ),
                ),
                Row(
                  mainAxisSize: MainAxisSize.max,
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    Padding(
                      padding:
                      const EdgeInsetsDirectional.fromSTEB(0, 10, 0, 10),
                      child: MyButton(
                        text: "Update",
                        onPressed: updateOnPressed,
                        backgroundColor: Colors.white,
                        textColor: const Color(0xFF00A896),
                        fontSize: 18,
                        borderSide: const BorderSide(
                          color: Color(0xFF00A896),
                          width: 4,
                        ),
                        borderRadius: BorderRadius.circular(8),
                      ),
                    ),
                    Padding(
                      padding:
                      const EdgeInsetsDirectional.fromSTEB(0, 10, 0, 10),
                      child: MyButton(
                        text: "Delete",
                        onPressed: deleteOnPressed,
                        backgroundColor: Colors.white,
                        textColor: Colors.red,
                        fontSize: 18,
                        borderSide: const BorderSide(
                          color: Colors.red,
                          width: 4,
                        ),
                        borderRadius: BorderRadius.circular(8),
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
        ],
      )
          .animate(
        onPlay: (controller) => controller.forward(),
      )
          .fadeIn(duration: 600.ms)
          .move(duration: 600.ms, begin: const Offset(0, 49)),
    );
  }
}