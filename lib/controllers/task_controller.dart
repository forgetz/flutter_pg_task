import 'package:get/get.dart';
import 'package:task/models/task_model.dart';
import 'package:task/services/api_connect.dart';

class TaskController extends GetxController {
  final items = List<Items>().obs;
  final totalCount = 0.obs;

  String accessToken;
  String assignId;
  String statusId;
  String categoryId;
  String subCategoryId;
  String display;

  TaskController(
      {this.accessToken,
      this.assignId,
      this.statusId,
      this.categoryId,
      this.subCategoryId,
      this.display});

  @override
  void onInit() {
    super.onInit();
  }

  void fetchTask(
    String accessToken,
    String assignId,
    String statusId,
    String categoryId,
    String subCategoryId,
    String display,
  ) async {
    final result = await apiLoadTask(
      accessToken,
      assignId,
      statusId,
      categoryId,
      subCategoryId,
      display,
    );

    items.value = result.items;
    totalCount.value = result.totalCount;
    update();
  }
}
