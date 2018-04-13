import 'dart:math';

import 'package:flashcards_flutter/src/firebase_flutter_api.dart';
import 'package:flutter/material.dart';
import 'package:flashcards_flutter/src/course_list_item.dart';
import 'package:flashcards_common/common.dart';

class CoursesList extends StatefulWidget {
  final CoursesQueryType type;

  CoursesList(this.type);

  @override
  State<StatefulWidget> createState() => _CoursesListState();
}

// ignore: mixin_inherits_from_not_object
class _CoursesListState extends State<CoursesList> with SingleTickerProviderStateMixin {
  final CourseListBloc _bloc = CourseListBloc(FirebaseFlutterApi());

  @override
  Widget build(BuildContext context) {
    return StreamBuilder<List<CourseData>>(
      stream: _bloc.query(widget.type),
      builder: (BuildContext context, AsyncSnapshot<List<CourseData>> snapshot) {
        if (!snapshot.hasData) return const Text('Loading...');
        return GridView.count(
          crossAxisCount: 2,
          children: snapshot.data.map((CourseData document) {
            return Container(
              margin: EdgeInsets.all(8.0),
              child: CourseListItem(
                name: document.name,
                // TODO: remove random
                percentage: document.progress ?? Random().nextDouble(),
              ),
            );
          }).toList(),
          padding: EdgeInsets.all(8.0),
        );
      },
    );
  }
}
