import 'dart:async';
import 'package:chopper/chopper.dart';

class HeaderInterceptor implements RequestInterceptor {
  static const String AUTH_HEADER = "Authorization";
  static const String BEARER = "Bearer ";
  static const String V4_AUTH_HEADER =
      "eyJhbGciOiJIUzI1NiJ9.eyJhdWQiOiJiMTYxMTc3ZDAzNzc0MTY4YWZhYjg4MDYxZWI4ZTJhMiIsInN1YiI6IjVjZmJkOThiMGUwYTI2NzYxN2QzNjFlOCIsInNjb3BlcyI6WyJhcGlfcmVhZCJdLCJ2ZXJzaW9uIjoxfQ.UZ25clcaEFv07XA0DR2Zuaf8y-42qR22WkFbDlqYuyY";

  @override
  FutureOr<Request> onRequest(Request request) async {
    Request newRequest = request.copyWith(headers: {AUTH_HEADER: BEARER + V4_AUTH_HEADER});
    return newRequest;
  }
}
