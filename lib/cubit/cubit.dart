import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:news_app/cache_helper.dart';
import 'package:news_app/cubit/states.dart';
import 'package:news_app/dio_helper.dart';
import 'package:news_app/screens/business.dart';
import 'package:news_app/screens/sports.dart';
import 'package:news_app/screens/entertainment.dart';
import 'package:news_app/screens/settings.dart';

bool isLightMode = false;

class ThemeCubit extends Cubit<ThemeStates> {
  ThemeCubit() : super(ThemeInitialState());
  static ThemeCubit get(context) => BlocProvider.of(context);

  void changeAppMode({bool fromShared}) {
    if (fromShared != null) {
      isLightMode = fromShared;
    } else {
      isLightMode = !isLightMode;
      CacheHelper.setBoolean(key: 'isDark', value: isLightMode).then((value) {
        emit(ThemeChangeModeState());
      });
    }
  }
}

//___________________________________________________________
class NewsCubit extends Cubit<NewsStates> {
  NewsCubit() : super(NewsInitialState());

  static NewsCubit get(context) => BlocProvider.of(context);

  IconData iconMode =
      isLightMode ? Icons.dark_mode_sharp : Icons.brightness_4_sharp;

  void changeIconMode() {
    iconMode = !isLightMode ? Icons.dark_mode_sharp : Icons.brightness_4_sharp;
    emit(NewsChangeIconMode());
  }

  List<Widget> screens = [
    const BusinessScreen(),
    const SportsScreen(),
    const EntertainmentScreen(),
    const Settings()
  ];

  List<String> titles = [
    'اخبار الاقتصاد',
    'اخبار الرياضه',
    'اخبار الترفيه',
    'Settings'
  ];

  int currentIndex = 0;

  void changeBottomNavBar(int index) {
    currentIndex = index;

    if (index == 1) {
      getSports();
    }
    if (index == 2) {
      getEntertainment();
    }
    emit(NewsChangeBottomNavState());
  }

  List<BottomNavigationBarItem> bottomItems = [
    const BottomNavigationBarItem(
        icon: Icon(Icons.attach_money_sharp), label: 'الاقتصاد'),
    const BottomNavigationBarItem(icon: Icon(Icons.sports), label: 'الرياضه'),
    const BottomNavigationBarItem(icon: Icon(Icons.movie), label: 'الترفيه'),
    // const BottomNavigationBarItem(icon: Icon(Icons.settings), label: 'Settings'),
  ];

  List<dynamic> business = [];
  int total = 0;

  void getBusiness() {
    emit(NewsGetBusinessLoadingState());
    if (business.isEmpty) {
      DioHelper.getData(url: 'v2/top-headlines', query: {
        'country': 'eg',
        'category': 'business',
        //'apiKey': '0d1432980a8f4613b6d80f400545cfef'
        'apiKey': 'beea0f4f3b8e41da9db329c9300863e8',
      }).then((value) {
        total = value.data['totalResults'];
        business = value.data['articles'];
        // debugPrint(business[0]['title']);
        emit(NewsGetBusinessSuccessState());
      }).catchError((error) {
        debugPrint(error.toString());
        emit(NewsGetBusinessErrorState(error));
      });
    } else {
      emit(NewsGetBusinessSuccessState());
    }
  }

  List<dynamic> sports = [];

  void getSports() {
    emit(NewsGetSportsLoadingState());
    if (sports.isEmpty) {
      DioHelper.getData(url: 'v2/top-headlines', query: {
        'country': 'eg',
        'category': 'sports',
        'apiKey': 'beea0f4f3b8e41da9db329c9300863e8'
      }).then((value) {
        sports = value.data['articles'];
        emit(NewsGetSportsSuccessState());
      }).catchError((error) {
        debugPrint(error.toString());
        emit(NewsGetSportsErrorState(error));
      });
    } else {
      emit(NewsGetSportsSuccessState());
    }
  }

  List<dynamic> entertainment = [];

  void getEntertainment() {
    emit(NewsGetEntertainmentLoadingState());
    if (entertainment.isEmpty) {
      DioHelper.getData(url: 'v2/top-headlines', query: {
        'country': 'eg',
        'category': 'entertainment',
        'apiKey': 'beea0f4f3b8e41da9db329c9300863e8'
      }).then((value) {
        entertainment = value.data['articles'];
        emit(NewsGetEntertainmentSuccessState());
      }).catchError((error) {
        debugPrint(error.toString());
        emit(NewsGetEntertainmentErrorState(error));
      });
    } else {
      emit(NewsGetEntertainmentSuccessState());
    }
  }

  List<dynamic> search = [];

  void getSearch(String value) {
    emit(NewsGetSearchLoadingState());

    DioHelper.getData(url: 'v2/everything', query: {
      'q': value,
      'apiKey': 'beea0f4f3b8e41da9db329c9300863e8',
    }).then((value) {
      search = value.data['articles'];
      emit(NewsGetSearchSuccessState());
    }).catchError((error) {
      debugPrint(error.toString());
      emit(NewsGetSearchErrorState(error));
    });
  }

  //.
}
