// Mocks generated by Mockito 5.4.3 from annotations
// in movie_app/test/data/repositories/movie_repository_impl_test.dart.
// Do not manually edit this file.

// ignore_for_file: no_leading_underscores_for_library_prefixes
import 'dart:async' as _i3;

import 'package:mockito/mockito.dart' as _i1;
import 'package:movie_app/data/datasources/remote/movie_remote_data_source.dart'
    as _i2;
import 'package:movie_app/data/models/movie_model.dart' as _i4;

// ignore_for_file: type=lint
// ignore_for_file: avoid_redundant_argument_values
// ignore_for_file: avoid_setters_without_getters
// ignore_for_file: comment_references
// ignore_for_file: deprecated_member_use
// ignore_for_file: deprecated_member_use_from_same_package
// ignore_for_file: implementation_imports
// ignore_for_file: invalid_use_of_visible_for_testing_member
// ignore_for_file: prefer_const_constructors
// ignore_for_file: unnecessary_parenthesis
// ignore_for_file: camel_case_types
// ignore_for_file: subtype_of_sealed_class

/// A class which mocks [MovieRemoteDataSource].
///
/// See the documentation for Mockito's code generation for more information.
class MockMovieRemoteDataSource extends _i1.Mock
    implements _i2.MovieRemoteDataSource {
  @override
  _i3.Future<List<_i4.MovieModel>> getTrendingMovies() => (super.noSuchMethod(
        Invocation.method(
          #getTrendingMovies,
          [],
        ),
        returnValue: _i3.Future<List<_i4.MovieModel>>.value(<_i4.MovieModel>[]),
        returnValueForMissingStub:
            _i3.Future<List<_i4.MovieModel>>.value(<_i4.MovieModel>[]),
      ) as _i3.Future<List<_i4.MovieModel>>);

  @override
  _i3.Future<List<_i4.MovieModel>> searchMovies(String? query) =>
      (super.noSuchMethod(
        Invocation.method(
          #searchMovies,
          [query],
        ),
        returnValue: _i3.Future<List<_i4.MovieModel>>.value(<_i4.MovieModel>[]),
        returnValueForMissingStub:
            _i3.Future<List<_i4.MovieModel>>.value(<_i4.MovieModel>[]),
      ) as _i3.Future<List<_i4.MovieModel>>);

  @override
  _i3.Future<List<_i4.MovieModel>> getPopularMovies() => (super.noSuchMethod(
        Invocation.method(
          #getPopularMovies,
          [],
        ),
        returnValue: _i3.Future<List<_i4.MovieModel>>.value(<_i4.MovieModel>[]),
        returnValueForMissingStub:
            _i3.Future<List<_i4.MovieModel>>.value(<_i4.MovieModel>[]),
      ) as _i3.Future<List<_i4.MovieModel>>);
}