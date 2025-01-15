import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:vlens_flutter/ui/face_instructions/view/face_instructions_screen.dart';
import 'package:vlens_flutter/utilities/colors.dart';
import 'package:vlens_flutter/utilities/text_styles.dart';

import '../../../../custom_views/custom_button.dart';
import '../../../../custom_views/custom_image_inside_circles.dart';

class SuccessIdScanningScreen extends StatelessWidget {
  const SuccessIdScanningScreen({super.key});

  // navigation
  static navigateToFaceInstructions(BuildContext context) {
    Navigator.push(
        context,
        MaterialPageRoute(
            builder: (context) => const FaceInstructionsScreen()));
  }

  @override
  Widget build(BuildContext context) {
    return PopScope(
        canPop: false,
        child: Scaffold(
          backgroundColor: Colors.white,
          body: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              // Title
              Padding(
                padding: EdgeInsets.symmetric(horizontal: 60),
                child: Text(
                    textAlign: TextAlign.center,
                    "your_id_is_valid".tr(),
                    style: CustomTextStyle.header),
              ),

              const SizedBox(height: 30),
              // Image Inside Circles
              ImageInsideCircles(
                  circleColor: UIColors.teal200,
                  centerImage: Image.asset('assets/images/success.png')),
              const SizedBox(height: 35),
              // Description
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 40),
                child: Text(
                  "id_scanned_successfully".tr(),
                  textAlign: TextAlign.center,
                  style: CustomTextStyle.body,
                ),
              ),

              SizedBox(height: 35),

              Container(
                margin: EdgeInsets.symmetric(horizontal: 30),
                width: double.infinity,
                child: CustomButton(
                  backgroundColor: UIColors.teal,
                  text: 'continue_to_next_step'.tr(),
                  onPressed: () {
                    navigateToFaceInstructions(context);
                  },
                ),
              )
            ],
          ),
        ));
  }
}
