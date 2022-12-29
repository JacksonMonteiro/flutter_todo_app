import 'package:flutter/material.dart';
import 'package:todo/app/blocs/category/category_bloc.dart';
import 'package:todo/app/blocs/category/category_events.dart';
import 'package:todo/app/blocs/category/category_state.dart';

class HomeView extends StatefulWidget {
  const HomeView({super.key});

  @override
  State<HomeView> createState() => _HomeViewState();
}

class _HomeViewState extends State<HomeView> {
  late CategoryBloc bloc;

  @override
  void initState() {
    super.initState();
    bloc = CategoryBloc();
    bloc.add(LoadCategoriesEvent());
  }

  @override
  void dispose() {
    super.dispose();
    bloc.close();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: StreamBuilder<CategoryState>(
          stream: bloc.stream,
          builder: (context, snapshot) {
            return Padding(
              padding: const EdgeInsets.all(16.0),
              child: GridView.count(
                  crossAxisCount: 2,
                  crossAxisSpacing: 16,
                  mainAxisSpacing: 16,
                  children: snapshot.data?.categories
                          .map((category) => Container(
                                decoration: BoxDecoration(
                                  color: category.color,
                                  borderRadius: BorderRadius.circular(12),
                                ),
                                  child: Column(mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  Icon(category.icon, size: 64),
                                  Text(category.name, style: TextStyle(fontSize: 24),),
                                  Text('${category.tasks.length} tarefas')
                                ],
                              )))
                          .toList() ??
                      []),
            );
          }),
    );
  }
}
