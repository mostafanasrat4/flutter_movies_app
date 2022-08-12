import 'dart:convert';

import 'package:flutter_movies_app/models/movie.dart';
import 'package:http/http.dart' as http;


class ApiService{

  Future<List<Movie>>   FetchPopularMovies() async {
  final response = await http.get(Uri.parse('https://api.themoviedb.org/3/movie/popular?api_key=e304808cb17a2b16cdbb66a01589d260'));

  if (response.statusCode == 200) {
    print('response.statusCode = 200');
    
    ApiResponse apiResponse =  ApiResponse.fromJson(jsonDecode(response.body));
    print(apiResponse.results![0].title);
    return apiResponse.results!.toList();
  } else {
    throw Exception('Failed to load ApiResponse');
  }
} 
}