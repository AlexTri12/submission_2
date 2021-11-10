import 'package:cached_network_image/cached_network_image.dart';
import 'package:core/core.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:tv_shows/domain/entities/tv_show.dart';
import 'package:tv_shows/presentation/bloc/tv_show_now_playing_bloc.dart';
import 'package:tv_shows/presentation/bloc/tv_show_popular_bloc.dart';
import 'package:tv_shows/presentation/bloc/tv_show_top_rated_bloc.dart';
import 'package:tv_shows/presentation/pages/popular_tv_shows_page.dart';
import 'package:tv_shows/presentation/pages/search_tv_show_page.dart';
import 'package:tv_shows/presentation/pages/top_rated_tv_shows_page.dart';
import 'package:tv_shows/presentation/pages/tv_show_detail_page.dart';
import 'package:tv_shows/presentation/pages/watchlist_tv_shows_page.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:dartz/dartz.dart' as dz;

class HomeTvShowPage extends StatefulWidget {
  static const ROUTE_NAME = '/home-tv-show';

  @override
  _HomeTvShowPageState createState() => _HomeTvShowPageState();
}

class _HomeTvShowPageState extends State<HomeTvShowPage> {
  @override
  void initState() {
    super.initState();
    context.read<TvShowTopRatedBloc>().add(FetchTopRated());
    context.read<TvShowNowPlayingBloc>().add(FetchNowPlaying());
    context.read<TvShowPopularBloc>().add(FetchPopular());
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      drawer: Drawer(
        child: Column(
          children: [
            UserAccountsDrawerHeader(
              currentAccountPicture: CircleAvatar(
                backgroundImage: AssetImage('assets/circle-g.png', package: 'tv_shows'),
              ),
              accountName: Text('Ditonton'),
              accountEmail: Text('ditonton@dicoding.com'),
            ),
            ListTile(
              leading: Icon(Icons.movie),
              title: Text('Movies'),
              onTap: () {
                Navigator.pushNamed(context, HOME_MOVIE_ROUTE_NAME);
              },
            ),
            ListTile(
              leading: Icon(Icons.tv_rounded),
              title: Text('TV Shows'),
              onTap: () {
                Navigator.pop(context);
              },
            ),
            ListTile(
              leading: Icon(Icons.save_alt),
              title: Text('Watchlist'),
              onTap: () {
                Navigator.pushNamed(context, WATCHLIST_MOVIES_ROUTE_NAME);
              },
            ),
            ListTile(
              leading: Icon(Icons.save_alt),
              title: Text('Watchlist TV Shows'),
              onTap: () {
                Navigator.pushNamed(context, WatchlistTvShowsPage.ROUTE_NAME);
              },
            ),
            ListTile(
              onTap: () {
                Navigator.pushNamed(context, ABOUT_ROUTE_NAME);
              },
              leading: Icon(Icons.info_outline),
              title: Text('About'),
            ),
          ],
        ),
      ),
      appBar: AppBar(
        title: Text('Ditonton TV'),
        actions: [
          IconButton(
            onPressed: () {
              Navigator.pushNamed(context, SearchTvShowPage.ROUTE_NAME);
            },
            icon: Icon(Icons.search),
          )
        ],
      ),
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                'Now Playing',
                style: kHeading6,
              ),
              BlocBuilder<TvShowNowPlayingBloc, NowPlayingState>(
                builder: (context, state) {
                  if (state is NowPlayingLoading) {
                    return Center(
                      child: CircularProgressIndicator(),
                    );
                  } else if (state is NowPlayingHasData) {
                    final listTvShow = state.result;
                    return TvShowList(listTvShow
                        .map((data) => dz.cast<TvShow>(data))
                        .toList()
                    );
                  } else if (state is NowPlayingError) {
                    return Center(
                      child: Text(state.message),
                    );
                  } else {
                    return Center();
                  }
                },
              ),
              _buildSubHeading(
                title: 'Popular',
                onTap: () =>
                    Navigator.pushNamed(context, PopularTvShowsPage.ROUTE_NAME),
              ),
              BlocBuilder<TvShowPopularBloc, PopularState>(
                builder: (context, state) {
                  if (state is PopularLoading) {
                    return Center(
                      child: CircularProgressIndicator(),
                    );
                  } else if (state is PopularHasData) {
                    final listTvShow = state.result;
                    return TvShowList(listTvShow
                        .map((data) => dz.cast<TvShow>(data))
                        .toList()
                    );
                  } else if (state is PopularError) {
                    return Center(
                      child: Text(state.message),
                    );
                  } else {
                    return Center();
                  }
                },
              ),
              _buildSubHeading(
                title: 'Top Rated',
                onTap: () =>
                    Navigator.pushNamed(context, TopRatedTvShowsPage.ROUTE_NAME),
              ),
              BlocBuilder<TvShowTopRatedBloc, TopRatedState>(
                builder: (context, state) {
                  if (state is TopRatedLoading) {
                    return Center(
                      child: CircularProgressIndicator(),
                    );
                  } else if (state is TopRatedHasData) {
                    final listTvShow = state.result;
                    return TvShowList(listTvShow
                        .map((data) => dz.cast<TvShow>(data))
                        .toList()
                    );
                  } else if (state is TopRatedError) {
                    return Center(
                      child: Text(state.message),
                    );
                  } else {
                    return Center();
                  }
                },
              ),
            ],
          ),
        ),
      ),
    );
  }

  Row _buildSubHeading({required String title, required Function() onTap}) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Text(
          title,
          style: kHeading6,
        ),
        InkWell(
          onTap: onTap,
          child: Padding(
            padding: const EdgeInsets.all(8.0),
            child: Row(
              children: [Text('See More'), Icon(Icons.arrow_forward_ios)],
            ),
          ),
        ),
      ],
    );
  }
}

class TvShowList extends StatelessWidget {
  final List<TvShow> tvShows;

  TvShowList(this.tvShows);

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 200,
      child: ListView.builder(
        scrollDirection: Axis.horizontal,
        itemBuilder: (context, index) {
          final tvShow = tvShows[index];
          return Container(
            padding: const EdgeInsets.all(8),
            child: InkWell(
              onTap: () {
                Navigator.pushNamed(
                  context,
                  TvShowDetailPage.ROUTE_NAME,
                  arguments: tvShow.id,
                );
              },
              child: ClipRRect(
                borderRadius: BorderRadius.all(Radius.circular(16)),
                child: CachedNetworkImage(
                  imageUrl: '$BASE_IMAGE_URL${tvShow.posterPath}',
                  placeholder: (context, url) => Center(
                    child: CircularProgressIndicator(),
                  ),
                  errorWidget: (context, url, error) => Icon(Icons.error),
                ),
              ),
            ),
          );
        },
        itemCount: tvShows.length,
      ),
    );
  }
}
