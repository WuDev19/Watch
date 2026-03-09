import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:injectable/injectable.dart';

@injectable
class ScalePageBloc extends Cubit<double>{
  ScalePageBloc() : super(0.0);

  void scalePage(double currentPage){
    emit(currentPage);
  }

}