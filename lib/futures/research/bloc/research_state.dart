part of 'research_bloc.dart';

class ResearchState {
  final List<Question> step1;
  final List<Question> step2;
  final List<Question> step3;
  final List<Question> step4;
  final List<Question> step5;

  ResearchState({
    this.step1,
    this.step2,
    this.step3,
    this.step4,
    this.step5,
  });

  ResearchState copyWith({
    List<Question> step1,
    List<Question> step2,
    List<Question> step3,
    List<Question> step4,
    List<Question> step5,
  }) {
    return ResearchState(
      step1: step1 ?? this.step1,
      step2: step2 ?? this.step2,
      step3: step3 ?? this.step3,
      step4: step4 ?? this.step4,
      step5: step5 ?? this.step5,
    );
  }
}
