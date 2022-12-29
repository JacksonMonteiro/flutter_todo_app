import 'package:flutter/material.dart';
import 'package:todo/app/components/text_field_component.dart';

class AddTaskView extends StatefulWidget {
  const AddTaskView({super.key});

  @override
  State<AddTaskView> createState() => _AddTaskViewState();
}

class _AddTaskViewState extends State<AddTaskView> {
  // Input controller
  final _taskController = TextEditingController();

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    Color? color = ModalRoute.of(context)?.settings.arguments as Color?;

    return Scaffold(
      body: SafeArea(
        child: Container(
          padding: const EdgeInsets.symmetric(vertical: 16, horizontal: 32),
          width: double.infinity,
          height: double.infinity,
          color: color,
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
                      children: []
                          .map((category) => GestureDetector(
                                child: (category.name == 'Adicionar')
                                    ? Container()
                                    : Container(
                                        padding: const EdgeInsets.symmetric(
                                            horizontal: 10),
                                        decoration: BoxDecoration(
                                          color: Colors.white54,
                                          borderRadius:
                                              BorderRadius.circular(8),
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
                onPressed: () {},
                style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.white,
                    minimumSize: const Size(double.infinity, 40)),
                child: const Text(
                  'Adicionar nova tarefa',
                  style: TextStyle(
                      color: Colors.black,
                      fontWeight: FontWeight.bold,
                      fontSize: 18),
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
