import 'package:flutter/material.dart';
import 'package:sqflite/sqflite.dart';
import 'package:todo/app/models/category_model.dart';
import 'package:todo/app/services/interfaces/service_interface.dart';
import 'package:todo/database/db.dart';

class CategoryService extends IService {
  late Database db;

  List<Category> categories = [
    Category(
        icon: Icons.add, name: 'Adicionar', tasks: 0, color: Colors.red[100]),
  ];

  @override
  Future<List<Category>> add(data) async {
    db = await DB.instance.database;
    Category category = data as Category;

    var response = await db.rawInsert(
        'INSERT INTO categories (codePoint, name, tasks, color) VALUES (${category.icon?.codePoint}, "${category.name}", ${category.tasks}, ${category.color?.value})');
    if (response <= 0) {
      print('Erro ao adicionar');
    } else {
      categories.insert(0, data);
    }

    return categories;
  }

  @override
  Future<List<Category>> get() async {
    db = await DB.instance.database;

    List dbCategories = await db.rawQuery('SELECT * FROM categories');
    if (dbCategories.isEmpty) {
      print('Consulta retornou lista vazia');
    } else {
      for (var i = 0; i < dbCategories.length; i++) {
        print(dbCategories[i]);
        categories.insert(
            0,
            Category(
              icon: IconData(int.parse(dbCategories[i]['codePoint']), fontFamily: 'MaterialIcons'),
              name: dbCategories[i]['name'],
              tasks: dbCategories[i]['tasks'],
              color: Color(dbCategories[i]['color']),
            ));
      }
    }

    return categories;
  }

  @override
  Future<List<Category>> remove(data) async {
    categories.remove(data as Category);
    return categories;
  }

  @override
  List<Category> removeByIndex(int index) {
    categories.removeAt(index);
    return categories;
  }

  put(String name, int tasks) async {
    db = await DB.instance.database;
    var response = await db.rawUpdate('UPDATE categories SET tasks = $tasks WHERE name = "$name"');
    return response; 
  }

  // Nullable
  @override
  getWhere(String where) {
    return null;
  }
}
