part of 'widgets.dart';

class GenreCard extends StatelessWidget {
  final MovieDetail movieDetail;
  final String genre;

  const GenreCard({Key key, this.movieDetail, this.genre}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return Container(
      alignment: Alignment.center,
      margin: EdgeInsets.only(left: kDefaultPadding),
      padding: EdgeInsets.symmetric(
        horizontal: kDefaultPadding,
        vertical: kDefaultPadding / 5,
      ),
      decoration: BoxDecoration(
        border: Border.all(color: Colors.black26),
        borderRadius: BorderRadius.circular(20),
      ),
      child: Text(
        genre,
        style: TextStyle(color: kTextColor.withOpacity(0.8), fontSize: 12),
      ),
    );
  }
}
