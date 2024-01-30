import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:halo_teacher/app/models/category_model.dart';

class SearchCategoryDelegate extends SearchDelegate<CategoryModel> {
  late List<CategoryModel> teacherCategory;
  late List<CategoryModel> teacherCategorySugestion;
  SearchCategoryDelegate({
    required this.teacherCategory,
    required this.teacherCategorySugestion,
  });

  //Action button, right button
  @override
  List<Widget>? buildActions(BuildContext context) {
    return [
      IconButton(
        icon: Icon(Icons.close),
        onPressed: () {
          query = "";
        },
      )
    ];
  }

  @override
  String get searchFieldLabel => 'Search'.tr;

  //Back Button
  @override
  Widget? buildLeading(BuildContext context) {
    return IconButton(
      icon: Icon(Icons.arrow_back),
      onPressed: () {
        //close(context, query);
      },
    );
  }

  String selectedResult = "";

  @override
  Widget buildResults(BuildContext context) {
    var allTeacherCategory = teacherCategory
        .where(
          (category) => category.categoryName!.toLowerCase().contains(
                query.toLowerCase(),
              ),
        )
        .toList();

    return ListView.builder(
      itemCount: allTeacherCategory.length,
      itemBuilder: (context, index) => ListTile(
        title: Text(allTeacherCategory[index].categoryName!),
        onTap: () {
          close(context, allTeacherCategory[index]);
        },
      ),
    );
  }

  @override
  Widget buildSuggestions(BuildContext context) {
    var allTeacherCategorySuggestion = teacherCategorySugestion
        .where(
          (categorySuggestion) =>
              categorySuggestion.categoryName!.toLowerCase().contains(
                    query.toLowerCase(),
                  ),
        )
        .toList();

    return ListView.builder(
      itemCount: allTeacherCategorySuggestion.length,
      itemBuilder: (context, index) => ListTile(
        title: Text(allTeacherCategorySuggestion[index].categoryName!),
        onTap: () {
          close(context, allTeacherCategorySuggestion[index]);
        },
      ),
    );
  }
}
