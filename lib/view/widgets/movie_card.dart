part of 'widgets.dart';

class MovieCard extends StatelessWidget {
  final Movie movie;
  final Function onTap;

  MovieCard(this.movie, {this.onTap});

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return GestureDetector(
      onTap: () {
        if (onTap != null) {
          onTap();
        }
      },
      child: Column(
        children: [
          Container(
            margin: EdgeInsets.only(top: kDefaultPadding / 2),
            height: 160,
            width: size.width * 0.3,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.only(
                topRight: Radius.circular(kDefaultPadding / 2),
                topLeft: Radius.circular(kDefaultPadding / 2),
              ),
              image: DecorationImage(
                  image: NetworkImage(imageBaseUrl + "w780" + movie.posterPath),
                  fit: BoxFit.cover),
            ),
          ),
          Container(
            width: size.width * 0.3,
            height: 50,
            padding: EdgeInsets.all(kDefaultPadding / 2),
            child: Text(
              movie.title,
              style: TextStyle(
                color: kPrimaryColor,
                fontSize: 12,
              ),
              maxLines: 2,
              overflow: TextOverflow.ellipsis, // if text offside to be ..
            ),
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.only(
                bottomRight: Radius.circular(kDefaultPadding / 2),
                bottomLeft: Radius.circular(kDefaultPadding / 2),
              ),
              boxShadow: [
                BoxShadow(
                    offset: Offset(0, 10),
                    blurRadius: 50,
                    color: kPrimaryColor.withOpacity(0.2))
              ],
            ),
          )
        ],
      ),
    );
  }
}
