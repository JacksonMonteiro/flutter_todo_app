import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:todo/app/models/category_model.dart';
import 'package:todo/app/models/task_model.dart';
import 'package:todo/app/presenters/category_view_presenter.dart';
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
    _presenter.getTasks();
  }

  @override
  Widget build(BuildContext context) {

    return Scaffold(
      body: AnimatedBuilder(
        animation: _presenter.state,
        builder: (context, child) => _presenter.stateManager(_presenter.state.value)),
    );
  }

  @override
  start() {
    Category category = ModalRoute.of(context)?.settings.arguments as Category;

    return SafeArea(
        child: Container(
          padding: const EdgeInsets.symmetric(vertical: 16, horizontal: 32),
          width: double.infinity,
          height: double.infinity,
          color: category.color,
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
                        Navigator.of(context).pushNamed(
                            Routes.instance.ADD_TASK,
                            arguments: {"color": category.color, "presenter": _presenter});
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
                        '${category.tasks.length} tarefas',
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
                      itemBuilder: (context, i) => Padding(
                        padding: const EdgeInsets.only(bottom: 12.0),
                        child: Row(
                              children: [
                                CircleAvatar(
                                  backgroundColor: Colors.green,
                                  child: IconButton(
                                    onPressed: () {
                                      _presenter.removeTask(Task(name: _presenter.tasks[i].name, category: category.name));
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
      );
  }

  @override
  changeState() {
    setState(() {});
  }
}
