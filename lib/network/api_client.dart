import 'package:codelab_list_data_json/config/config.dart';
import 'package:codelab_list_data_json/model/movie_model.dart';
import 'package:dio/dio.dart';

class ApiClient{
  static final Dio _dio = Dio(
    BaseOptions(
      baseUrl: Config.baseDomain,
    ),
  );
  static Future<Movie> getMoview({String apiKey, String language, int page}) async {
    try{
      Response<Map<String, dynamic>> _response;
      _response = await _dio.get<Map<String, dynamic>>(
        "/popular",
        queryParameters: <String, dynamic>{
          "api_key": apiKey,
          "language": language,
          "page": page,
        }
      );
      return Movie.fromMap(_response.data);
    } catch (e){
      throw "$e";
    }
  }
}