import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:todo/app/blocs/category/category_bloc.dart';
import 'package:todo/app/blocs/category/category_events.dart';
import 'package:todo/app/blocs/category/category_state.dart';
import 'package:todo/app/components/category_form_component.dart';
import 'package:todo/app/models/category_model.dart';
import 'package:todo/app/utils/routes.dart';

class HomeView extends StatefulWidget {
  const HomeView({super.key});

  @override
  State<HomeView> createState() => _HomeViewState();
}

class _HomeViewState extends State<HomeView> {
  late CategoryBloc bloc;
  bool isGrid = true;

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
                            style: TextStyle(fontSize: 14, color: Colors.red),
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
                            onPressed: () {
                              setState(() {
                                isGrid = true;
                              });
                            },
                          ),
                          IconButton(
                            icon: const Icon(Icons.line_weight_sharp),
                            onPressed: () {
                              setState(() {
                                isGrid = false;
                              });
                            },
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
                    return isGrid
                        ? GridView.count(
                            crossAxisCount: 2,
                            crossAxisSpacing: 16,
                            mainAxisSpacing: 16,
                            scrollDirection: Axis.vertical,
                            shrinkWrap: true,
                            children: snapshot.data?.categories
                                    .map((category) => GestureDetector(
                                          onTap: () {
                                            if (category.name == 'Adicionar') {
                                              showModalBottomSheet(
                                                  context: context,
                                                  builder: (_) =>
                                                      CategoryFormComponent(
                                                        bloc: bloc,
                                                      ));
                                            } else {
                                              Navigator.of(context).pushNamed(
                                                  Routes.instance.CATEGORY,
                                                  arguments: category);
                                            }
                                          },
                                          child: Container(
                                              decoration: BoxDecoration(
                                                color: category.color,
                                                borderRadius:
                                                    BorderRadius.circular(12),
                                              ),
                                              child: Column(
                                                mainAxisAlignment:
                                                    MainAxisAlignment.center,
                                                children: [
                                                  Icon(category.icon, size: 64),
                                                  Text(
                                                    category.name,
                                                    style: const TextStyle(
                                                        fontSize: 24),
                                                  ),
                                                  (category.icon != Icons.add)
                                                      ? Text(
                                                          '${category.tasks.length} tarefas')
                                                      : const Text('')
                                                ],
                                              )),
                                        ))
                                    .toList() ??
                                [])
                        : ListView.builder(
                            scrollDirection: Axis.vertical,
                            shrinkWrap: true,
                            itemCount: snapshot.data?.categories.length,
                            itemBuilder: (context, i) {
                              return GestureDetector(
                                          onTap: () {
                                            if (snapshot.data?.categories[i].name == 'Adicionar') {
                                              showModalBottomSheet(
                                                  context: context,
                                                  builder: (_) =>
                                                      CategoryFormComponent(
                                                        bloc: bloc,
                                                      ));
                                            } else {
                                              Navigator.of(context).pushNamed(
                                                  Routes.instance.CATEGORY,
                                                  arguments: snapshot.data?.categories[i]);
                                            }
                                          },
                                          child: Container(
                                              padding: const EdgeInsets.symmetric(vertical: 16, horizontal: 8),
                                              margin: const EdgeInsets.only(bottom: 10),
                                              decoration: BoxDecoration(
                                                color: snapshot.data?.categories[i].color,
                                                borderRadius:
                                                    BorderRadius.circular(12),
                                              ),
                                              child: Row(
                                                crossAxisAlignment: CrossAxisAlignment.center,
                                                mainAxisAlignment:
                                                    MainAxisAlignment.start,
                                                children: [
                                                  Icon(snapshot.data?.categories[i].icon, size: 42),
                                                  const SizedBox(
                                                    width: 8,
                                                  ),
                                                  Column(
                                                    crossAxisAlignment: CrossAxisAlignment.start,
                                                    children: [
                                                      Text(
                                                    snapshot.data?.categories[i].name ?? '',
                                                    style: const TextStyle(
                                                        fontSize: 20, 
                                                        fontWeight: FontWeight.bold),
                                                  ),
                                                  (snapshot.data?.categories[i].icon != Icons.add)
                                                      ? Text(
                                                          '${snapshot.data?.categories[i].tasks.length} tarefas')
                                                      :  Container()
                                                    ],
                                                  )
                                                ],
                                              )),
                                        );
                            });
                  }),
            ],
          ),
        ),
      ),
    );
  }
}
