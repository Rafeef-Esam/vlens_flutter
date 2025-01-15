import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:camera/camera.dart';
import 'package:flutter/services.dart';
import 'package:vlens_flutter/utilities/colors.dart';
import 'dart:io';

import '../../../../custom_views/custom_camera_button.dart';
import '../../../../custom_views/custom_camera_header.dart';
import '../../../../utilities/image_crop.dart';
import '../../ids_processing/view/ids_processing_screen.dart';


class BackIdScanner extends StatefulWidget {
  const BackIdScanner({super.key});

  @override
  State<BackIdScanner> createState() => _BackIdScannerState();
}

class _BackIdScannerState extends State<BackIdScanner> {
  CameraController? _controller;
  bool _isFlashOn = false;
  bool _isInitialized = false;
  String? _imagePath;

  GlobalKey scanningFrameKey = GlobalKey();

  double? _scaleFactor;

  @override
  void initState() {
    super.initState();
    _initializeCamera();
  }

  Future<void> _initializeCamera() async {
    try {
      final cameras = await availableCameras();
      if (cameras.isEmpty) return;

      _controller = CameraController(
        cameras.first,
        ResolutionPreset.high,
        enableAudio: false,
        imageFormatGroup: ImageFormatGroup.jpeg,
      );

      await _controller?.initialize();
      await _controller?.lockCaptureOrientation(DeviceOrientation.portraitUp);

      setState(() {
        _isInitialized = true;
        _scaleFactor = 1.72;
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
          // Get the position and size of the scanning frame
          final RenderBox? renderBox =
              scanningFrameKey.currentContext?.findRenderObject() as RenderBox?;
          final offset = renderBox?.localToGlobal(Offset.zero);
          final size = renderBox?.size;

          if (offset != null && size != null && _scaleFactor != null) {
            final croppedImagePath = await cropImage(
              imagePath: photo.path,
              offsetX: offset.dx,
              offsetY: offset.dy,
              width: size.width,
              height: size.height,
              scaleFactor: _scaleFactor!,
            );

            setState(() {
              _imagePath = croppedImagePath;
            });
            print('Cropped Image saved at: $croppedImagePath');
          }
        }
      } catch (e) {
        print('Error taking picture: $e');
      }
    }
  }

  void _retakePicture() {
    setState(() {
      _imagePath = null;
    });
    _initializeCamera(); // Re-initialize the camera to take another picture
  }

  @override
  void dispose() {
    _controller?.dispose();
    super.dispose();
  }

  // navigation
  static navigateToIdProcessing(BuildContext context) {
    Navigator.push(context,
        MaterialPageRoute(builder: (context) => const IdsProcessingScreen()));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      body: SafeArea(
        child: Column(
          children: [
            // Header with navigation and flash
            CameraHeader(
              onBackTap: () => Navigator.pop(context),
              onFlashToggle: _toggleFlash,
              isFlashOn: _isFlashOn,
            ),
            // Camera Preview or Image View
            Expanded(
              child: _imagePath == null
                  ? Stack(
                      children: [
                        if (_isInitialized && _controller != null)
                          RotatedBox(
                            quarterTurns: 1,
                            child: Align(
                              alignment: Alignment.center,
                              child: SizedBox.expand(
                                child: CameraPreview(_controller!),
                              ),
                            ),
                          )
                        else
                          const Align(
                            alignment: Alignment.center,
                            child: CircularProgressIndicator(),
                          ),
                        // Scanning Frame Positioned above Camera Preview
                        Positioned.fill(
                          child: Align(
                            alignment: Alignment.center,
                            child: Image.asset(
                              'assets/images/scanning_frame.png',
                              key: scanningFrameKey,
                            ),
                          ),
                        ),
                        // Instruction Container Positioned below the Scanning Frame
                        Positioned(
                          bottom: 40,
                          left: 20,
                          right: 20,
                          child: Container(
                            padding: const EdgeInsets.symmetric(
                                horizontal: 16, vertical: 25),
                            decoration: BoxDecoration(
                              color: Colors.white10,
                              borderRadius: BorderRadius.circular(24),
                              border: Border.all(
                                color: Colors.transparent,
                                width: 1.0,
                              ),
                            ),
                            child: Column(
                              mainAxisSize: MainAxisSize.min,
                              children: [
                                Image.asset('assets/images/back_id_card.png'),
                                const SizedBox(height: 8),
                                Text(
                                  'place_back_id'.tr(),
                                  textAlign: TextAlign.center,
                                  style: TextStyle(
                                      color: UIColors.white50,
                                      fontSize: 16,
                                      fontWeight: FontWeight.w500),
                                ),
                              ],
                            ),
                          ),
                        ),
                      ],
                    )
                  : Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        // Display the captured image
                        Image.file(File(_imagePath!)),
                        const SizedBox(height: 20),
                        // Buttons for Retake and Continue
                        Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 40),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              // Retake Button with teal color
                              ElevatedButton(
                                onPressed: _retakePicture,
                                style: ElevatedButton.styleFrom(
                                  foregroundColor: Colors.white,
                                  backgroundColor: Colors.teal, // Text color
                                ),
                                child: Text('retake'.tr()),
                              ),
                              // Continue Button with teal color
                              ElevatedButton(
                                onPressed: () {
                                  navigateToIdProcessing(context);
                                  print('Continue with the image');
                                },
                                style: ElevatedButton.styleFrom(
                                  foregroundColor: Colors.white,
                                  backgroundColor: Colors.teal, // Text color
                                ),
                                child: Text('continue'.tr()),
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
            ),

            // Bottom Button (Only shows when the image is not taken)
            if (_imagePath == null)
              CameraButton(
                onTap: _takePicture,
              ),
          ],
        ),
      ),
    );
  }
}
