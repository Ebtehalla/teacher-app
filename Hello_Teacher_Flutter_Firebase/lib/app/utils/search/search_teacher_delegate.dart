import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:halo_teacher/app/models/teacher_model.dart';
import 'package:halo_teacher/app/services/teacher_service.dart';

class SearchTeacherDelegate extends SearchDelegate<Teacher> {
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
  Widget? buildLeading(BuildContext context) {
    return IconButton(
      icon: Icon(Icons.arrow_back),
      onPressed: () {
        close(context, Teacher(id: ''));
      },
    );
  }

  @override
  Widget buildResults(BuildContext context) => FutureBuilder<List<Teacher>>(
      future: TeacherService().searchTeacher(query),
      builder: (contex, snapshot) {
        if (query.isEmpty) return buildNoSuggestions();
        switch (snapshot.connectionState) {
          case ConnectionState.waiting:
            return Center(child: CircularProgressIndicator());
          default:
            if (snapshot.hasError) {
              return Container(
                color: Colors.black,
                alignment: Alignment.center,
                child: Text(
                  'Something went wrong!',
                  style: TextStyle(fontSize: 28, color: Colors.white),
                ),
              );
            } else {
              return buildResultSuccess(snapshot.data!);
            }
        }
      });

  @override
  Widget buildSuggestions(BuildContext context) => FutureBuilder<List<Teacher>>(
        future: TeacherService().searchTeacher(query),
        builder: (context, snapshot) {
          if (query.isEmpty) return buildNoSuggestions();
          switch (snapshot.connectionState) {
            case ConnectionState.waiting:
              return Center(child: CircularProgressIndicator());
            default:
              if (snapshot.hasError || snapshot.data!.isEmpty) {
                return buildNoSuggestions();
              } else {
                return buildSuggestionsSuccess(snapshot.data!);
              }
          }
        },
      );

  Widget buildSuggestionsSuccess(List<Teacher> suggestions) => ListView.builder(
        itemCount: suggestions.length,
        itemBuilder: (context, index) {
          final suggestion = suggestions[index];
          final queryText = suggestion.name!.substring(0, query.length);
          final remainingText = suggestion.name!.substring(query.length);

          return ListTile(
            onTap: () {
              query = suggestion.name!;
              showResults(context);
            },
            leading: Icon(Icons.person),
            // title: Text(suggestion),
            title: RichText(
              text: TextSpan(
                text: queryText,
                style: TextStyle(
                  color: Colors.black,
                  fontWeight: FontWeight.bold,
                  fontSize: 18,
                ),
                children: [
                  TextSpan(
                    text: remainingText,
                    style: TextStyle(
                      color: Colors.black54,
                      fontSize: 18,
                    ),
                  ),
                ],
              ),
            ),
          );
        },
      );
  Widget buildNoSuggestions() => Center(
        child: Text(
          'No suggestions!',
          style: TextStyle(fontSize: 28, color: Colors.black45),
        ),
      );

  Widget buildResultSuccess(List<Teacher> teacher) => ListView.builder(
      itemCount: teacher.length,
      itemBuilder: (contex, index) {
        return ListTile(
          onTap: () {
            close(contex, teacher[index]);
          },
          leading: CircleAvatar(
            backgroundImage:
                CachedNetworkImageProvider(teacher[index].picture!),
          ),
          title: Text(teacher[index].name!),
        );
      });
}
