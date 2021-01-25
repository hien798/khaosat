part of 'progress_bloc.dart';

class ProgressState {
  final bool step1;
  final bool step2;
  final bool step3;
  final bool step4;
  final bool step5;

  ProgressState({
    this.step1,
    this.step2,
    this.step3,
    this.step4,
    this.step5,
  });

  ProgressState copyWith({
    bool step1,
    bool step2,
    bool step3,
    bool step4,
    bool step5,
  }) {
    return ProgressState(
      step1: step1 ?? this.step1,
      step2: step2 ?? this.step2,
      step3: step3 ?? this.step3,
      step4: step4 ?? this.step4,
      step5: step5 ?? this.step5,
    );
  }
}
