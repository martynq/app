import 'package:dio/dio.dart';
import 'package:to_do_app_m/app/network_configuration/network_configuration.dart';
import 'package:to_do_app_m/model/todo.dart';

class DataService {
  final Dio dio = Dio(BaseOptions(baseUrl: basicUrl));
  final String _basePath = "todos";

  Future<List<Todo>> getData() async {
    Response response = await dio.get(
      _basePath,
    );
    return (response.data as List).map((e) => Todo.fromJson(e)).toList();
  }
}
