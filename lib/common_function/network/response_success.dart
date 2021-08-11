import 'package:flutter/foundation.dart';

class ResponseSuccess {
  bool? success;
  dynamic dataResponse;
  String? msg;

  ResponseSuccess({
    @required this.success,
    @required this.dataResponse,
    @required this.msg,
  });
}
