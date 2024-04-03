import 'package:flutter/material.dart';
import 'package:mowes/modules/home/model/NowPlaying_Movie_List_Model.dart';
import 'package:mowes/modules/home/model/popular_movie_list_model.dart';
import 'package:mowes/modules/home/model/top_rated_movie_list.dart';
import 'package:mowes/modules/home/network/home_network.dart';
import 'package:mowes/modules/movies_details.dart/view/details.dart';
import 'package:mowes/network_config/api_endpoints.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  PopularMovieListModel? popularMovieListModel;
  TopRatedMovieList? topRatedMovieList;
  NowPlayingMovieListModel? nowPlayingMovieList;
  @override
  void initState() {
    // Future.delayed(const Duration(seconds: 10));
    getMovieList();
    getTopRatedMovieList();
    getNowPlayingMovieList();
    super.initState();
  }

  getMovieList() async {
    popularMovieListModel = await HomeNetworkcalls.populerMoviList();
    // print();
    setState(() {});
  }

  getTopRatedMovieList() async {
    topRatedMovieList = await HomeNetworkcalls.topRatedMovieList();
    // print();
    setState(() {});
  }

  getNowPlayingMovieList() async {
    nowPlayingMovieList = await HomeNetworkcalls.nowPlayingMovieList();
    // print();
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      drawer: const Drawer(),
      appBar: appbar(),
      body: SingleChildScrollView(
        physics: const BouncingScrollPhysics(),
        child: popularMovieListModel?.results == null
            ? const Padding(
                padding: EdgeInsets.only(top: 80.0),
                child: Center(child: CircularProgressIndicator()),
              )
            : Padding(
                padding: const EdgeInsets.symmetric(horizontal: 8.0),
                child: Column(
                  children: [
                    popular(),
                    listView(),
                    topRated(),
                    topRatedListView(),
                    nowPlayingText(),
                    nowPlaying(),
                    upcoming(),
                    listView()
                  ],
                ),
              ),
      ),
    );
  }

  PreferredSizeWidget appbar() {
    return AppBar(
      actions: const [
        Padding(
          padding: EdgeInsets.only(right: 8.0),
          child: Icon(Icons.search),
        )
      ],
      // ignore: prefer_const_constructors
      title: Center(
        child: const Text(
          'Home',
          style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold),
        ),
      ),
      iconTheme: const IconThemeData(color: Colors.white),
    );
  }

  Widget popular() {
    return SizedBox(
      height: 100,
      width: double.infinity,
      child: Row(
        children: [
          const Padding(
            padding: EdgeInsets.only(bottom: 40, left: 20),
            child: Align(
              alignment: Alignment.bottomLeft,
              child: Text('Popular',
                  style: TextStyle(color: Colors.white, fontSize: 20)),
            ),
          ),
          const Spacer(),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 20.0, vertical: 20),
            child: Container(
              height: 30,
              width: 50,
              decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(8), color: Colors.white),
              child: const Center(
                child: Text(
                  'All',
                  style: TextStyle(
                      color: Colors.black,
                      fontWeight: FontWeight.bold,
                      fontSize: 15),
                ),
              ),
            ),
          )
        ],
      ),
    );
  }

  Widget listView() {
    return SizedBox(
      height: 250,
      width: double.infinity,
      child: Expanded(
        child: ListView.builder(
          itemCount: popularMovieListModel?.results?.length,
          scrollDirection: Axis.horizontal,
          itemBuilder: (context, index) {
            return InkWell(
              onTap: () {
                Navigator.push(
                    context,
                    MaterialPageRoute(
                        builder: (context) => MovieDetailes(
                              id: popularMovieListModel?.results?[index].id ??
                                  0,
                            )));
              },
              child: Column(
                children: [
                  Container(
                    height: 200,
                    width: 150,
                    margin: const EdgeInsets.symmetric(horizontal: 4),
                    decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.circular(8),
                        image: DecorationImage(
                            image: NetworkImage((popularMovieListModel
                                        ?.results?[index].posterPath ??
                                    '')
                                .imagew500Url()),
                            fit: BoxFit.cover)),
                  ),
                  Padding(
                    padding: const EdgeInsets.only(top: 8.0),
                    child: Text(
                      popularMovieListModel?.results?[index].title ?? '',
                      style: const TextStyle(
                        fontSize: 15,
                        fontWeight: FontWeight.w100,
                      ),
                    ),
                  )
                ],
              ),
            );
          },
        ),
      ),
    );
  }

  Widget topRated() {
    return SizedBox(
      height: 100,
      width: double.infinity,
      child: Row(
        children: [
          const Padding(
            padding: EdgeInsets.only(bottom: 40, left: 20),
            child: Align(
              alignment: Alignment.bottomLeft,
              child: Text('Top Rated',
                  style: TextStyle(color: Colors.white, fontSize: 20)),
            ),
          ),
          const Spacer(),
          Padding(
            padding: const EdgeInsets.only(right: 8.0),
            child: Container(
              height: 30,
              width: 50,
              decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(8), color: Colors.white),
              child: const Center(
                child: Text(
                  'All',
                  style: TextStyle(
                      color: Colors.black,
                      fontWeight: FontWeight.bold,
                      fontSize: 15),
                ),
              ),
            ),
          )
        ],
      ),
    );
  }

  Widget topRatedListView() {
    return SizedBox(
      height: 250,
      width: double.infinity,
      child: Expanded(
        child: ListView.builder(
          itemCount: topRatedMovieList?.results?.length,
          scrollDirection: Axis.horizontal,
          itemBuilder: (context, index) {
            return Column(
              children: [
                Container(
                  height: 200,
                  width: 150,
                  margin: const EdgeInsets.symmetric(horizontal: 4),
                  decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(8),
                      image: DecorationImage(
                          image: NetworkImage(
                              (topRatedMovieList?.results?[index].posterPath ??
                                      '')
                                  .imageOgUrl()),
                          fit: BoxFit.fill)),
                ),
                Padding(
                  padding: const EdgeInsets.only(top: 8.0, left: 2),
                  child: Text(
                    topRatedMovieList?.results?[index].title ?? '',
                    style: const TextStyle(
                      fontSize: 15,
                      fontWeight: FontWeight.w100,
                    ),
                  ),
                )
              ],
            );
          },
        ),
      ),
    );
  }

  Widget nowPlayingText() {
    return SizedBox(
      height: 100,
      width: double.infinity,
      child: Row(
        children: [
          const Padding(
            padding: EdgeInsets.only(bottom: 40, left: 20),
            child: Align(
              alignment: Alignment.bottomLeft,
              child: Text('Now Playing',
                  style: TextStyle(color: Colors.white, fontSize: 20)),
            ),
          ),
          const Spacer(),
          Padding(
            padding: const EdgeInsets.only(right: 8.0),
            child: Container(
              height: 30,
              width: 50,
              decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(8), color: Colors.white),
              child: const Center(
                child: Text(
                  'All',
                  style: TextStyle(
                      color: Colors.black,
                      fontWeight: FontWeight.bold,
                      fontSize: 15),
                ),
              ),
            ),
          )
        ],
      ),
    );
  }

  Widget nowPlaying() {
    return SizedBox(
      height: 250,
      width: double.infinity,
      child: Expanded(
        child: ListView.builder(
          itemCount: 10,
          scrollDirection: Axis.horizontal,
          itemBuilder: (context, index) {
            return Container(
              height: 100,
              width: 400,
              margin: const EdgeInsets.symmetric(horizontal: 4),
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(8),
                image: DecorationImage(
                    image: NetworkImage(
                        (nowPlayingMovieList?.results?[index].backdropPath ??
                                '')
                            .imageOgUrl()),
                    fit: BoxFit.fill),
              ),
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.end,
                children: [
                  Padding(
                    padding: const EdgeInsets.only(left: 10, bottom: 8),
                    child: Align(
                      alignment: Alignment.bottomLeft,
                      child: Container(
                        height: 150,
                        width: 100,
                        decoration: BoxDecoration(
                            color: Colors.white,
                            borderRadius: BorderRadius.circular(10),
                            image: DecorationImage(
                                image: NetworkImage((popularMovieListModel
                                            ?.results?[index].posterPath ??
                                        '')
                                    .imageOgUrl()),
                                fit: BoxFit.cover)),
                      ),
                    ),
                  ),
                  Expanded(
                    child: Padding(
                      padding: const EdgeInsets.only(bottom: 8.0),
                      child: Container(
                        height: 100,
                        decoration: BoxDecoration(
                            color: Colors.black.withOpacity(0.5),
                            borderRadius: BorderRadius.circular(2)),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          mainAxisAlignment: MainAxisAlignment.end,
                          children: [
                            Text(
                              nowPlayingMovieList
                                      ?.results?[index].originalTitle ??
                                  '',
                              style: const TextStyle(
                                  fontSize: 20,
                                  color: Colors.white,
                                  fontWeight: FontWeight.bold),
                            ),
                            SizedBox(
                              width: 300,
                              child: Text(
                                nowPlayingMovieList?.results?[index].overview ??
                                    '',
                                style: const TextStyle(
                                    fontSize: 10,
                                    color: Colors.white,
                                    fontWeight: FontWeight.bold),
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                  )
                ],
              ),
            );
          },
        ),
      ),
    );
  }

  Widget upcoming() {
    return SizedBox(
      height: 100,
      width: double.infinity,
      child: Row(
        children: [
          const Padding(
            padding: EdgeInsets.only(bottom: 40, left: 20),
            child: Align(
              alignment: Alignment.bottomLeft,
              child: Text('Upcoming',
                  style: TextStyle(color: Colors.white, fontSize: 20)),
            ),
          ),
          const Spacer(),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 20.0, vertical: 20),
            child: Container(
              height: 30,
              width: 50,
              decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(8), color: Colors.white),
              child: const Center(
                child: Text(
                  'All',
                  style: TextStyle(
                      color: Colors.black,
                      fontWeight: FontWeight.bold,
                      fontSize: 15),
                ),
              ),
            ),
          )
        ],
      ),
    );
  }
}
