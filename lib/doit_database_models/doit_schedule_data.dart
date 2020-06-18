class ScheduleData {
  int scheduleId;
  String scheduleRepeatDate;
  int scheduleSetUpStatus;
  int scheduleFrequencyChoice;
  int scheduleRerepeatTimes;
  String scheduleWeeklyChoiceDates;
  String scheduleMonthlyChoice;
  int scheduleEndsNeverChoice;
  int scheduleEndsNumberOfTimes;
  String scheduleEndsDate;

  ScheduleData(
      {this.scheduleId,
      this.scheduleRepeatDate,
      this.scheduleSetUpStatus,
      this.scheduleFrequencyChoice,
      this.scheduleRerepeatTimes,
      this.scheduleWeeklyChoiceDates,
      this.scheduleMonthlyChoice,
      this.scheduleEndsNeverChoice,
      this.scheduleEndsNumberOfTimes,
      this.scheduleEndsDate});

// Hàm để convert list data vào 1 map object để lưu trữ
  Map<String, dynamic> toMap() {
    var scheduleMap = Map<String, dynamic>();

    if (scheduleId != null) {
      scheduleMap['SCHEDULE_ID'] = scheduleId;
    }
    scheduleMap['REPEAT_DATE'] = scheduleRepeatDate;
    scheduleMap['SCHEDULE_STATUS'] = scheduleSetUpStatus;
    scheduleMap['FREQUENCY_CHOICE'] = scheduleFrequencyChoice;
    scheduleMap['REPEAT_TIMES'] = scheduleRerepeatTimes;
    scheduleMap['WEEKLY_CHOICE_DATES'] = scheduleWeeklyChoiceDates;
    scheduleMap['MONTHLY_CHOICE'] = scheduleMonthlyChoice;
    scheduleMap['NEVER_CHOICE'] = scheduleEndsNeverChoice;
    scheduleMap['NUMBER_OF_TIMES'] = scheduleEndsNumberOfTimes;
    scheduleMap['ENDS_DATE'] = scheduleEndsDate;

    return scheduleMap;
  }

  // Constructor để phân tách ListData object từ một Map object
  ScheduleData.fromScheduleMapObject(Map<String, dynamic> scheduleMap) {
    this.scheduleId = scheduleMap['SCHEDULE_ID'];
    this.scheduleRepeatDate = scheduleMap['REPEAT_DATE'];
    this.scheduleSetUpStatus = scheduleMap['SCHEDULE_STATUS'];
    this.scheduleFrequencyChoice = scheduleMap['FREQUENCY_CHOICE'];
    this.scheduleRerepeatTimes = scheduleMap['REPEAT_TIMES'];
    this.scheduleWeeklyChoiceDates = scheduleMap['WEEKLY_CHOICE_DATES'];
    this.scheduleMonthlyChoice = scheduleMap['MONTHLY_CHOICE'];
    this.scheduleEndsNeverChoice = scheduleMap['NEVER_CHOICE'];
    this.scheduleEndsNumberOfTimes = scheduleMap['NUMBER_OF_TIMES'];
    this.scheduleEndsDate = scheduleMap['ENDS_DATE'];
  }
}
