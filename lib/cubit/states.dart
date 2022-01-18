abstract class ThemeStates {}

class ThemeInitialState extends ThemeStates {}

class ThemeChangeModeState extends ThemeStates {}

//___________________________________________________________

abstract class NewsStates {}

class NewsInitialState extends NewsStates {}

class NewsChangeBottomNavState extends NewsStates {}

class NewsChangeIconMode extends NewsStates {}

class NewsGetBusinessLoadingState extends NewsStates {}

class NewsGetBusinessSuccessState extends NewsStates {}

class NewsGetBusinessErrorState extends NewsStates {
  final String error;

  NewsGetBusinessErrorState(this.error);
}

class NewsGetSportsLoadingState extends NewsStates {}

class NewsGetSportsSuccessState extends NewsStates {}

class NewsGetSportsErrorState extends NewsStates {
  final String error;

  NewsGetSportsErrorState(this.error);
}

class NewsGetEntertainmentLoadingState extends NewsStates {}

class NewsGetEntertainmentSuccessState extends NewsStates {}

class NewsGetEntertainmentErrorState extends NewsStates {
  final String error;

  NewsGetEntertainmentErrorState(this.error);
}

class NewsGetSearchLoadingState extends NewsStates {}

class NewsGetSearchSuccessState extends NewsStates {}

class NewsGetSearchErrorState extends NewsStates {
  final String error;

  NewsGetSearchErrorState(this.error);
}
