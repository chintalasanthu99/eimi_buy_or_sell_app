import 'package:meta/meta.dart';

class FlavorConfig {
   String appName;
   String baseUrl;
   String appId;
   S3Constants s3constants;
   String packageName;
  static FlavorConfig? _instance;

  factory FlavorConfig({
    @required String? appName,
    @required String? baseUrl,
    String? appId,
    String? segmentkey,
    String? packageName,
    S3Constants? s3constants
  }) {
    _instance ??= FlavorConfig._internal(appName!,baseUrl!,appId!,s3constants!, packageName!);
    return _instance!;
  }

  FlavorConfig._internal(this.appName,this.baseUrl,this.appId, this.s3constants, this.packageName);
  static FlavorConfig get instance {
    return _instance!;
  }
}

abstract class S3Constants {
   String? BUCKET_NAME;
   String? IDENTITY_POOL_ID;
   String? REGION;
   String? SUB_REGION;
   String? FOLDER_NAME;
   String? VIDEOS_FOLDER_NAME;
   String? IMAGE_PATH;
   String? VIDEO_PATH;

  @override
  String toString() {
    return 'S3Constants{BUCKET_NAME: $BUCKET_NAME, IDENTITY_POOL_ID: $IDENTITY_POOL_ID, REGION: $REGION, SUB_REGION: $SUB_REGION, FOLDER_NAME: $FOLDER_NAME, IMAGE_PATH: $IMAGE_PATH}';
  }
}
