import 'package:mowes/network_config/api_config.dart';

class ApiEndPoints {
  static const String popularMovieList = '/movie/popular';
  static const String topRatedMovieList =
      'movie/top_rated?language=en-US&page=1';
  static const String nowPlayingMovieList =
      'movie/now_playing?language=en-US&page=1';

  static const String movieDetails = 'movie/';
}

extension StringExtension on String {
  String baseURL() {
    return "${ApiConfig.baseUrl}$this";
  }

  String imageOgUrl() {
    return "${ApiConfig.ogImage}$this";
  }

  String imagew500Url() {
    return "${ApiConfig.w500Image}$this";
  }

  String topRatedImg() {
    return "${ApiConfig.baseUrl}$this";
  }

  String nowPlaying() {
    return "${ApiConfig.baseUrl}$this";
  }

  String movieDetailes() {
    return "${ApiConfig.baseUrl}$this";
  }
}
