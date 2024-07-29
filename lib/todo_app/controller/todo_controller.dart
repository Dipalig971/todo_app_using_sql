import 'package:get/get.dart';
import 'package:todo_app_using_sql/todo_app/helper/todo_helper.dart';
import 'package:todo_app_using_sql/todo_app/modal/todo_modal.dart';

class TodoController extends GetxController {
  var todoTasks = <TodoModal>[].obs;
  final TodoDBHelper todoDBHelper = TodoDBHelper();

  @override
  void onInit() {
    super.onInit();
    fetchTasks();
  }

  Future<void> fetchTasks() async {
    final data = await todoDBHelper.getData();
    todoTasks.value = data.map((task) => TodoModal.fromJson(task)).toList();
  }

  Future<void> addTask(TodoModal task) async {
    await todoDBHelper.insertData(task.toJson());
    fetchTasks();
  }

  Future<void> updateTask(TodoModal task) async {
    await todoDBHelper.updateData(task.id!, task.toJson());
    fetchTasks();
  }

  Future<void> deleteTask(int id) async {
    await todoDBHelper.deleteTask(id);
    fetchTasks();
  }

  void toggleTaskStatus(TodoModal task) {
    task.isDone = !task.isDone;
    updateTask(task);
  }
}
