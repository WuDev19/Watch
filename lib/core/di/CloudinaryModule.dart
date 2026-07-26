import 'package:cloudinary_public/cloudinary_public.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:injectable/injectable.dart';

@module
abstract class CloudinaryModule {
  @lazySingleton
  CloudinaryPublic provideCloudinary() {
    final cloudName = dotenv.get("CLOUD_NAME");
    final uploadPreset = dotenv.get("UPLOAD_PRESET");
    return CloudinaryPublic(cloudName, uploadPreset, cache: false);
  }
}
