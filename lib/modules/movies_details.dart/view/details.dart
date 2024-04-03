import 'package:flutter/material.dart';
import 'package:mowes/modules/movies_details.dart/model/details_model.dart';
import 'package:mowes/modules/movies_details.dart/network/movie_details_network_call.dart';
import 'package:mowes/network_config/api_endpoints.dart';

class MovieDetailes extends StatefulWidget {
  final int id;
  //final String movieTitel;
  const MovieDetailes({super.key, required this.id});

  @override
  State<MovieDetailes> createState() => _MovieDetailesState();
}

class _MovieDetailesState extends State<MovieDetailes> {
  MovieDetailesListModel? movieDetailesListModel;

  @override
  void initState() {
    getMovieDetails();
    super.initState();
  }

  getMovieDetails() async {
    movieDetailesListModel =
        await MovieDetailsNetworkCall.movieDetailsList(widget.id);
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: movieDetailesListModel?.backdropPath == null
            ? Padding(
                padding: const EdgeInsets.only(top: 80.0),
                child: Center(
                    child: CircularProgressIndicator(
                  color: Colors.pink.shade100,
                )),
              )
            : Container(
                height: 400,
                width: double.infinity,
                decoration: BoxDecoration(
                    image: DecorationImage(
                        image: NetworkImage(
                            (movieDetailesListModel?.backdropPath ?? '')
                                .imageOgUrl()))),
              ));
  }
}
