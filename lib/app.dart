import 'package:dio/dio.dart';
import 'package:khaosat/core/bloc/master_bloc.dart';
import 'package:khaosat/data/data.dart';

class Application {
  MasterBloc masterBloc;
  Repository repository;

  Future<void> initialize() async {
    masterBloc = MasterBloc();
    final api = Api(Dio(BaseOptions(baseUrl: 'https://google.com')));
    repository = Repository(api);
  }
}
