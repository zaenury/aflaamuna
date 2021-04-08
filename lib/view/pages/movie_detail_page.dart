part of 'pages.dart';

class MovieDetailPage extends StatefulWidget {
  final Movie movie;

  MovieDetailPage(this.movie);

  @override
  _MovieDetailPageState createState() => _MovieDetailPageState();
}

class _MovieDetailPageState extends State<MovieDetailPage> {
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
          future: MovieServices.getDetails(widget.movie),
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

class BackrdopAndRating extends StatefulWidget {
  const BackrdopAndRating({
    Key key,
    @required this.size,
    @required this.movieDetail,
  }) : super(key: key);

  final Size size;
  final MovieDetail movieDetail;

  @override
  _BackrdopAndRatingState createState() => _BackrdopAndRatingState();
}

class _BackrdopAndRatingState extends State<BackrdopAndRating> {
  IconData firstIcon = Icons.favorite;

  bool isFavActive = false;

  Future<bool> saveDataFav() async {
    SharedPreferences pref = await SharedPreferences.getInstance();
    return pref.setBool("isFav", isFavActive);
  }

  Future<bool> loadDataFav() async {
    SharedPreferences preferences = await SharedPreferences.getInstance();
    return preferences.getBool("isFav") ?? true;
  }

  setData() async {
    loadDataFav().then((value) {
      setState(() {
        isFavActive = value;
        setIcon();
      });
    });
  }

  setIcon() async {
    if (isFavActive) {
      firstIcon = Icons.favorite;
    } else {
      firstIcon = Icons.favorite_border;
    }
  }

  @override
  void initState() {
    setData();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      height: widget.size.height * 0.4,
      child: Stack(
        children: [
          Container(
            height: widget.size.height * 0.4 - 50,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.only(bottomLeft: Radius.circular(50)),
              image: DecorationImage(
                  image: NetworkImage(
                      imageBaseUrl + "w780" + widget.movieDetail.backdrop),
                  fit: BoxFit.cover),
            ),
          ),
          Positioned(
            bottom: 0,
            right: 0,
            child: Container(
              height: 100,
              width: widget.size.width * 0.9,
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
                      Text('${widget.movieDetail.voteAverage} / 10'),
                      Text('${widget.movieDetail.voteCount}'),
                    ],
                  ),
                  SizedBox(
                    height: 64,
                    width: 64,
                    child: IconButton(
                      icon: Icon(
                        firstIcon,
                        size: 30,
                        color: Colors.red,
                      ),
                      onPressed: () {
                        setState(() {
                          if (isFavActive) {
                            isFavActive = false;
                            setIcon();
                            saveDataFav();
                          } else {
                            isFavActive = true;
                            setIcon();
                            saveDataFav();
                          }
                        });
                      },
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
                        var url = '${widget.movieDetail.homePage}';
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
