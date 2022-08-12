import 'package:flutter/material.dart';
import 'package:flutter/src/foundation/key.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:badges/badges.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter_movies_app/api/api_service.dart';
import 'package:flutter_movies_app/models/movie.dart';
import 'package:flutter_movies_app/screens/movie_details_screen.dart';
import 'package:masonry_grid/masonry_grid.dart';
import 'package:favorite_button/favorite_button.dart';

class HomePage extends StatefulWidget {
  const HomePage({Key? key, required this.title}) : super(key: key);

  final String title;

  @override
  State<HomePage> createState() => _HomePageState();
}


class _HomePageState extends State<HomePage> {

  List<Movie> ?popular_movies = [];
  List top_rated_movies = [1,2,2,2,5,5,8];
  late Future<ApiResponse> apiResponse;
  
  
  void fetch()async{
    popular_movies=await  ApiService().FetchPopularMovies(); 
    setState(() {
    });
  }
  @override
  void initState() {
    fetch();
    super.initState();
    
    //print(apiResponse.);
    /*if(apiResponse != null){
      popular_movies = apiResponse;
    }
    else{
      popular_movies = [];
    }*/
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color.fromARGB(255, 41, 40, 40),
      appBar: AppBar(
        title: Text(
          widget.title,
          style: const TextStyle(
            color: Colors.grey,
          ),),
        backgroundColor:Color.fromARGB(255, 41, 40, 40),
        elevation: 0.0,
        actions: [
          IconButton(
            onPressed:() => {},
            icon: Icon(
              Icons.search,
              color: Colors.grey,),
          ),
          IconButton(
            onPressed: () => {},
            icon: Badge(
              child: Icon(
                Icons.favorite,
                color: Colors.red),
              badgeContent: Text(
                "3",
                style: TextStyle(
                  color: Colors.white,
                ),),
            )
          )
        ],
      ),
      body: SingleChildScrollView(
        physics: ScrollPhysics(),
        scrollDirection: Axis.vertical,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            //Text(popular_movies!.length.toString()),
            CarouselSlider(
              options: CarouselOptions(
                  height: 250.0,
                  autoPlay: true,
                  autoPlayAnimationDuration: Duration(milliseconds: 500),
                  autoPlayInterval: Duration(seconds: 3),
                  //enlargeCenterPage: true,
              ),
              items: popular_movies?.map((movie) {
                return Builder(
                  builder: (BuildContext context) {
                    return _createTopRatedMovieWidget(context, movie);
                  },
                );
              }).toList(),
            ),

            const SizedBox(height: 20,),

            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 10.0),
              child: MasonryGrid(
                mainAxisSpacing: 10.0,
                crossAxisSpacing: 10.0,
                column: 2,
                children: List.generate(popular_movies!.length, (i) =>
                      _createPopularMovieWidget(context, popular_movies![i]),
                )
              ),
            ),
            
          ],
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
    onTap: () {
      Navigator.push(
        context,
        MaterialPageRoute(builder: (context) => MovieDetailsPage(movie: movie)),
      );
    },
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


