abstract class IService {
    Future<List<dynamic>> get();
    Future<List<dynamic>> add(var data);
    remove(String name);
    List<dynamic> removeByIndex(int index);
}