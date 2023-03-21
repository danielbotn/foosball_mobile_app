import 'dart:convert';
import 'package:jwt_decode/jwt_decode.dart';
import '../models/auth/login_response.dart';
import '../models/auth/refresh_model.dart';
import '../utils/preferences_service.dart';
import 'AuthApi.dart';

class TokenHelper {
  Future<String> checkTokenExpiry(String token) async {
    late String tokenResult = '';
    bool isExpired = Jwt.isExpired(token);
    PreferencesService preferencesService = PreferencesService();
    AuthApi auth = AuthApi();
    String? jwtToken = await preferencesService.getJwtToken();
    String? refreshToken = await preferencesService.getRefreshToken();

    if (isExpired && jwtToken != null && refreshToken != null) {
      RefreshModel refreshModel =
          RefreshModel(token: jwtToken, refreshToken: refreshToken);
      var refreshData = await auth.refresh(refreshModel);

      if (refreshData.statusCode == 200) {
        var refreshResponse =
            LoginResponse.fromJson(jsonDecode(refreshData.body));

        await preferencesService.setJwtToken(refreshResponse.token);
        await preferencesService.setRefreshToken(refreshResponse.refreshToken);
        tokenResult = refreshResponse.token;
      }
    } else {
      tokenResult = token;
    }
    return tokenResult;
  }

  Future<String> checkTokenExpiryTwo() async {
    late String tokenResult = '';
    PreferencesService preferencesService = PreferencesService();
    String? jwtToken = await preferencesService.getJwtToken();
    String? refreshToken = await preferencesService.getRefreshToken();

    if (jwtToken != null && refreshToken != null) {
      bool isExpired = Jwt.isExpired(jwtToken);

      if (isExpired) {
        AuthApi auth = AuthApi();
        RefreshModel refreshModel =
            RefreshModel(token: jwtToken, refreshToken: refreshToken);
        var refreshData = await auth.refresh(refreshModel);

        if (refreshData.statusCode == 200) {
          var refreshResponse =
              LoginResponse.fromJson(jsonDecode(refreshData.body));

          await preferencesService.setJwtToken(refreshResponse.token);
          await preferencesService
              .setRefreshToken(refreshResponse.refreshToken);
          tokenResult = refreshResponse.token;
        }
      } else {
        tokenResult = jwtToken;
      }
    }

    return tokenResult;
  }
}
