import 'package:dio/dio.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:dano_foosball/api/TokenHelper.dart';
import 'package:dano_foosball/utils/helpers.dart';
import 'package:dano_foosball/utils/preferences_service.dart';

class Api {
  final Dio dio;
  final Dio tokenDio;
  final String? baseUrl;

  // Create a CancelToken instance
  final CancelToken cancelToken = CancelToken();

  Api._internal(this.baseUrl)
      : dio = Dio(BaseOptions(
          baseUrl: baseUrl!,
          // receiveTimeout: const Duration(seconds: 15),
          // connectTimeout: const Duration(seconds: 15),
          // sendTimeout: const Duration(seconds: 15),
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
  CancelToken cancelToken = CancelToken();
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

    // Check if token is null
    if (token == null) {
      // Handle the situation when the token is null
      // You can abort the request or handle it based on your requirements
      handler.reject(
        DioError(
          requestOptions: options,
          error: 'Token is null. Request cannot proceed.',
          type: DioErrorType.cancel,
        ),
      );
      return;
    }

    TokenHelper helper = TokenHelper();
    var remainingTime = await helper.getAccessTokenRemainingTime(token);
    // Check if remaining time of token is less or equal to a minute
    if (remainingTime != null && remainingTime <= const Duration(minutes: 1)) {
      Helpers helper = Helpers();
      var newToken = await helper.refreshToken();
      if (newToken != 'ABORTAPICALL') {
        options.headers['authorization'] = 'Bearer $newToken';
        cancelToken = CancelToken();
      } else {
        handler.reject(
          DioError(
            requestOptions: options,
            error: 'Failed to refresh token. Request aborted.',
            type: DioErrorType.cancel,
          ),
        );
        return;
      }
    } else {
      options.headers['authorization'] = 'Bearer $token';
    }

    return handler.next(options);
  }
}
