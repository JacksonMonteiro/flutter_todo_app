abstract class IService {
    get();
    getWhere(String where);
    Future<List<dynamic>> add(var data);
    remove(String name);
    List<dynamic> removeByIndex(int index);
}