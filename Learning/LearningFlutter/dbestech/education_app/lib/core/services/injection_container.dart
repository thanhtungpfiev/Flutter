import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:education_app/firebase_options.dart';
import 'package:education_app/src/authentication/data/data_sources'
    '/authentication_remote_data_source.dart';
import 'package:education_app/src/authentication/data/repositories/authentication_repository_impl.dart';
import 'package:education_app/src/authentication/domain/repositories/authentication_repository.dart';
import 'package:education_app/src/authentication/domain/usecases/forgot_password_usecase.dart';
import 'package:education_app/src/authentication/domain/usecases/signin_usecase.dart';
import 'package:education_app/src/authentication/domain/usecases/signup_usecase.dart';
import 'package:education_app/src/authentication/domain/usecases/update_user_usecase.dart';
import 'package:education_app/src/authentication/presentation/bloc/authentication_bloc.dart';
import 'package:education_app/src/course/data/data_sources/course_remote_data_source.dart';
import 'package:education_app/src/course/data/repositories/course_repository_impl.dart';
import 'package:education_app/src/course/domain/repositories/course_repository.dart';
import 'package:education_app/src/course/domain/usecases/add_course_usecase.dart';
import 'package:education_app/src/course/domain/usecases/get_courses_usecase.dart';
import 'package:education_app/src/course/presentation/cubit/course_cubit.dart';
import 'package:education_app/src/on_boarding/data/data_sources'
    '/on_boarding_local_data_source.dart';
import 'package:education_app/src/on_boarding/data/repositories/on_boarding_repository_impl.dart';
import 'package:education_app/src/on_boarding/domain/repositories/on_boarding_repository.dart';
import 'package:education_app/src/on_boarding/domain/usecases/cache_first_timer_usecase.dart';
import 'package:education_app/src/on_boarding/domain/usecases/check_if_user_is_first_timer_usecase.dart';
import 'package:education_app/src/on_boarding/presentation/cubit/on_boarding_cubit.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:get_it/get_it.dart';
import 'package:shared_preferences/shared_preferences.dart';

part 'injection_container.main.dart';
