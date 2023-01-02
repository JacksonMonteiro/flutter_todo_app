import 'package:flutter/material.dart';
import 'package:todo/app/components/category_form_component.dart';
import 'package:todo/app/presenters/home_presenter.dart';
import 'package:todo/app/utils/routes.dart';

class HomeView extends StatefulWidget {
  const HomeView({super.key});

  @override
  State<HomeView> createState() => _HomeViewState();
}

class _HomeViewState extends State<HomeView> implements HomePresenterContract {
  // Presenter
  late HomePresenter _presenter;

  // Variables
  bool isGrid = true;

  @override
  void initState() {
    super.initState();
    _presenter = HomePresenter(this);
    _presenter.loadCategories();
  }

  @override
  void dispose() {
    super.dispose();
    _presenter.state.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: AnimatedBuilder(
            animation: _presenter.state,
            builder: (context, child) =>
                _presenter.stateManager(_presenter.state.value)));
  }

  @override
  start() {
    return SafeArea(
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
                      children: [
                        const Text(
                          'Você tem ',
                          style: TextStyle(
                            fontSize: 14,
                          ),
                        ),
                        Text(
                          '${_presenter.tasks}',
                          style:
                              const TextStyle(fontSize: 14, color: Colors.red),
                        ),
                        const Text(
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
            isGrid
                ? RefreshIndicator(
                    onRefresh: () {
                      return _presenter.loadCategories();
                    },
                    child: GridView.count(
                        crossAxisCount: 2,
                        crossAxisSpacing: 16,
                        mainAxisSpacing: 16,
                        scrollDirection: Axis.vertical,
                        shrinkWrap: true,
                        children: _presenter.categories
                            .map((category) => GestureDetector(
                                  onTap: () {
                                    if (category.name == 'Adicionar') {
                                      showModalBottomSheet(
                                          context: context,
                                          builder: (_) => CategoryFormComponent(
                                                homePresenter: _presenter,
                                              ));
                                    } else {
                                      Navigator.of(context).pushNamed(
                                          Routes.instance.CATEGORY,
                                          arguments: {
                                            'category': category,
                                            'presenter': _presenter,
                                          });
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
                                            style:
                                                const TextStyle(fontSize: 24),
                                          ),
                                          (category.icon != Icons.add)
                                              ? Text(
                                                  '${category.tasks} tarefas')
                                              : const Text('')
                                        ],
                                      )),
                                ))
                            .toList()),
                  )
                : ListView.builder(
                    scrollDirection: Axis.vertical,
                    shrinkWrap: true,
                    itemCount: _presenter.categories.length,
                    itemBuilder: (context, i) {
                      return GestureDetector(
                        onTap: () {
                          if (_presenter.categories[i].name == 'Adicionar') {
                            showModalBottomSheet(
                                context: context,
                                builder: (_) => CategoryFormComponent(
                                      homePresenter: _presenter,
                                    ));
                          } else {
                            Navigator.of(context).pushNamed(
                                Routes.instance.CATEGORY,
                                arguments: _presenter.categories[i]);
                          }
                        },
                        child: Container(
                            padding: const EdgeInsets.symmetric(
                                vertical: 16, horizontal: 8),
                            margin: const EdgeInsets.only(bottom: 10),
                            decoration: BoxDecoration(
                              color: _presenter.categories[i].color,
                              borderRadius: BorderRadius.circular(12),
                            ),
                            child: Row(
                              crossAxisAlignment: CrossAxisAlignment.center,
                              mainAxisAlignment: MainAxisAlignment.start,
                              children: [
                                Icon(_presenter.categories[i].icon, size: 42),
                                const SizedBox(
                                  width: 8,
                                ),
                                Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Text(
                                      _presenter.categories[i].name,
                                      style: const TextStyle(
                                          fontSize: 20,
                                          fontWeight: FontWeight.bold),
                                    ),
                                    (_presenter.categories[i].icon != Icons.add)
                                        ? Text(
                                            '${_presenter.categories[i].tasks} tarefas')
                                        : Container()
                                  ],
                                )
                              ],
                            )),
                      );
                    })
          ],
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
