class TaskModel {
  Result result;
  String targetUrl;
  bool success;
  String error;
  bool unAuthorizedRequest;
  bool bAbp;

  TaskModel(
      {this.result,
      this.targetUrl,
      this.success,
      this.error,
      this.unAuthorizedRequest,
      this.bAbp});

  TaskModel.fromJson(Map<String, dynamic> json) {
    result =
        json['result'] != null ? new Result.fromJson(json['result']) : null;
    targetUrl = json['targetUrl'];
    success = json['success'];
    error = json['error'];
    unAuthorizedRequest = json['unAuthorizedRequest'];
    bAbp = json['__abp'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    if (this.result != null) {
      data['result'] = this.result.toJson();
    }
    data['targetUrl'] = this.targetUrl;
    data['success'] = this.success;
    data['error'] = this.error;
    data['unAuthorizedRequest'] = this.unAuthorizedRequest;
    data['__abp'] = this.bAbp;
    return data;
  }
}

class Result {
  int totalCount;
  List<Items> items;

  Result({this.totalCount, this.items});

  Result.fromJson(Map<String, dynamic> json) {
    totalCount = json['totalCount'];
    if (json['items'] != null) {
      items = new List<Items>();
      json['items'].forEach((v) {
        items.add(new Items.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['totalCount'] = this.totalCount;
    if (this.items != null) {
      data['items'] = this.items.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class Items {
  int taskId;
  String runningNumber;
  String summary;
  String progress;
  int requesterId;
  String requesterName;
  String strStartDate;
  String strSubmitDate;
  String strDueDate;
  String strCompleteDate;
  String categoryName;
  String subCategoryName;
  String assignToFullName;
  String coordinatorToFullName;
  String priorityColor;
  String priorityName;
  String statusColor;
  String statusName;
  String queueName;
  int queueId;

  Items(
      {this.taskId,
      this.runningNumber,
      this.summary,
      this.progress,
      this.requesterId,
      this.requesterName,
      this.strStartDate,
      this.strSubmitDate,
      this.strDueDate,
      this.strCompleteDate,
      this.categoryName,
      this.subCategoryName,
      this.assignToFullName,
      this.coordinatorToFullName,
      this.priorityColor,
      this.priorityName,
      this.statusColor,
      this.statusName,
      this.queueName,
      this.queueId});

  Items.fromJson(Map<String, dynamic> json) {
    taskId = json['taskId'];
    runningNumber = json['runningNumber'];
    summary = json['summary'];
    progress = json['progress'];
    requesterId = json['requesterId'];
    requesterName = json['requesterName'];
    strStartDate = json['strStartDate'];
    strSubmitDate = json['strSubmitDate'];
    strDueDate = json['strDueDate'];
    strCompleteDate = json['strCompleteDate'];
    categoryName = json['categoryName'];
    subCategoryName = json['subCategoryName'];
    assignToFullName = json['assignToFullName'];
    coordinatorToFullName = json['coordinatorToFullName'];
    priorityColor = json['priorityColor'];
    priorityName = json['priorityName'];
    statusColor = json['statusColor'];
    statusName = json['statusName'];
    queueName = json['queueName'];
    queueId = json['queueId'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['taskId'] = this.taskId;
    data['runningNumber'] = this.runningNumber;
    data['summary'] = this.summary;
    data['progress'] = this.progress;
    data['requesterId'] = this.requesterId;
    data['requesterName'] = this.requesterName;
    data['strStartDate'] = this.strStartDate;
    data['strSubmitDate'] = this.strSubmitDate;
    data['strDueDate'] = this.strDueDate;
    data['strCompleteDate'] = this.strCompleteDate;
    data['categoryName'] = this.categoryName;
    data['subCategoryName'] = this.subCategoryName;
    data['assignToFullName'] = this.assignToFullName;
    data['coordinatorToFullName'] = this.coordinatorToFullName;
    data['priorityColor'] = this.priorityColor;
    data['priorityName'] = this.priorityName;
    data['statusColor'] = this.statusColor;
    data['statusName'] = this.statusName;
    data['queueName'] = this.queueName;
    data['queueId'] = this.queueId;
    return data;
  }
}
