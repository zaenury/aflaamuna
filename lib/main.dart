import 'package:aflaamuna/bloc/theme_bloc.dart';
import 'package:aflaamuna/shared/shared.dart';
import 'bloc/blocs.dart';
import 'view/pages/pages.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
        providers: [
          BlocProvider(create: (_) => PageBloc()),
          BlocProvider(create: (_) => ThemeBloc()),
          BlocProvider(
              create: (_) =>
                  MoviePopularityBloc()..add(FetchMoviesPopularity())),
          BlocProvider(
              create: (_) =>
                  MovieReleaseDateBloc()..add(FetchMoviesReleaseDate())),
          BlocProvider(
              create: (_) => MovieVoteCountBloc()..add(FetchMoviesVoteCount()))
        ],
        child: BlocBuilder<ThemeBloc, ThemeState>(
          builder: (_, themeState) => MaterialApp(
              debugShowCheckedModeBanner: false,
              theme: ThemeData(
                scaffoldBackgroundColor: kBackgroundCOlor,
                primaryColor: kPrimaryColor,
                textTheme:
                    Theme.of(context).textTheme.apply(bodyColor: kTextColor),
                visualDensity: VisualDensity.adaptivePlatformDensity,
              ),
              home: Wrapper()),
        ));
  }
}
