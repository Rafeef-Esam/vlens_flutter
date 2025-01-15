import 'package:get_it/get_it.dart';
import 'package:vlens_flutter/ui/face_verification/face_varification_processing/view_model/face_verfication_processing_view_model.dart';

import '../ui/ids_verification/ids_processing/view_model/ids_processing_view_model.dart';

final GetIt getIt = GetIt.instance;

Future<void> setupDI() async {

  // view models
  getIt.registerLazySingleton<IdsProcessingViewModel>(() => IdsProcessingViewModel());
  getIt.registerLazySingleton<FaceVerificationProcessingViewModel>(() => FaceVerificationProcessingViewModel());


}