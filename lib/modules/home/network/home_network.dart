import 'package:dio/dio.dart';
import 'package:mowes/modules/home/model/NowPlaying_Movie_List_Model.dart';
import 'package:mowes/modules/home/model/popular_movie_list_model.dart';
import 'package:mowes/modules/home/model/top_rated_movie_list.dart';
import 'package:mowes/network_config/base_network_calls.dart';

class HomeNetworkcalls {
  static Future<PopularMovieListModel?> populerMoviList() async {
    Response response = await BaseNetworkCalls().getPopularMovies();
    return PopularMovieListModel.fromJson(response.data);
  }

  static Future<TopRatedMovieList?> topRatedMovieList() async {
    Response response = await BaseNetworkCalls().topRatedMovieList();
    return TopRatedMovieList.fromJson(response.data);
  }

  static Future<NowPlayingMovieListModel?> nowPlayingMovieList() async {
    Response response = await BaseNetworkCalls().nowPlayingMovieList();
    return NowPlayingMovieListModel.fromJson(response.data);
  }
}
