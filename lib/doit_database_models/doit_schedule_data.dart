class RepeatData {
  int repeatId;
  //String scheduleRepeatDate;
  int repeatStatus;
  int repeatFrequencyChoice;
  int repeatEvery;
  String repeatRepeatOnWeek;
  String repeatRepeatOnMonth;
  int repeatEndChoice;
  int repeatEndAfterXTimes;
  String repeatEndOnDate;

  RepeatData(
      {this.repeatId,
      //this.scheduleRepeatDate,
      this.repeatStatus,
      this.repeatFrequencyChoice,
      this.repeatEvery,
      this.repeatRepeatOnWeek,
      this.repeatRepeatOnMonth,
      this.repeatEndChoice,
      this.repeatEndAfterXTimes,
      this.repeatEndOnDate});

// Hàm để convert list data vào 1 map object để lưu trữ
  Map<String, dynamic> toMap() {
    var repeatMap = Map<String, dynamic>();

    if (repeatId != null) {
      repeatMap['REPEAT_ID'] = repeatId;
    }
    //scheduleMap['REPEAT_DATE'] = scheduleRepeatDate;
    repeatMap['REPEAT_STATUS'] = repeatStatus;
    repeatMap['REPEAT_FREQUENCY_CHOICE'] = repeatFrequencyChoice;
    repeatMap['REPEAT_EVERY'] = repeatEvery;
    repeatMap['REPEAT_ON_WEEK'] = repeatRepeatOnWeek;
    repeatMap['REPEAT_ON_MONTH'] = repeatRepeatOnMonth;
    repeatMap['END_CHOICE'] = repeatEndChoice;
    repeatMap['END_AFTER_X_TIMES'] = repeatEndAfterXTimes;
    repeatMap['END_ON_DATE'] = repeatEndOnDate;

    return repeatMap;
  }

  // Constructor để phân tách ListData object từ một Map object
  RepeatData.fromScheduleMapObject(Map<String, dynamic> repeatMap) {
    this.repeatId = repeatMap['REPEAT_ID'];

    //this.scheduleRepeatDate = scheduleMap['REPEAT_DATE'];
    this.repeatStatus = repeatMap['REPEAT_STATUS'];
    this.repeatFrequencyChoice = repeatMap['REPEAT_FREQUENCY_CHOICE'];
    this.repeatEvery = repeatMap['REPEAT_EVERY'];
    this.repeatRepeatOnWeek = repeatMap['REPEAT_ON_WEEK'];
    this.repeatRepeatOnMonth = repeatMap['REPEAT_ON_MONTH'];
    this.repeatEndChoice = repeatMap['END_CHOICE'];
    this.repeatEndAfterXTimes = repeatMap['END_AFTER_X_TIMES'];
    this.repeatEndOnDate = repeatMap['END_ON_DATE'];
  }
}
