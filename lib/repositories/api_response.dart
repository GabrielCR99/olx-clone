import 'api_error.dart';

class ApiResponse {
  ApiResponse.success({this.result}) {
    isSuccess = true;
  }

  ApiResponse.error({this.error}) {
    isSuccess = false;
  }

  bool isSuccess;
  dynamic result;
  ApiError error;
}
