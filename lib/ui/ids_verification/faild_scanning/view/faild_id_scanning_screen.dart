import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:vlens_flutter/utilities/colors.dart';
import 'package:vlens_flutter/utilities/text_styles.dart';

import '../../../../custom_views/custom_button.dart';
import '../../../../custom_views/custom_image_inside_circles.dart';
import '../../front_id_scanner/view/front_id_scanner.dart';

class FailedIdScanningScreen extends StatelessWidget {
  const FailedIdScanningScreen({super.key});

  // navigation
  static navigateToFrontIdScanner(BuildContext context) {
    Navigator.push(context,
        MaterialPageRoute(builder: (context) => const FrontIdScanner()));
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
                    "retry_scanning_your_id".tr(),
                    style: CustomTextStyle.header),
              ),

              const SizedBox(height: 30),
              // Image Inside Circles
              ImageInsideCircles(
                  circleColor: UIColors.teal200,
                  centerImage: Image.asset('assets/images/error.png')),
              const SizedBox(height: 35),
              // Description
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 40),
                child: Text(
                  "unable_to_verify_id".tr(),
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
                  text: 'retry_scanning'.tr(),
                  onPressed: () {
                    navigateToFrontIdScanner(context);
                  },
                ),
              )
            ],
          ),
        ));
  }
}
