import 'package:flutter/cupertino.dart';

class ApiError {
  final int code;
  final String message;

  ApiError({@required this.code, @required this.message});
}
