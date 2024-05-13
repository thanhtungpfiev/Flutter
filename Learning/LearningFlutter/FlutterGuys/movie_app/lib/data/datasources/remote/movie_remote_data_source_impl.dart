import 'dart:convert';
import 'dart:io';

import 'package:http/http.dart' as http;

import '../../../core/errors/server_exception.dart';
import '../../models/movie_model.dart';
import 'movie_remote_data_source.dart';

class MovieRemoteDataSourceImpl implements MovieRemoteDataSource {
  final http.Client client;
  static const baseUrl = 'https://api.themoviedb.org/3';
  static const apiKey = '360f8f47db5a601815eae0431db22ba5';

  MovieRemoteDataSourceImpl({required this.client});

  @override
  Future<List<MovieModel>> getPopularMovies() async {
    final response =
        await client.get(Uri.parse('$baseUrl/movie/popular?api_key=$apiKey'));
    if (response.statusCode == HttpStatus.ok) {
      final responseBody = json.decode(response.body);
      final List<MovieModel> movies = (responseBody['results'] as List)
          .map((e) => MovieModel.fromMap(e))
          .toList();
      return movies;
    } else {
      throw ServerException();
    }
  }

  @override
  Future<List<MovieModel>> getTrendingMovies() async {
    final response = await client
        .get(Uri.parse('$baseUrl/trending/movie/day?api_key=$apiKey'));
    if (response.statusCode == HttpStatus.ok) {
      final responseBody = json.decode(response.body);
      final List<MovieModel> movies = (responseBody['results'] as List)
          .map((e) => MovieModel.fromMap(e))
          .toList();
      return movies;
    } else {
      throw ServerException();
    }
  }

  @override
  Future<List<MovieModel>> searchMovies(String query) async {
    final response = await client
        .get(Uri.parse('$baseUrl/search/movie?query=$query&api_key=$apiKey'));
    if (response.statusCode == HttpStatus.ok) {
      final responseBody = json.decode(response.body);
      final List<MovieModel> movies = (responseBody['results'] as List)
          .map((e) => MovieModel.fromMap(e))
          .toList();
      return movies;
    } else {
      throw ServerException();
    }
  }
}
