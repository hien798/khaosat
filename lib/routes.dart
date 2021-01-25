import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:khaosat/app.dart';
import 'package:khaosat/futures/home/home.dart';
import 'package:khaosat/futures/research/bloc/progress_bloc.dart';
import 'package:khaosat/futures/research/bloc/research_bloc.dart';
import 'package:khaosat/futures/research/screen/research.dart';
import 'package:khaosat/futures/result/result.dart';
import 'package:khaosat/futures/splash/splash.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';

var bootStage = 1;

RouteFactory routes({@required Application application}) {
  return (RouteSettings settings) {
    var fullScreen = false;
    Widget screen;

    if (bootStage == 1) {
      bootStage = 2;
      return PageRouteBuilder(
        pageBuilder: (_, __, ___) => SplashScreen(),
      );
    }
    final arguments = settings.arguments as Map<String, dynamic> ?? {};
    switch (settings.name) {
      case HomeScreen.route:
        fullScreen = true;
        screen = HomeScreen();
        break;
      case ResearchScreen.route:
        fullScreen = true;
        screen = MultiBlocProvider(
          providers: [
            BlocProvider<ResearchBloc>.value(
                value: ResearchBloc(application.repository)),
            BlocProvider<ProgressBloc>.value(value: ProgressBloc()),
          ],
          child: ResearchScreen(),
        );
        break;
      case ResultScreen.route:
        fullScreen = true;
        final score = arguments['score'];
        screen = ResultScreen(score: score);
        break;
    }

    if (bootStage == 2) {
      bootStage = 3;

      return PageRouteBuilder(
        pageBuilder: (BuildContext context, _, __) {
          return screen;
        },
        transitionDuration: const Duration(milliseconds: 500),
      );
    }

    if (fullScreen) {
      return MaterialPageRoute(
        builder: (_) => screen,
        fullscreenDialog: true,
      );
    }

    return PageRouteBuilder(pageBuilder: (BuildContext context, _, __) {
      return screen;
    }, transitionsBuilder: (_, Animation<double> animation, __, Widget child) {
      return FadeTransition(opacity: animation, child: child);
    });
  };
}
