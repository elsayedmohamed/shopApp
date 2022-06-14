import 'package:bloc/bloc.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shop/modules/layout/shop_app/search/cubit/states.dart';
import 'package:shop/shared/network/remote/dio_helper.dart';
import 'package:shop/shared/network/remote/end_point.dart';
import 'package:shop/styles/constant.dart';

import '../../../../../models/search_model.dart';

class SearchCubit extends Cubit<SearchStates> {
  SearchCubit() : super(SearchInitialState());

  static SearchCubit get(context) => BlocProvider.of(context);

  SearchModel? model;

  void Search({
    required String text,
  }) {
    emit(SearchLoadingState());

    DioHelper.postData(url: SEARCH, token: token, data: {
      'text': text,
    }).then((value) {
      model = SearchModel.fromJson(value.data);
      print(value.data);
      emit(SearchScucessState());
    }).catchError((error) {
      print(error.toString());
      emit(SearchErorrState());
    });
  }
}
