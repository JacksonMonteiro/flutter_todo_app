import 'package:flutter/material.dart';
import 'package:todo/app/components/text_field_component.dart';
import 'package:todo/app/models/task_model.dart';
import 'package:todo/app/presenters/add_task_presenter.dart';
import 'package:todo/app/presenters/category_view_presenter.dart';

class AddTaskView extends StatefulWidget {
  const AddTaskView({super.key});

  @override
  State<AddTaskView> createState() => _AddTaskViewState();
}

class _AddTaskViewState extends State<AddTaskView> implements AddTaskContract {
  late AddTaskPresenter _presenter;
  // Input controller
  final _taskController = TextEditingController();

  @override
  void initState() {
    super.initState();
    _presenter = AddTaskPresenter(this);
    _presenter.loadCategories();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: AnimatedBuilder(
        animation: _presenter.state,
        builder: (context, child) =>
            _presenter.stateManager(_presenter.state.value),
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

  @override
  start() {
    Map<String, dynamic> args =
        ModalRoute.of(context)?.settings.arguments as Map<String, dynamic>;
    CategoryViewPresenter _cPresenter = args['presenter'];

    return SafeArea(
      child: Container(
        padding: const EdgeInsets.symmetric(vertical: 16, horizontal: 32),
        width: double.infinity,
        height: double.infinity,
        color: args['color'],
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Column(
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
                  ],
                ),
                const SizedBox(
                  height: 32,
                ),
                const Text(
                  'Adicionar nova tarefa',
                  style: TextStyle(fontSize: 28, fontWeight: FontWeight.bold),
                ),
                TextFieldComponent(label: '', controller: _taskController),
                const SizedBox(
                  height: 16,
                ),
                GridView.count(
                    crossAxisCount: 2,
                    crossAxisSpacing: 16,
                    mainAxisSpacing: 16,
                    childAspectRatio: 3,
                    scrollDirection: Axis.vertical,
                    shrinkWrap: true,
                    children: _presenter.categories
                        .map((category) => GestureDetector(
                              onTap: () {
                                setState(() {
                                  _cPresenter.category = category.name;
                                  _cPresenter.isCategorySelected = true;
                                });
                              },
                              child: (category.name == 'Adicionar')
                                  ? Container()
                                  : Container(
                                      padding: const EdgeInsets.symmetric(
                                          horizontal: 10),
                                      decoration: BoxDecoration(
                                        color: _cPresenter.isCategorySelected
                                            ? Colors.white
                                            : Colors.white54,
                                        borderRadius: BorderRadius.circular(8),
                                      ),
                                      child: Row(
                                        children: [
                                          Container(
                                            width: 18,
                                            height: 18,
                                            decoration: BoxDecoration(
                                                color: category.color,
                                                borderRadius:
                                                    BorderRadius.circular(9)),
                                          ),
                                          const SizedBox(
                                            width: 8,
                                          ),
                                          Text(
                                            category.name,
                                            style:
                                                const TextStyle(fontSize: 18),
                                          ),
                                        ],
                                      )),
                            ))
                        .toList())
              ],
            ),
            ElevatedButton(
              onPressed: () {
                _cPresenter.addTask(
                    Task(id: null, name: _taskController.text, category: _cPresenter.category));
                Navigator.of(context).pop();
              },
              style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.white,
                  minimumSize: const Size(double.infinity, 40)),
              child: const Text(
                'Adicionar tarefa',
                style: TextStyle(
                    color: Colors.black,
                    fontWeight: FontWeight.bold,
                    fontSize: 18),
              ),
            )
          ],
        ),
      ),
    );
  }
}
