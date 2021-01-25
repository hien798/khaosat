import 'package:bloc/bloc.dart';

part 'master_state.dart';

class MasterBloc extends Cubit<MasterState> {
  MasterBloc() : super(MasterState());
}
