import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:news_app/components.dart';
import 'package:news_app/cubit/cubit.dart';
import 'package:news_app/cubit/states.dart';

var searchController = TextEditingController();
var formKey = GlobalKey<FormState>(); //to form validate

class SearchScreen extends StatelessWidget {
  const SearchScreen({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<NewsCubit, NewsStates>(
      listener: (context, state) {},
      builder: (context, state) {
        var newsCubit = NewsCubit.get(context);
        var list = newsCubit.search;
        return Scaffold(
          appBar: AppBar(
            title: const Text('البحث'),
          ),
          body: Column(
            children: [
              Padding(
                padding:
                    const EdgeInsets.only(top: 15.0, left: 5.0, right: 5.0),
                child: Form(
                    key: formKey,
                    child: Container(
                      width: double.infinity,
                      color: Colors.white24,
                      child: TextFormField(
                        textAlign: TextAlign.right,
                        decoration: const InputDecoration(
                          hintTextDirection: TextDirection.rtl,
                          hintText: 'بحث',
                          border: OutlineInputBorder(),
                          suffixIcon:
                              Icon(Icons.search, color: Colors.brown, size: 30),
                        ),
                        controller: searchController,
                        keyboardType: TextInputType.text,
                        validator: (String value) {
                          if (value.isEmpty) {
                            return 'Empty';
                          } else {
                            return null;
                          }
                        },
                        onChanged: (value) {
                          NewsCubit.get(context).getSearch(value);
                        },
                      ),
                    )),
              ),
              Expanded(
                child: Padding(
                    padding: const EdgeInsets.all(5.0),
                    child: articleBuilder(list, isSearch: true)),
              )
            ],
          ),
        );
      },
    );
  }
}
