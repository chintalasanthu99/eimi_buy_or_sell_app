import 'package:Eimi/utils/flavour_config.dart';


class S3DevConstants implements S3Constants {
  @override String? BUCKET_NAME = "dev-eimi";
  @override String? IDENTITY_POOL_ID = "us-east-1:aaa682cc-f659-4e07-8d1b-0fc607ee33ca";
  @override String? REGION = "US_EAST_1";
  @override String? SUB_REGION = "US_EAST_1";
  @override String? FOLDER_NAME = "user-profiles";
  @override String? VIDEOS_FOLDER_NAME = "user-profiles";
  @override String? IMAGE_PATH = "https://dev-eimi.s3.amazonaws.com/user-profiles/";
  @override String? VIDEO_PATH = "https://dev-eimi.s3.amazonaws.com/user-profiles/";
}
class S3LiveConstants implements S3Constants {
  @override String? BUCKET_NAME = "dev-eimi";
  @override String? IDENTITY_POOL_ID = "us-east-1:aaa682cc-f659-4e07-8d1b-0fc607ee33ca";
  @override String? REGION = "US_EAST_1";
  @override String? SUB_REGION = "US_EAST_1";
  @override String? FOLDER_NAME = "user-profiles";
  @override String? VIDEOS_FOLDER_NAME = "user-profiles";
  @override String? IMAGE_PATH = "https://dev-eimi.s3.amazonaws.com/user-profiles/";
  @override String? VIDEO_PATH = "https://dev-eimi.s3.amazonaws.com/user-profiles/";
}


