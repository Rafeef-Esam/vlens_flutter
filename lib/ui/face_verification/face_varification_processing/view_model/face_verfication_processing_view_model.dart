import 'package:flutter/cupertino.dart';

class FaceVerificationProcessingViewModel extends ChangeNotifier {
  bool isSuccess = false;

  Future<void> processIds() async {
    await Future.delayed(const Duration(seconds: 5), () {
      isSuccess = true;
      notifyListeners();
    });
  }
}