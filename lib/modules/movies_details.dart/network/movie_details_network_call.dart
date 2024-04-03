import 'package:dio/dio.dart';
import 'package:mowes/modules/movies_details.dart/model/details_model.dart';
import 'package:mowes/network_config/base_network_calls.dart';

class MovieDetailsNetworkCall {
  static Future<MovieDetailesListModel?> movieDetailsList(int movieID) async {
    Response response = await BaseNetworkCalls().movieDetails(movieID);
    return MovieDetailesListModel.fromJson(response.data);
  }
}
