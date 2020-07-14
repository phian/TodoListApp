class TaskData {
  int taskId;
  int listId;
  int repeatId;
  String taskName;
  int taskStatus;
  int taskType;
  String taskReminderTime;
  String taskDate;
  String listName;
  String listColor;

  TaskData(
      {this.taskId,
      this.listId,
      this.repeatId,
      this.taskName,
      this.taskStatus,
      this.taskType,
      this.taskReminderTime,
      this.taskDate,
      this.listName,
      this.listColor});

  // Hàm để convert list data vào 1 map object để lưu trữ
  Map<String, dynamic> toMap() {
    var tasksMap = Map<String, dynamic>();

    if (taskId != null) {
      tasksMap['TASK_ID'] = taskId;
    }
    tasksMap['LIST_ID'] = listId;
    tasksMap['REPEAT_ID'] = repeatId;
    tasksMap['TASK_NAME'] = taskName;
    tasksMap['TASK_STATUS'] = taskStatus;
    tasksMap['TASK_TYPE'] = taskType;
    tasksMap['TASK_REMINDER_TIME'] = taskReminderTime;
    tasksMap['TASK_DATE'] = taskDate;

    return tasksMap;
  }

  // Constructor để phân tách ListData object từ một Map object
  TaskData.fromTaskMapObject(Map<String, dynamic> taskMap) {
    this.taskId = taskMap['TASK_ID'];
    this.listId = taskMap['LIST_ID'];
    this.repeatId = taskMap['REPEAT_ID'];
    this.taskName = taskMap['TASK_NAME'];
    this.taskStatus = taskMap['TASK_STATUS'];
    this.taskType = taskMap['TASK_TYPE'];
    this.taskReminderTime = taskMap['TASK_REMINDER_TIME'];
    this.taskDate = taskMap['TASK_DATE'];
    this.listName = taskMap['LIST_NAME'];
    this.listColor = taskMap['LIST_COLOR'];
  }
}
