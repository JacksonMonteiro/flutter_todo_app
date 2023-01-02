// ignore_for_file: unused_field, must_be_immutable

import 'package:flutter/material.dart';
import 'package:flutter_iconpicker/flutter_iconpicker.dart';
import 'package:todo/app/components/button_component.dart';
import 'package:todo/app/components/text_field_component.dart';
import 'package:todo/app/models/category_model.dart';
import 'package:todo/app/presenters/home_presenter.dart';

class CategoryFormComponent extends StatefulWidget {
  final HomePresenter homePresenter;
  
  const CategoryFormComponent({super.key, required this.homePresenter});

  @override
  State<CategoryFormComponent> createState() => CategoryFormComponentState();
}

class CategoryFormComponentState extends State<CategoryFormComponent> {
  // Icon
  IconData? _icon;

  // Colors
  final List<Color?> _colors = [ Colors.red[100], Colors.green[100], Colors.blue[100], Colors.yellow[100], Colors.black12, Colors.cyan[100], Colors.indigo[100], Colors.lime[100] ];
  Color? _color;
  Color? _previousColor;

  // Input Controllers
  final _nameController = TextEditingController();

  Future<void> _selectIcon() async {
    _icon = await FlutterIconPicker.showIconPicker(context, iconPackModes: [IconPack.material]);
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Card(
        elevation: 5,
        child: Padding(
          padding: EdgeInsets.only(
            top: 10.0,
            left: 10.0,
            right: 10.0,
            bottom: 10.0 + MediaQuery.of(context).viewInsets.bottom,
          ),
          child: Column(
            children: [
              Row(
                children: [
                  Expanded(
                    child: TextFieldComponent(
                      controller: _nameController,
                      label: 'Nome',
                      action: TextInputAction.next,
                    ),
                  ),
                  (_icon != null)
                      ? CircleAvatar(
                        backgroundColor: Colors.green[600],
                        foregroundColor: Colors.white,
                        child: IconButton(
                            icon: Icon(_icon),
                            onPressed: _selectIcon,
                          ),
                      )
                      : ButtonComponent(label: 'Selecionar Ícone', onPressed: _selectIcon)
                ],
              ),
              const SizedBox(height: 8,),
              Row(
                children: _colors.map((color) => GestureDetector(
                  onTap: () {
                    if (_color == null) {
                      _color = color;
                    } else {
                      _previousColor = _color;
                      _color = color;
                    }

                    setState(() {});
                  },
                  child: Padding(
                    padding: const EdgeInsets.only(right: 7),
                    child: CircleAvatar(
                      backgroundColor: color,
                      child: (_color != null && _color == color) ? const Icon(Icons.check, color: Colors.black,) : const SizedBox(),
                    ),
                  ),
                )).toList(),
              ),
              const SizedBox(height: 8,),
              SizedBox(
                width: MediaQuery.of(context).size.width,
                child: ButtonComponent(
                  label: 'Adicionar Transação',
                  onPressed: () {
                    final category = Category(icon: _icon, name: _nameController.text, tasks: 0, color: _color);
                    widget.homePresenter.addCategory(category);
                    Navigator.of(context).pop();
                  },
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
