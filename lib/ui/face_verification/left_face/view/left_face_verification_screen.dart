import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:camera/camera.dart';
import 'package:flutter/services.dart';
import 'package:vlens_flutter/ui/face_verification/face_varification_processing/view/face_verification_processing.dart';
import 'package:vlens_flutter/ui/face_verification/right_fcae/view/right_face_verification_screen.dart';
import 'package:vlens_flutter/utilities/colors.dart';

import '../../../../custom_views/custom_camera_button.dart';
import '../../../../custom_views/custom_camera_header.dart';

class LeftFaceVerificationScreen extends StatefulWidget {
  const LeftFaceVerificationScreen({super.key});

  @override
  State<LeftFaceVerificationScreen> createState() =>
      _LeftFaceVerificationScreen();
}

class _LeftFaceVerificationScreen extends State<LeftFaceVerificationScreen> {
  CameraController? _controller;
  bool _isFlashOn = false;
  bool _isInitialized = false;

  GlobalKey scanningFrameKey = GlobalKey();

  @override
  void initState() {
    super.initState();
    _initializeCamera();
    navigateToProcessingFace(context);
  }

  Future<void> _initializeCamera() async {
    try {
      final cameras = await availableCameras();
      if (cameras.isEmpty) return;

      final frontCamera = cameras.firstWhere(
        (camera) => camera.lensDirection == CameraLensDirection.front,
      );

      _controller = CameraController(
        frontCamera,
        ResolutionPreset.high,
        enableAudio: false,
        imageFormatGroup: ImageFormatGroup.jpeg,
      );

      await _controller?.initialize();
      await _controller?.lockCaptureOrientation(DeviceOrientation.portraitUp);

      setState(() {
        _isInitialized = true;
      });
    } catch (e) {
      print('Error initializing camera: $e');
    }
  }

  void _toggleFlash() async {
    if (_controller != null && _isInitialized) {
      setState(() {
        _isFlashOn = !_isFlashOn;
      });
      await _controller?.setFlashMode(
        _isFlashOn ? FlashMode.torch : FlashMode.off,
      );
    }
  }

  Future<void> _takePicture() async {
    if (_controller != null && _isInitialized) {
      try {
        final XFile? photo = await _controller?.takePicture();
        if (photo != null) {
          // Directly handle the captured image path
          print('Image saved at: ${photo.path}');
        }
      } catch (e) {
        print('Error taking picture: $e');
      }
    }
  }

  @override
  void dispose() {
    super.dispose();
    _controller?.dispose();
  }

  // navigation
  static navigateToProcessingFace(BuildContext context) {
    Future.delayed(const Duration(seconds: 6), () {
      // todo will remove
      if (context.mounted) {
        Navigator.push(
          context,
          MaterialPageRoute(
              builder: (context) => const FaceVerificationProcessing()),
        );
      }
    });
  }

  navigateToRightFace(BuildContext context) {
    Navigator.push(
      context,
      MaterialPageRoute(
          builder: (context) => const RightFaceVerificationScreen()),
    );
  }

  @override
  Widget build(BuildContext context) {
    return PopScope(
        canPop: false,
        child: Scaffold(
          backgroundColor: Colors.black,
          body: SafeArea(
            child: Column(
              children: [
                // Header with navigation and flash
                CameraHeader(
                  onBackTap: () => navigateToRightFace(context),
                  onFlashToggle: _toggleFlash,
                  isFlashOn: _isFlashOn,
                ),
                // Camera Preview
                Expanded(
                  child: Stack(
                    children: [
                      if (_isInitialized && _controller != null)
                        RotatedBox(
                          quarterTurns: 3,
                          child: Align(
                            alignment: Alignment.center,
                            child: SizedBox.expand(
                              child: Transform.scale(
                                scaleY: -1,
                                child: CameraPreview(_controller!),
                              ),
                            ),
                          ),
                        )
                      else
                        const Align(
                          alignment: Alignment.center,
                          child: CircularProgressIndicator(),
                        ),

                      // Instruction Container Positioned below the Scanning Frame
                      Positioned(
                          bottom: 40,
                          left: 20,
                          right: 20,
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Image.asset('assets/images/left_face.png'),
                              const SizedBox(height: 12),
                              Container(
                                padding: const EdgeInsets.symmetric(
                                    horizontal: 16, vertical: 15),
                                decoration: BoxDecoration(
                                  color: UIColors.midnightBlue.withAlpha(80),
                                  borderRadius: BorderRadius.circular(24),
                                  border: Border.all(
                                    color: Colors.transparent,
                                    width: 1.0,
                                  ),
                                ),
                                child: Text(
                                  'look_left'.tr(),
                                  textAlign: TextAlign.center,
                                  style: TextStyle(
                                      color: UIColors.white50,
                                      fontSize: 16,
                                      fontWeight: FontWeight.w500),
                                ),
                              ),
                            ],
                          )),
                    ],
                  ),
                ),

                // Bottom Button (Capture Image)
                CameraButton(
                  onTap: () {},
                ),
              ],
            ),
          ),
        ));
  }
}
