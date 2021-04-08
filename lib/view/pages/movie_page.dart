part of 'pages.dart';

class MoviePage extends StatefulWidget {
  @override
  _MoviePageState createState() => _MoviePageState();
}

class _MoviePageState extends State<MoviePage> {
  @override
  Widget build(BuildContext context) {
    // provide total height of screen
    Size size = MediaQuery.of(context).size;
    return Scaffold(
      resizeToAvoidBottomInset: false,
      appBar: AppBar(
        elevation: 0,
        leading: IconButton(
          icon: SvgPicture.asset("assets/icons/menu.svg"),
          onPressed: () {},
        ),
      ),
      // enable scrolling on small device
      body: SingleChildScrollView(
        child: Column(
          children: [
            HeaderWithSearch(size: size),
            TilteWithMoreButton(
              title: "Popularity",
              tap: () {},
            ),
            MoviePopularity(size: size),
            TilteWithMoreButton(
              title: "Release Date",
              tap: () {},
            ),
            MovieReleaseDate(size: size),
            TilteWithMoreButton(
              title: "Vote Count",
              tap: () {},
            ),
            MovieVoteCount(size: size),
          ],
        ),
      ),
    );
  }
}

class MovieVoteCount extends StatelessWidget {
  const MovieVoteCount({
    Key key,
    @required this.size,
  }) : super(key: key);

  final Size size;

  @override
  Widget build(BuildContext context) {
    return Container(
      height: size.height * 0.3,
      child: BlocBuilder<MovieVoteCountBloc, MovieState>(
        builder: (_, movieState) {
          if (movieState is MovieLoadedVoteCount) {
            List<Movie> movies = movieState.movies.sublist(0, 10);
            return ListView.builder(
              scrollDirection: Axis.horizontal,
              itemCount: movies.length,
              itemBuilder: (_, index) => Container(
                margin: EdgeInsets.only(
                    left: (index == 0) ? kDefaultPadding : 0,
                    right: (index == movies.length - 1)
                        ? kDefaultPadding
                        : (kDefaultPadding / 2)),
                child: MovieCard(
                  movies[index],
                  onTap: () {
                    context
                        .read<PageBloc>()
                        .add(GoToMovieDetailPage(movies[index]));
                  },
                ),
              ),
            );
          } else {
            return SpinKitFadingCircle(
              color: kSecondaryColor,
              size: 50,
            );
          }
        },
      ),
    );
  }
}

class MovieReleaseDate extends StatelessWidget {
  const MovieReleaseDate({
    Key key,
    @required this.size,
  }) : super(key: key);

  final Size size;

  @override
  Widget build(BuildContext context) {
    return Container(
      height: size.height * 0.3,
      child: BlocBuilder<MovieReleaseDateBloc, MovieState>(
        builder: (_, movieState) {
          if (movieState is MovieLoadedReleaseDate) {
            List<Movie> movies = movieState.movies.sublist(0, 10);
            return ListView.builder(
              scrollDirection: Axis.horizontal,
              itemCount: movies.length,
              itemBuilder: (_, index) => Container(
                margin: EdgeInsets.only(
                    left: (index == 0) ? kDefaultPadding : 0,
                    right: (index == movies.length - 1)
                        ? kDefaultPadding
                        : (kDefaultPadding / 2)),
                child: MovieCard(
                  movies[index],
                  onTap: () {
                    context
                        .read<PageBloc>()
                        .add(GoToMovieDetailPage(movies[index]));
                  },
                ),
              ),
            );
          } else {
            return SpinKitFadingCircle(
              color: kSecondaryColor,
              size: 50,
            );
          }
        },
      ),
    );
  }
}

class MoviePopularity extends StatelessWidget {
  const MoviePopularity({
    Key key,
    @required this.size,
  }) : super(key: key);

  final Size size;

  @override
  Widget build(BuildContext context) {
    return Container(
      height: size.height * 0.3,
      child: BlocBuilder<MoviePopularityBloc, MovieState>(
        builder: (_, movieState) {
          if (movieState is MovieLoadedPopularity) {
            List<Movie> movies = movieState.movies.sublist(0, 10);
            return ListView.builder(
              scrollDirection: Axis.horizontal,
              itemCount: movies.length,
              itemBuilder: (_, index) => Container(
                margin: EdgeInsets.only(
                    left: (index == 0) ? kDefaultPadding : 0,
                    right: (index == movies.length - 1)
                        ? kDefaultPadding
                        : (kDefaultPadding / 2)),
                child: MovieCard(
                  movies[index],
                  onTap: () {
                    context
                        .read<PageBloc>()
                        .add(GoToMovieDetailPage(movies[index]));
                  },
                ),
              ),
            );
          } else {
            return SpinKitFadingCircle(
              color: kSecondaryColor,
              size: 50,
            );
          }
        },
      ),
    );
  }
}

class TilteWithMoreButton extends StatelessWidget {
  const TilteWithMoreButton({
    Key key,
    this.tap,
    this.title,
  }) : super(key: key);
  final String title;
  final Function tap;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: kDefaultPadding),
      child: Row(
        children: [
          TitleWithCustomUnderline(text: title),
          Spacer(),
          ElevatedButton(
              style: TextButton.styleFrom(
                  backgroundColor: kPrimaryColor,
                  shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(20))),
              onPressed: tap,
              child: Text("More"))
        ],
      ),
    );
  }
}

class TitleWithCustomUnderline extends StatelessWidget {
  const TitleWithCustomUnderline({
    Key key,
    this.text,
  }) : super(key: key);

  final String text;
  @override
  Widget build(BuildContext context) {
    return Container(
      height: 24,
      child: Stack(
        children: [
          Padding(
            padding: const EdgeInsets.only(left: kDefaultPadding / 4),
            child: Text(
              text,
              style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
            ),
          ),
          Positioned(
            left: 0,
            right: 0,
            bottom: 0,
            child: Container(
              margin: EdgeInsets.only(right: kDefaultPadding / 4),
              height: 7,
              color: kPrimaryColor.withOpacity(0.2),
            ),
          )
        ],
      ),
    );
  }
}

class HeaderWithSearch extends StatelessWidget {
  const HeaderWithSearch({
    Key key,
    @required this.size,
  }) : super(key: key);

  final Size size;

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.only(bottom: kDefaultPadding * 2.5),
      // cover 20% of total height
      height: size.height * 0.2,
      child: Stack(
        children: [
          Container(
            padding: EdgeInsets.only(
                left: kDefaultPadding,
                right: kDefaultPadding,
                bottom: 36 + kDefaultPadding),
            height: size.height * 0.2 - 27,
            decoration: BoxDecoration(
              color: kPrimaryColor,
              borderRadius: BorderRadius.only(
                bottomLeft: Radius.circular(36),
                bottomRight: Radius.circular(36),
              ),
            ),
            child: Row(
              children: [
                Text(
                  'Aflaamuna',
                  style: Theme.of(context).textTheme.headline5.copyWith(
                      color: Colors.white, fontWeight: FontWeight.bold),
                ),
                Spacer(),
                Image.asset('assets/images/logo.png')
              ],
            ),
          ),
          Positioned(
            bottom: 0,
            left: 0,
            right: 0,
            child: Container(
              alignment: Alignment.center,
              margin: EdgeInsets.symmetric(horizontal: kDefaultPadding),
              padding: EdgeInsets.symmetric(horizontal: kDefaultPadding),
              height: 54,
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(20),
                boxShadow: [
                  BoxShadow(
                      offset: Offset(0, 10),
                      blurRadius: 50,
                      color: kPrimaryColor.withOpacity(0.25)),
                ],
              ),
              child: Row(
                children: [
                  Expanded(
                    child: TextField(
                      onChanged: (value) {},
                      decoration: InputDecoration(
                        hintText: "Search",
                        hintStyle: TextStyle(
                          color: kPrimaryColor.withOpacity(0.5),
                        ),
                        enabledBorder: InputBorder.none,
                        focusedBorder: InputBorder.none,
                      ),
                    ),
                  ),
                  SvgPicture.asset('assets/icons/search.svg'),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
