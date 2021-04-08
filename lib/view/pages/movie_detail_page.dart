part of 'pages.dart';

class MovieDetailPage extends StatelessWidget {
  final Movie movie;

  MovieDetailPage(this.movie);

  @override
  Widget build(BuildContext context) {
    MovieDetail movieDetail;
    Size size = MediaQuery.of(context).size;

    return WillPopScope(
      onWillPop: () async {
        context.read<PageBloc>().add(GoToMainPage());
        return;
      },
      child: Scaffold(
        body: FutureBuilder(
          future: MovieServices.getDetails(movie),
          builder: (_, snapshot) {
            if (snapshot.hasData) {
              movieDetail = snapshot.data;
              return SingleChildScrollView(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    BackrdopAndRating(size: size, movieDetail: movieDetail),
                    SizedBox(
                      height: kDefaultPadding / 2,
                    ),
                    Padding(
                      padding: EdgeInsets.all(kDefaultPadding),
                      child: Row(
                        children: [
                          Expanded(
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  movieDetail.title,
                                  style: Theme.of(context).textTheme.headline5,
                                ),
                                SizedBox(
                                  width: kDefaultPadding / 2,
                                ),
                                Row(
                                  children: [
                                    Text('${movieDetail.releaseDate}'),
                                    SizedBox(
                                      width: kDefaultPadding,
                                    ),
                                    Text(
                                      '${movieDetail.changeRunTimeFormat}',
                                    ),
                                  ],
                                ),
                              ],
                            ),
                          ),
                        ],
                      ),
                    ),
                    Padding(
                      padding:
                          EdgeInsets.symmetric(vertical: kDefaultPadding / 2),
                      child: SizedBox(
                        height: 36,
                        child: ListView.builder(
                          scrollDirection: Axis.horizontal,
                          itemCount: movieDetail.genres.length,
                          itemBuilder: (context, index) =>
                              GenreCard(genre: movieDetail.genres[index]),
                        ),
                      ),
                    ),
                    Padding(
                      padding: EdgeInsets.symmetric(
                          horizontal: kDefaultPadding,
                          vertical: kDefaultPadding / 2),
                      child: Text(
                        "Overview",
                        style: Theme.of(context).textTheme.headline5,
                      ),
                    ),
                    Padding(
                      padding: EdgeInsets.symmetric(
                        horizontal: kDefaultPadding,
                      ),
                      child: Text(
                        movieDetail.overview,
                        style: TextStyle(color: Colors.black),
                      ),
                    ),
                    Padding(
                      padding: EdgeInsets.symmetric(
                          horizontal: kDefaultPadding,
                          vertical: kDefaultPadding / 2),
                      child: Text(
                        "Original Language",
                        style: Theme.of(context).textTheme.headline5,
                      ),
                    ),
                    Padding(
                      padding: EdgeInsets.symmetric(
                        horizontal: kDefaultPadding,
                      ),
                      child: Text(
                        movieDetail.allSpokenlanguages,
                        style: TextStyle(color: Colors.black),
                      ),
                    ),
                    Padding(
                      padding: EdgeInsets.symmetric(
                          horizontal: kDefaultPadding,
                          vertical: kDefaultPadding / 2),
                      child: Text(
                        "Revenue",
                        style: Theme.of(context).textTheme.headline5,
                      ),
                    ),
                    Padding(
                      padding: EdgeInsets.symmetric(
                        horizontal: kDefaultPadding,
                      ),
                      child: (movieDetail.revenue == 0.00)
                          ? Text('-')
                          : Text(
                              NumberFormat.currency(locale: 'en', symbol: "\$ ")
                                  .format(movieDetail.revenue),
                              style: TextStyle(color: Colors.black),
                            ),
                    ),
                    Padding(
                      padding: EdgeInsets.symmetric(
                          horizontal: kDefaultPadding,
                          vertical: kDefaultPadding / 2),
                      child: Text(
                        "Production Companies",
                        style: Theme.of(context).textTheme.headline5,
                      ),
                    ),
                    Padding(
                      padding: EdgeInsets.symmetric(
                        horizontal: kDefaultPadding,
                      ),
                      child: Text(
                        movieDetail.allProductionCompanies,
                        style: TextStyle(color: Colors.black),
                      ),
                    ),
                  ],
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
      ),
    );
  }
}

class BackrdopAndRating extends StatelessWidget {
  const BackrdopAndRating({
    Key key,
    @required this.size,
    @required this.movieDetail,
  }) : super(key: key);

  final Size size;
  final MovieDetail movieDetail;

  @override
  Widget build(BuildContext context) {
    return Container(
      height: size.height * 0.4,
      child: Stack(
        children: [
          Container(
            height: size.height * 0.4 - 50,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.only(bottomLeft: Radius.circular(50)),
              image: DecorationImage(
                  image: NetworkImage(
                      imageBaseUrl + "w780" + movieDetail.backdrop),
                  fit: BoxFit.cover),
            ),
          ),
          Positioned(
            bottom: 0,
            right: 0,
            child: Container(
              height: 100,
              width: size.width * 0.9,
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.only(
                  bottomLeft: Radius.circular(50),
                  topLeft: Radius.circular(50),
                ),
                boxShadow: [
                  BoxShadow(
                      offset: Offset(0, 5),
                      blurRadius: 50,
                      color: kPrimaryColor.withOpacity(0.25)),
                ],
              ),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      SvgPicture.asset('assets/icons/star_fill.svg'),
                      Text('${movieDetail.voteAverage} / 10'),
                      Text('${movieDetail.voteCount}'),
                    ],
                  ),
                  SizedBox(
                    height: 54,
                    width: 54,
                    child: ElevatedButton(
                      style: TextButton.styleFrom(
                        backgroundColor: kPrimaryColor,
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(20),
                        ),
                      ),
                      onPressed: () {},
                      child: Icon(
                        Icons.favorite,
                        size: 18,
                        color: Colors.white,
                      ),
                    ),
                  ),
                  SizedBox(
                    height: 54,
                    width: 54,
                    child: ElevatedButton(
                      style: TextButton.styleFrom(
                        backgroundColor: kPrimaryColor,
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(20),
                        ),
                      ),
                      onPressed: () async {
                        var url = '${movieDetail.homePage}';
                        if (await canLaunch(url)) {
                          await launch(url);
                        } else {
                          throw 'Could not launch $url';
                        }
                      },
                      child: Icon(
                        Icons.home,
                        size: 18,
                        color: Colors.white,
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
          SafeArea(child: BackButton()),
        ],
      ),
    );
  }
}
