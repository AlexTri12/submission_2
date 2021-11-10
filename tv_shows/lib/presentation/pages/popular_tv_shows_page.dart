import 'package:core/core.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:tv_shows/domain/entities/tv_show.dart';
import 'package:tv_shows/presentation/bloc/tv_show_popular_bloc.dart';
import 'package:tv_shows/presentation/widgets/tv_show_card_list.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:dartz/dartz.dart' as dz;

class PopularTvShowsPage extends StatefulWidget {
  static const ROUTE_NAME = '/popular-tv-show';

  @override
  _PopularTvShowsPageState createState() => _PopularTvShowsPageState();
}

class _PopularTvShowsPageState extends State<PopularTvShowsPage> {
  @override
  void initState() {
    super.initState();
    context.read<TvShowPopularBloc>().add(FetchPopular());
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Popular TvShows'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: BlocBuilder<TvShowPopularBloc, PopularState>(
          builder: (context, state) {
            if (state is PopularLoading) {
              return Center(
                child: CircularProgressIndicator(),
              );
            } else if (state is PopularHasData) {
              final listTvShow = state.result;
              return ListView.builder(
                itemBuilder: (context, index) {
                  final tvShow = dz.cast<TvShow>(listTvShow[index]);
                  return TvShowCard(tvShow);
                },
                itemCount: listTvShow.length,
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
      ),
    );
  }
}
