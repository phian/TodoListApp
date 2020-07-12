class TaskData {
  int taskId;
  int listId;
  int scheduleId;
  String taskName;
  int taskStatus;
  int taskType;
  String taskRemainderTime;

  TaskData(
      {this.taskId,
      this.listId,
      this.scheduleId,
      this.taskName,
      this.taskStatus,
      this.taskType,
      this.taskRemainderTime});

  // Hàm để convert list data vào 1 map object để lưu trữ
  Map<String, dynamic> toMap() {
    var tasksMap = Map<String, dynamic>();

    if (taskId != null) {
      tasksMap['TASK_ID'] = taskId;
    }
    tasksMap['LIST_ID'] = listId;
    tasksMap['SCHEDULE_ID'] = scheduleId;
    tasksMap['TASK_NAME'] = taskName;
    tasksMap['TASK_STATUS'] = taskStatus;
    tasksMap['TASK_TYPE'] = taskType;
    tasksMap['TASK_REMAINDER_TIME'] = taskRemainderTime;

    return tasksMap;
  }

  // Constructor để phân tách ListData object từ một Map object
  TaskData.fromTaskMapObject(Map<String, dynamic> taskMap) { 
    this.taskId = taskMap['TASK_ID'];
    this.listId = taskMap['LIST_ID'];
    this.scheduleId = taskMap['SCHEDULE_ID'];
    this.taskName = taskMap['TASK_NAME'];
    this.taskStatus = taskMap['TASK_STATUS'];
    this.taskType = taskMap['TASK_TYPE'];
    this.taskRemainderTime = taskMap['TASK_REMAINDER_TIME'];
  }
}
