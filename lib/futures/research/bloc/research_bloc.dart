import 'package:bloc/bloc.dart';
import 'package:khaosat/data/data.dart';
import 'package:khaosat/data/models/question.dart';

part 'research_state.dart';

class ResearchBloc extends Cubit<ResearchState> {
  final Repository repository;

  ResearchBloc(this.repository) : super(ResearchState());

  void onLoadQuestions(int step) async {
    final questions = await repository.loadQuestions(step);
    var newState;
    switch (step) {
      case 1:
        newState = state.copyWith(step1: questions);
        break;
      case 2:
        newState = state.copyWith(step2: questions);
        break;
      case 3:
        newState = state.copyWith(step3: questions);
        break;
      case 4:
        newState = state.copyWith(step4: questions);
        break;
      case 5:
        newState = state.copyWith(step5: questions);
        break;
      default:
    }
    emit(newState);
  }
}
