import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:khaosat/app.dart';
import 'package:khaosat/core/bloc/master_bloc.dart';
import 'package:khaosat/routes.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  final application = Application();
  await application.initialize();

  runApp(MultiBlocProvider(
    providers: [
      BlocProvider<MasterBloc>.value(value: application.masterBloc),
    ],
    child: MyApp(application: application),
  ));
}

class MyApp extends StatelessWidget {
  final Application application;

  const MyApp({Key key, this.application}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
        color: Colors.blue,
        theme: ThemeData(
          brightness: Brightness.light,
          primaryColor: Colors.blue,
        ),
        onGenerateRoute: routes(application: application),
        debugShowCheckedModeBanner: false);
  }
}
