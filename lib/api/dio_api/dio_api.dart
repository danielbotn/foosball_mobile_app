import 'package:dio/dio.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:foosball_mobile_app/api/TokenHelper.dart';
import 'package:foosball_mobile_app/utils/helpers.dart';
import 'package:foosball_mobile_app/utils/preferences_service.dart';

class Api {
  final Dio dio;
  final Dio tokenDio;
  final String? baseUrl;

  Api._internal(this.baseUrl)
      : dio = Dio(BaseOptions(
          baseUrl: baseUrl!,
          receiveTimeout: const Duration(seconds: 15),
          connectTimeout: const Duration(seconds: 15),
          sendTimeout: const Duration(seconds: 15),
        )),
        tokenDio = Dio(BaseOptions(baseUrl: baseUrl)) {
    dio.interceptors.add(RefreshTokenInterceptor(dio: dio));
  }

  static final _singleton = Api._internal(
    kReleaseMode
        ? dotenv.env['REST_URL_PATH_PROD']
        : dotenv.env['REST_URL_PATH_DEV'],
  );

  factory Api() => _singleton;
}

class RefreshTokenInterceptor extends QueuedInterceptor {
  final Dio dio;

  RefreshTokenInterceptor({
    required this.dio,
  });

  @override
  Future<void> onRequest(
    RequestOptions options,
    RequestInterceptorHandler handler,
  ) async {
    PreferencesService preferencesService = PreferencesService();
    String? token = await preferencesService.getJwtToken();
    TokenHelper helper = TokenHelper();
    // var token = options.headers['authorization'];

    var remainingTime = await helper.getAccessTokenRemainingTime(token!);

    // Check if remaining time of token is less or equal to a minute
    if (remainingTime != null && remainingTime <= const Duration(minutes: 1)) {
      Helpers helper = Helpers();
      var newToken = await helper.refreshToken();
      options.headers['authorization'] = 'Bearer $newToken';
    } else {
      options.headers['authorization'] = 'Bearer $token';
    }

    return handler.next(options);
  }

  // @override
  // void onError(DioError err, ErrorInterceptorHandler handler) async {
  //   if (err.response == null) {
  //     return;
  //   }
  //   if (err.response!.statusCode == 401) {
  //     var res = await refreshToken();
  //     if (res != null && res) {
  //       await _retry(err.requestOptions);
  //     }
  //   }
  //   return handler.next(err);
  // }

  /// Api to get new token from refresh token
  ///
  Future<bool?> refreshToken() async {
    ///call your refesh token api here
    Helpers helper = Helpers();
    var refreshSuccessfull = helper.refreshToken();
    return refreshSuccessfull;
  }

  /// For retrying request with new token
  ///
  Future<Response<dynamic>> _retry(RequestOptions requestOptions) async {
    final options = Options(
      method: requestOptions.method,
      headers: requestOptions.headers,
    );
    return dio.request<dynamic>(requestOptions.path,
        data: requestOptions.data,
        queryParameters: requestOptions.queryParameters,
        options: options);
  }
}
