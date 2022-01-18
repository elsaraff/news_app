import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:news_app/components.dart';
import 'package:news_app/cubit/cubit.dart';
import 'package:news_app/cubit/states.dart';
import 'package:news_app/screens/search.dart';

class HomePage extends StatelessWidget {
  const HomePage({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<NewsCubit, NewsStates>(
      listener: (context, state) {},
      builder: (context, state) {
        var newsCubit = NewsCubit.get(context);
        var themeCubit = ThemeCubit.get(context);

        return Scaffold(
          appBar: AppBar(
            title: Text(newsCubit.titles[newsCubit.currentIndex]),
            actions: [
              IconButton(
                icon: const Icon(
                  Icons.search_sharp,
                  size: 32.0,
                ),
                onPressed: () {
                  navigateTo(context, const SearchScreen());
                },
              ),
              IconButton(
                icon: Icon(
                  newsCubit.iconMode,
                  size: 30.0,
                ),
                onPressed: () {
                  newsCubit.changeIconMode();
                  themeCubit.changeAppMode();
                },
              )
            ],
          ),
          body: newsCubit.screens[newsCubit.currentIndex],
          bottomNavigationBar: BottomNavigationBar(
              items: newsCubit.bottomItems,
              currentIndex: newsCubit.currentIndex,
              onTap: (index) {
                newsCubit.changeBottomNavBar(index);
              }),
        );
      },
    );
  }
}
