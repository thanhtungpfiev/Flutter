import '../entities/course.dart';
import '../utils/http_util.dart';

class CourseApi {
  static Future<CourseListResponseEntity> courseList() async {
    var response = await HttpUtil().post('api/courseList');
    return CourseListResponseEntity.fromJson(response);
  }

  static Future<CourseDetailResponseEntity> courseDetail(
      {CourseRequestEntity? params}) async {
    var response = await HttpUtil()
        .post('api/courseDetail', queryParameters: params?.toJson());
    return CourseDetailResponseEntity.fromJson(response);
  }
}
