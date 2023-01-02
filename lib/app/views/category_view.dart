import 'package:flutter/material.dart';
import 'package:todo/app/models/category_model.dart';
import 'package:todo/app/models/task_model.dart';
import 'package:todo/app/presenters/category_view_presenter.dart';
import 'package:todo/app/presenters/home_presenter.dart';
import 'package:todo/app/utils/routes.dart';

class CategoryView extends StatefulWidget {
  const CategoryView({super.key});

  @override
  State<CategoryView> createState() => _CategoryViewState();
}

class _CategoryViewState extends State<CategoryView> implements CategoryViewContract {
  late CategoryViewPresenter _presenter;

  @override
  void initState() {
    super.initState();
    _presenter = CategoryViewPresenter(this);
  }

  loadTasks(String category) {
    _presenter.getTasks(category);
  }

  @override
  Widget build(BuildContext context) {
    Map<String, dynamic> args = ModalRoute.of(context)?.settings.arguments as Map<String, dynamic>;
    Category category = args['category'];
    _presenter.getTasks(category.name);

    return Scaffold(
      body: AnimatedBuilder(
          animation: _presenter.state,
          builder: (context, child) =>
              _presenter.stateManager(_presenter.state.value)),
    );
  }


  @override
  start() {
    Map<String, dynamic> args = ModalRoute.of(context)?.settings.arguments as Map<String, dynamic>;
    Category category = args['category'];
    HomePresenter hPresenter = args['presenter'];

    return SafeArea(
      child: Container(
        padding: const EdgeInsets.symmetric(vertical: 16, horizontal: 32),
        width: double.infinity,
        height: double.infinity,
        color: category.color,
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  IconButton(
                      alignment: Alignment.centerLeft,
                      onPressed: () {
                        Navigator.of(context).pop();
                      },
                      icon: const Icon(Icons.arrow_back)),
                  IconButton(
                      onPressed: () {
                        _presenter.category = category.name;
                        Navigator.of(context).pushNamed(Routes.instance.ADD_TASK, arguments: { "color": category.color, "presenter": _presenter,"homePresenter": hPresenter });
                      },
                      icon: const Icon(Icons.add)),
                ],
              ),
              const SizedBox(
                height: 32,
              ),
              Row(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  CircleAvatar(
                      backgroundColor: Colors.black,
                      foregroundColor: category.color,
                      child: Icon(category.icon)),
                  const SizedBox(
                    width: 8,
                  ),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        category.name,
                        style: const TextStyle(
                            fontSize: 24, fontWeight: FontWeight.bold),
                      ),
                      Text(
                        '${_presenter.tasksNumber} tarefas',
                        style: const TextStyle(fontSize: 16),
                      )
                    ],
                  )
                ],
              ),
              const SizedBox(
                height: 32,
              ),
              ListView.builder(
                  scrollDirection: Axis.vertical,
                  shrinkWrap: true,
                  itemCount: _presenter.tasks.length,
                  reverse: true,
                  itemBuilder: (context, i) => Padding(
                        padding: const EdgeInsets.only(bottom: 12.0),
                        child: Row(
                          children: [
                            CircleAvatar(
                              backgroundColor: Colors.green,
                              child: IconButton(
                                onPressed: () {
                                  _presenter.category = category.name;
                                  _presenter.tasksNumber = category.tasks;
                                  _presenter.removeTask(_presenter.tasks[i].name, i, hPresenter);
                                },
                                icon: const Icon(
                                  Icons.check,
                                  color: Colors.black,
                                ),
                              ),
                            ),
                            const SizedBox(
                              width: 8,
                            ),
                            Text(
                              _presenter.tasks[i].name,
                              style: const TextStyle(fontSize: 20),
                            ),
                          ],
                        ),
                      ))
            ],
          ),
        ),
      ),
    );
  }

  @override
  changeState() {
    setState(() {});
  }

  @override
  loading() {
    return const Center(
      child: CircularProgressIndicator(),
    );
  }
}
