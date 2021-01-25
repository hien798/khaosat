import 'package:bloc/bloc.dart';

part 'progress_state.dart';

class ProgressBloc extends Cubit<ProgressState> {

  ProgressBloc() : super(ProgressState());

  void onUpdateStatus(int step, bool status) async {
    print('step: $step: $status');
    var newState;
    switch (step) {
      case 1:
        newState = state.copyWith(step1: status);
        break;
      case 2:
        newState = state.copyWith(step2: status);
        break;
      case 3:
        newState = state.copyWith(step3: status);
        break;
      case 4:
        newState = state.copyWith(step4: status);
        break;
      case 5:
        newState = state.copyWith(step5: status);
        break;
      default:
    }
    emit(newState);
  }
}
