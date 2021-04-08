part of 'pages.dart';

class Wrapper extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return BlocBuilder<PageBloc, PageState>(
      builder: (_, pageState) => (pageState is OnMainPage)
          ? MoviePage()
          : (pageState is OnMovieDetailPage)
              ? MovieDetailPage(pageState.movie)
              : MoviePage(),
    );
  }
}
