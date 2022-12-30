abstract class IService {
    List<dynamic> get();
    List<dynamic> add(var data);
    List<dynamic> remove(var data);
    List<dynamic> removeByIndex(int index);
}