import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:vlens_flutter/utilities/colors.dart';

import '../../../../custom_views/custom_image_inside_circles.dart';
import '../../../../di/di_setup.dart';
import '../../../../utilities/text_styles.dart';
import '../../faild_scanning/view/faild_id_scanning_screen.dart';
import '../../success_scanning/view/success_id_scanning_screen.dart';
import '../view_model/ids_processing_view_model.dart';

class IdsProcessingScreen extends StatefulWidget {
  const IdsProcessingScreen({super.key});

  @override
  State<IdsProcessingScreen> createState() => _IdsProcessingScreenState();
}

class _IdsProcessingScreenState extends State<IdsProcessingScreen> {
  late IdsProcessingViewModel _viewModel;

  @override
  void initState() {
    super.initState();
    _viewModel = getIt<IdsProcessingViewModel>();
    _processIdsAndNavigate();
  }

  // Modify the function to wait for processIds to finish
  Future<void> _processIdsAndNavigate() async {
    await _viewModel.processIds();
    if (mounted) {
      if (_viewModel.isSuccess) {
        navigateToSuccess(context);
      } else {
        navigateToFailure(context);
      }
    }
  }

  // navigation
  static navigateToSuccess(BuildContext context) {
    Navigator.push(
      context,
      MaterialPageRoute(builder: (context) => const SuccessIdScanningScreen()),
    );
  }

  static navigateToFailure(BuildContext context) {
    Navigator.push(
      context,
      MaterialPageRoute(builder: (context) => const FailedIdScanningScreen()),
    );
  }

  @override
  Widget build(BuildContext context) {
    return PopScope(
        canPop: false,
        child: ChangeNotifierProvider.value(
          value: _viewModel,
          child: Scaffold(
            backgroundColor: Colors.white,
            body: Consumer<IdsProcessingViewModel>(
              builder: (context, viewModel, child) {
                return Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    // Title
                    Text(
                      "scanning_your_id".tr(),
                      style: CustomTextStyle.header,
                    ),
                    const SizedBox(height: 30),
                    // Image Inside Circles
                    ImageInsideCircles(
                      circleColor: UIColors.sandColor,
                      centerImage:
                          Image.asset('assets/images/process_scanning.png'),
                    ),
                    const SizedBox(height: 30),
                    // Description
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 20),
                      child: Text(
                        "processing_your_id".tr(),
                        textAlign: TextAlign.center,
                        style: CustomTextStyle.body,
                      ),
                    ),
                  ],
                );
              },
            ),
          ),
        ));
  }
}
