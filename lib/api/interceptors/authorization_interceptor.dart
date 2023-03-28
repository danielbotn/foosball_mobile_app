import 'package:foosball_mobile_app/utils/helpers.dart';
import 'package:foosball_mobile_app/utils/preferences_service.dart';
import 'package:http_interceptor/http_interceptor.dart';
import 'package:http/http.dart' as http;

//IMP http_interceptor and http plugin used for this

// 1 Interceptor class
class AuthorizationInterceptor implements InterceptorContract {
  // We need to intercept request
  @override
  Future<RequestData> interceptRequest({required RequestData data}) async {
    try {
      // Fetching t
      //oken from your locacl data
      PreferencesService preferencesService = PreferencesService();
      String? token = await preferencesService.getJwtToken();

      // Clear previous header and update it with updated token
      data.headers.clear();

      data.headers['authorization'] = 'Bearer ${token!}';
      data.headers['content-type'] = 'application/json';
    } catch (e) {
      print(e);
    }

    return data;
  }

  // Currently we do not have any need to intercept response
  @override
  Future<ResponseData> interceptResponse({required ResponseData data}) async {
    return data;
  }
}

class ExpiredTokenRetryPolicy extends RetryPolicy {
  //Number of retry
  @override
  // ignore: overridden_fields
  int maxRetryAttempts = 2;

  @override
  Future<bool> shouldAttemptRetryOnResponse(ResponseData response) async {
    //This is where we need to update our token on 401 response
    if (response.statusCode == 401) {
      //Refresh your token here. Make refresh token method where you get new token from
      //API and set it to your local data
      Helpers helpers = Helpers();
      await helpers.refreshToken(); //Find bellow the code of this function
      return true;
    }
    return false;
  }
}
