import 'package:cached_network_image/cached_network_image.dart';
import 'package:core/core.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:tv_shows/domain/entities/genre.dart';
import 'package:tv_shows/domain/entities/tv_show.dart';
import 'package:tv_shows/domain/entities/tv_show_detail.dart';
import 'package:tv_shows/presentation/bloc/tv_show_detail_bloc.dart';
import 'package:tv_shows/presentation/bloc/tv_show_detail_recommendation_bloc.dart';
import 'package:tv_shows/presentation/bloc/tv_show_detail_watchlist_bloc.dart';
import 'package:flutter/material.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:provider/provider.dart';
import 'package:dartz/dartz.dart' as dz;

class TvShowDetailPage extends StatefulWidget {
  static const ROUTE_NAME = '/detail-tv-show';

  final int id;
  TvShowDetailPage({required this.id});

  @override
  _TvShowDetailPageState createState() => _TvShowDetailPageState();
}

class _TvShowDetailPageState extends State<TvShowDetailPage> {
  @override
  void initState() {
    super.initState();
    context.read<TvShowDetailBloc>().add(FetchDetail(widget.id));
    context
        .read<TvShowDetailRecommendationBloc>()
        .add(FetchDetailRecommendation(widget.id));
    context
        .read<TvShowDetailWatchlistBloc>()
        .add(LoadWatchlistStatus(widget.id));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: BlocBuilder<TvShowDetailBloc, DetailState>(
        builder: (context, state) {
          if (state is DetailLoading) {
            return Center(
              child: CircularProgressIndicator(),
            );
          } else if (state is DetailHasData) {
            final tvShow = dz.cast<TvShowDetail>(state.result);
            return SafeArea(
              child: DetailContent(tvShow),
            );
          } else if (state is DetailError) {
            return Container(
              child: Text(state.message),
            );
          } else {
            return Container();
          }
        },
      ),
    );
  }
}

class DetailContent extends StatelessWidget {
  final TvShowDetail tvShow;

  DetailContent(this.tvShow);

  @override
  Widget build(BuildContext context) {
    final screenWidth = MediaQuery.of(context).size.width;
    return Stack(
      children: [
        CachedNetworkImage(
          imageUrl: 'https://image.tmdb.org/t/p/w500${tvShow.posterPath}',
          width: screenWidth,
          placeholder: (context, url) => Center(
            child: CircularProgressIndicator(),
          ),
          errorWidget: (context, url, error) => Icon(Icons.error),
        ),
        Container(
          margin: const EdgeInsets.only(top: 48 + 8),
          child: DraggableScrollableSheet(
            builder: (context, scrollController) {
              return Container(
                decoration: BoxDecoration(
                  color: kRichBlack,
                  borderRadius: BorderRadius.vertical(top: Radius.circular(16)),
                ),
                padding: const EdgeInsets.only(
                  left: 16,
                  top: 16,
                  right: 16,
                ),
                child: Stack(
                  children: [
                    Container(
                      margin: const EdgeInsets.only(top: 16),
                      child: SingleChildScrollView(
                        controller: scrollController,
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              tvShow.title,
                              style: kHeading5,
                            ),
                            BlocBuilder<TvShowDetailWatchlistBloc, DetailWatchlistStatus>(
                              builder: (context, state) {
                                if (state is IsAddedToWatchlist) {
                                  final isAddedWatchlist = state.isAddedToWatchlist;
                                  final message = state.message;

                                  return ElevatedButton(
                                    onPressed: () async {
                                      if (!isAddedWatchlist) {
                                        context
                                            .read<TvShowDetailWatchlistBloc>()
                                            .add(AddToWatchlist<TvShowDetail>(tvShow));
                                      } else {
                                        context
                                            .read<TvShowDetailWatchlistBloc>()
                                            .add(RemoveFromWatchlist<TvShowDetail>(tvShow));
                                      }

                                      if (message ==
                                          TvShowDetailWatchlistBloc
                                              .watchlistAddSuccessMessage ||
                                          message ==
                                              TvShowDetailWatchlistBloc
                                                  .watchlistRemoveSuccessMessage) {
                                        ScaffoldMessenger.of(context).showSnackBar(
                                            SnackBar(content: Text(message)));
                                      } else {
                                        showDialog(
                                            context: context,
                                            builder: (context) {
                                              return AlertDialog(
                                                content: Text(message),
                                              );
                                            });
                                      }
                                    },
                                    child: Row(
                                      mainAxisSize: MainAxisSize.min,
                                      children: [
                                        isAddedWatchlist
                                            ? Icon(Icons.check)
                                            : Icon(Icons.add),
                                        Text('Watchlist'),
                                      ],
                                    ),
                                  );
                                } else {
                                  return Container();
                                }
                              },
                            ),
                            Text(
                              _showGenres(tvShow.genres),
                            ),
                            Text(
                              _showDurations(tvShow.episodeRunTime),
                            ),
                            Row(
                              children: [
                                RatingBarIndicator(
                                  rating: tvShow.voteAverage! / 2,
                                  itemCount: 5,
                                  itemBuilder: (context, index) => Icon(
                                    Icons.star,
                                    color: kMikadoYellow,
                                  ),
                                  itemSize: 24,
                                ),
                                Text('${tvShow.voteAverage}')
                              ],
                            ),
                            SizedBox(height: 16),
                            Text(
                              'Overview',
                              style: kHeading6,
                            ),
                            Text(
                              tvShow.overview,
                            ),
                            SizedBox(height: 16),
                            _showEpisode('Last Episode', tvShow.lastEpisodeToAir),
                            _showEpisode('Next Episode', tvShow.nextEpisodeToAir),
                            _showSeasons(tvShow.seasons),
                            Text(
                              'Recommendations',
                              style: kHeading6,
                            ),
                            BlocBuilder<TvShowDetailRecommendationBloc, DetailRecommendationState>(
                              builder: (context, state) {
                                if (state is DetailRecommendationLoading) {
                                  return Center(
                                    child: CircularProgressIndicator(),
                                  );
                                } else if (state is DetailRecommendationError) {
                                  return Text(state.message);
                                } else if (state
                                is DetailRecommendationHasData) {
                                  final listTvShow = state.result;

                                  return Container(
                                    height: 150,
                                    child: ListView.builder(
                                      scrollDirection: Axis.horizontal,
                                      itemBuilder: (context, index) {
                                        final tvShow = dz.cast<TvShow>(listTvShow[index]);
                                        return Padding(
                                          padding: const EdgeInsets.all(4.0),
                                          child: InkWell(
                                            onTap: () {
                                              Navigator.pushReplacementNamed(
                                                context,
                                                TvShowDetailPage.ROUTE_NAME,
                                                arguments: tvShow.id,
                                              );
                                            },
                                            child: ClipRRect(
                                              borderRadius: BorderRadius.all(
                                                Radius.circular(8),
                                              ),
                                              child: CachedNetworkImage(
                                                imageUrl:
                                                'https://image.tmdb.org/t/p/w500${tvShow.posterPath}',
                                                placeholder: (context, url) =>
                                                    Center(
                                                      child:
                                                      CircularProgressIndicator(),
                                                    ),
                                                errorWidget:
                                                    (context, url, error) =>
                                                    Icon(Icons.error),
                                              ),
                                            ),
                                          ),
                                        );
                                      },
                                      itemCount: listTvShow.length,
                                    ),
                                  );
                                } else {
                                  return Container();
                                }
                              },
                            ),
                          ],
                        ),
                      ),
                    ),
                    Align(
                      alignment: Alignment.topCenter,
                      child: Container(
                        color: Colors.white,
                        height: 4,
                        width: 48,
                      ),
                    ),
                  ],
                ),
              );
            },
            // initialChildSize: 0.5,
            minChildSize: 0.25,
            // maxChildSize: 1.0,
          ),
        ),
        Padding(
          padding: const EdgeInsets.all(8.0),
          child: CircleAvatar(
            backgroundColor: kRichBlack,
            foregroundColor: Colors.white,
            child: IconButton(
              icon: Icon(Icons.arrow_back),
              onPressed: () {
                Navigator.pop(context);
              },
            ),
          ),
        )
      ],
    );
  }

  String _showGenres(List<Genre> genres) {
    String result = '';
    for (var genre in genres) {
      result += genre.name + ', ';
    }

    if (result.isEmpty) {
      return result;
    }

    return result.substring(0, result.length - 2);
  }

  String _showDurations(List<int> runtimes) {
    String duration = '';
    for (int i = 0; i < runtimes.length; i++) {
      if (i == runtimes.length - 1) {
        duration += _showDuration(runtimes[i]);
      } else {
        duration += _showDuration(runtimes[i]) + ', ';
      }
    }
    return duration;
  }

  String _showDuration(int runtime) {
    final int hours = runtime ~/ 60;
    final int minutes = runtime % 60;

    if (hours > 0) {
      return '${hours}h ${minutes}m';
    } else {
      return '${minutes}m';
    }
  }

  Widget _showEpisode(String explanation, Episode? episode) {
    if (episode != null) {
      return Container(
        padding: const EdgeInsets.only(bottom: 16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              explanation,
              style: kHeading6,
            ),
            Text(
              'Season ${episode.seasonNumber}',
              style: kBodyText,
            ),
            Text(
              'Episode ${episode.episodeNumber} - ${episode.name}',
              style: kBodyText,
            ),
          ],
        ),
      );
    } else {
      return Container();
    }
  }

  Widget _showSeasons(List<Season>? seasons) {
    if (seasons != null && seasons.isNotEmpty) {
      return Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            'Seasons',
            style: kHeading6,
          ),
          Container(
            height: 170,
            padding: const EdgeInsets.only(bottom: 16.0),
            child: ListView.builder(
              scrollDirection: Axis.vertical,
              itemBuilder: (context, index) {
                final season = seasons[index];
                return Container(
                  height: season.posterPath != null ? 150 : 70,
                  padding: const EdgeInsets.only(bottom: 12.0),
                  child: Row(
                    children: [
                      season.posterPath != null
                          ? CachedNetworkImage(
                              imageUrl: 'https://image.tmdb.org/t/p/w500${season.posterPath}',
                              placeholder: (context, url) =>
                                  Center(
                                    child: CircularProgressIndicator(),
                                  ),
                              errorWidget:
                                  (context, url, error) => Icon(Icons.error),
                            )
                          : Container()
                      ,
                      SizedBox(width: 12.0),
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            '${season.name}',
                            style: kBodyText,
                          ),
                          Text(
                            'Episode Count: ${season.episodeCount}',
                            style: kBodyText,
                          ),
                          Text(
                            'Air date: ${season.airDate}',
                            style: kBodyText,
                          ),
                        ],
                      ),
                    ],
                  ),
                );
              },
              itemCount: seasons.length,
            ),
          ),
        ],
      );
    } else {
      return Container();
    }
  }
}
