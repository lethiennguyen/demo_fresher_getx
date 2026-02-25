import 'dart:io';
import 'package:image_picker/image_picker.dart';

import '../../../core/base/base_repository/base_connect_api.dart';
import '../../../core/base/base_repository/base_repository.dart';
import '../../../shared/constants/api_url.dart';
import '../request/image_upload_request.dart';

class ImageRepository extends BaseRepository {
  final ImagePicker _picker = ImagePicker();
  final String uploadPreset = 'anh_hang_hoa';
  ImageRepository(super.controller);

  Future<File?> pickImage(ImageSource source) async {
    final pickedFile = await _picker.pickImage(source: source);
    if (pickedFile != null) {
      return File(pickedFile.path);
    }
    return null;
  }

  Future<String?> uploadToCloudinary(ImageUploadRequest requestImage) async {
    final res = await baseSendRequest(
      '',
      RequestMethod.POST,
      urlOther: ApiUrl.urlImagePicker,
      jsonMap: await requestImage.toFormData(),
    );
    if (res == null) {
      return null;
    }
    return res['secure_url'];
  }
}
