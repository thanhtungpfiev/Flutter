import 'dart:async';

import 'package:floor/floor.dart';
import 'package:sqflite/sqflite.dart' as sqflite;

import 'package:clean_architecture/features/daily_news/data/data_sources/local/DAO/article_dao.dart';
import 'package:clean_architecture/features/daily_news/data/models/article_model.dart';
part 'app_database.g.dart';

@Database(version: 1, entities: [ArticleModel])
abstract class AppDatase extends FloorDatabase {
  ArticleDao get articleDao;
}
