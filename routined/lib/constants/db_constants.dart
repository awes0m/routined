

dateToString(DateTime d) => d.toIso8601String();
stringToDateTime(s) => DateTime.parse(s);

timeToTimeInSecs(String time){
  List<String> timeList = time.split(":");
  int hours = int.parse(timeList[0]);
  int minutes = int.parse(timeList[1]);
  int seconds = int.parse(timeList[2]);
  return hours * 3600 + minutes * 60 + seconds;

}
