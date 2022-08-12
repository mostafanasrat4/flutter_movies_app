import 'package:flutter/material.dart';
import 'package:flutter/src/foundation/key.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:badges/badges.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter_movies_app/api/api_service.dart';
import 'package:flutter_movies_app/models/movie.dart';
import 'package:masonry_grid/masonry_grid.dart';
import 'package:favorite_button/favorite_button.dart';

class MovieDetailsPage extends StatefulWidget {
  const MovieDetailsPage({Key? key, required this.movie}) : super(key: key);

  final Movie movie;

  @override
  State<MovieDetailsPage> createState() => _MovieDetailsPageState(movie);
}


class _MovieDetailsPageState extends State<MovieDetailsPage> {

  _MovieDetailsPageState(this.movie);

  final Movie movie;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          'Egy Dead',
          style: const TextStyle(
            color: Colors.grey,
          ),),
        backgroundColor:Color.fromARGB(255, 41, 40, 40),
        elevation: 0.0,
      ),
      backgroundColor: Color.fromARGB(255, 41, 40, 40),
      body: SingleChildScrollView(
        physics: ScrollPhysics(),
        scrollDirection: Axis.vertical,
        child: Padding(
          padding: EdgeInsets.all(15.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              Container(
                height: 500,
                width: MediaQuery.of(context).size.width,
                decoration: BoxDecoration(
                  borderRadius: const BorderRadius.all(Radius.circular(20.0)),
                  image: DecorationImage(
                    fit: BoxFit.fill,
                    image: NetworkImage('https://image.tmdb.org/t/p/original${movie.posterPath}'),
                  ),
                ),
              ),

              Padding(
                padding: EdgeInsets.symmetric(vertical: 10),
                child: Text(
                  textAlign: TextAlign.left,
                  '${movie.title}',
                  style: const TextStyle(
                      color: Colors.white,
                      fontSize: 24,
                      fontWeight: FontWeight.bold,
                  ),
                  maxLines: 2,
                  overflow: TextOverflow.ellipsis,
              ),),
              Padding(
                padding: EdgeInsets.symmetric(vertical: 10),
                child: Text(
                  textAlign: TextAlign.left,
                  '${movie.releaseDate}',
                  style: const TextStyle(
                      color: Colors.grey,
                      fontSize: 18,
                  ),
                ),
              ),

              Padding(
                padding: EdgeInsets.symmetric(vertical: 10),
                child: Text(
                  textAlign: TextAlign.left,
                  '${movie.overview}',
                  style: const TextStyle(
                      color: Colors.grey,
                      fontSize: 18,
                  ),
                ),
              ),
              
            ],
          ),
        )
      ),
    );
    
  }
}     


Widget _createTopRatedMovieWidget(var context, Movie movie){
  return Container(
    //color: Colors.green,
    width: MediaQuery.of(context).size.width,
    height: MediaQuery.of(context).size.height,
    margin: EdgeInsets.symmetric(horizontal: 10),
    child: Column(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Container(
          height: 200,
          width: MediaQuery.of(context).size.width,
          decoration: BoxDecoration(
            borderRadius: BorderRadius.all(Radius.circular(6.0)),
            image: DecorationImage(
              fit: BoxFit.fill,
              image: NetworkImage('https://image.tmdb.org/t/p/original${movie.backdropPath}'),
            ),
          ),
        ),
        Text(
          '${movie.title}',
          style: const TextStyle(
            color: Colors.grey,
            fontSize: 20,
            fontWeight: FontWeight.bold,
          ),
        ),
      ],
    ),
  );
}

Widget _createPopularMovieWidget(var context, Movie movie){
  return InkWell(
    onTap: () => {},
    child: Stack(
      children: [
        Container(
          decoration: const BoxDecoration(
            color: Color.fromARGB(255, 29, 28, 28),
            borderRadius: BorderRadius.all(Radius.circular(6.0)),
          ),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              Container(
                height: 250,
                width: MediaQuery.of(context).size.width,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.all(Radius.circular(4.0)),
                  image: DecorationImage(
                    fit: BoxFit.fill,
                    image: NetworkImage('https://image.tmdb.org/t/p/original${movie.posterPath}'),
                  ),
                ),
              ),
              Text(
                '${movie.title}',
                style: const TextStyle(
                  color: Colors.grey,
                  fontSize: 24,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ],
          ),
          
        ),
        Positioned(
          top: 10.0,
          right: 10.0,
          child: CircleAvatar(
            radius: 20,
            backgroundColor: Colors.grey,
            child: FavoriteButton(
            iconSize: 30,
            valueChanged: (_isFavorite) {
              //print('Is Favorite $_isFavorite)');
            },
          ),
          )
        ),
      ],
    )
  );

}


