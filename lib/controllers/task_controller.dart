import 'package:get/get.dart';
import 'package:task/models/task_model.dart';
import 'package:task/services/api_connect.dart';

class TaskController extends GetxController {
  List<Items> items = List<Items>().obs;

  int totalCount;
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
    // TODO: implement onInit
    super.onInit();

    // print('fetchTask(${this.accessToken}, ${this.assignId}, ${this.statusId}, ${this.categoryId}, ${this.subCategoryId}, ${this.display}');

    // fetchTask(this.accessToken, this.assignId, this.statusId, this.categoryId,
    //     this.subCategoryId, this.display);
  }

  void fetchTask(String accessToken, String assignId, String statusId,
      String categoryId, String subCategoryId, String display) async {
    try {
      final value = await apiLoadTask(
        accessToken,
        assignId,
        statusId,
        categoryId,
        subCategoryId,
        display,
      );

      items = value.items;
      totalCount = value.totalCount;
      update();
    } catch (e) {}
  }
}
