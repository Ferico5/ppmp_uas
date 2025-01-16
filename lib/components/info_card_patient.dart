import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import '../components/my_button.dart';
// Removed import '../flutter_flow/flutter_flow_theme.dart';

class InfoCardPatient extends StatelessWidget {
  final String name;
  final String age;
  final String gender;
  final String address;
  final String phoneNumber;
  final String email;
  final VoidCallback updateOnPressed;
  final VoidCallback deleteOnPressed;

  const InfoCardPatient({
    super.key,
    required this.name,
    required this.age,
    required this.gender,
    required this.address,
    required this.phoneNumber,
    required this.email,
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
                          "Name     :", //FFLocalizations.of(context).getText('9ctmtzj2')
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
                        child: Text(name,
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
                          "Age        :", //FFLocalizations.of(context).getText('56mtaxxs')
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
                          age, //FFLocalizations.of(context).getText('mswz3cxk')
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
                          "Gender   :", //FFLocalizations.of(context).getText('bfq064kf')
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
                          gender, //FFLocalizations.of(context).getText('rzlp67jy')
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
                          "Address  :", //FFLocalizations.of(context).getText('0cviwuss')
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
                          address, //FFLocalizations.of(context).getText('zk7xf37g')
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
                          "Phone     :", //FFLocalizations.of(context).getText('bgy1lgto')
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
                          phoneNumber, //FFLocalizations.of(context).getText('b5oip9nu')
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
                  padding: const EdgeInsets.all(12),
                  child: Row(
                    mainAxisSize: MainAxisSize.max,
                    children: [
                      const Padding(
                        padding: EdgeInsetsDirectional.fromSTEB(0, 0, 10, 0),
                        child: Text(
                          "Email      :", //FFLocalizations.of(context).getText('t6jo8muk')
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
                          email, //FFLocalizations.of(context).getText('qdxhbt1c')
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