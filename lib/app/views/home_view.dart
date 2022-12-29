import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:todo/app/blocs/category/category_bloc.dart';
import 'package:todo/app/blocs/category/category_events.dart';
import 'package:todo/app/blocs/category/category_state.dart';
import 'package:todo/app/components/category_form_component.dart';
import 'package:todo/app/models/category_model.dart';

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
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
              children: [
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Text(
                    'Olá! Seja bem-vindo',
                    style: TextStyle(fontSize: 22, fontWeight: FontWeight.bold),
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Row(
                        children: const [
                          Text(
                            'Você tem ',
                            style: TextStyle(
                              fontSize: 14,
                            ),
                          ),
                          Text(
                            '0',
                            style: TextStyle(
                              fontSize: 14,
                              color: Colors.red
                            ),
                          ),
                          Text(
                            ' novas tarefas para hoje',
                            style: TextStyle(
                              fontSize: 14,
                            ),
                          ),
                        ],
                      ),
                      Row(
                        children: [
                          IconButton(
                            icon: const Icon(Icons.grid_view_sharp),
                            onPressed: () {},
                          ),
                          IconButton(
                            icon: const Icon(Icons.line_weight_sharp),
                            onPressed: () {},
                          ),
                        ],
                      )
                    ],
                  ),
                ],
              ),
              const SizedBox(
                height: 16,
              ),
              StreamBuilder<CategoryState>(
                  stream: bloc.stream,
                  builder: (context, snapshot) {
                    return GridView.count(
                        crossAxisCount: 2,
                        crossAxisSpacing: 16,
                        mainAxisSpacing: 16,
                        scrollDirection: Axis.vertical,
                        shrinkWrap: true,
                        children: snapshot.data?.categories
                                .map((category) => GestureDetector(
                                  onTap: () {
                                    if (category.name == 'Adicionar') {
                                      showModalBottomSheet(context: context, builder: (_) => CategoryFormComponent(bloc: bloc,));
                                    }
                                  },
                                  child: Container(
                                      decoration: BoxDecoration(
                                        color: category.color,
                                        borderRadius: BorderRadius.circular(12),
                                      ),
                                      child: Column(
                                        mainAxisAlignment:
                                            MainAxisAlignment.center,
                                        children: [
                                          Icon(category.icon, size: 64),
                                          Text(
                                            category.name,
                                            style: const TextStyle(fontSize: 24),
                                          ),
                                          (category.icon != Icons.add) ? Text('${category.tasks.length} tarefas') : const Text('')
                                        ],
                                      )),
                                ))
                                .toList() ??
                            []);
                  }),
            ],
          ),
        ),
      ),
    );
  }
}
