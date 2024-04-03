import 'package:dio/dio.dart';
import 'package:mowes/network_config/api_config.dart';
import 'package:mowes/network_config/api_endpoints.dart';

class BaseNetworkCalls {
  Dio dio = Dio();

  Future<Response> getPopularMovies() async {
    Response response = await dio.get(ApiEndPoints.popularMovieList.baseURL(),
        options: Options(headers: {
          'Authorization': 'Bearer ${ApiConfig.barerToken}',
        }));
    // print(response.data);
    return response;
  }

  Future<Response> topRatedMovieList() async {
    Response response = await dio.get(ApiEndPoints.topRatedMovieList.baseURL(),
        options: Options(headers: {
          'Authorization': 'Bearer ${ApiConfig.barerToken}',
        }));
    //print(response.data);
    return response;
  }

  Future<Response> nowPlayingMovieList() async {
    Response response =
        await dio.get(ApiEndPoints.nowPlayingMovieList.baseURL(),
            options: Options(headers: {
              'Authorization': 'Bearer ${ApiConfig.barerToken}',
            }));
    //print(response.data);
    return response;
  }

  Future<Response> movieDetails(int id) async {
    Response response =
        await dio.get((ApiEndPoints.movieDetails + id.toString()).baseURL());
    print(response.data);
    return response;
  }
}
