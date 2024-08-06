class AppUsage{
  late Duration? totalUsage;
  List<TopApps>?topApps;
  String?dayDate;
  AppUsage({this.dayDate,this.topApps,this.totalUsage});
  factory AppUsage.usageOfApps(Map<dynamic,dynamic>data){
    List<TopApps>? list=data['topApps']!=null?(data['topApps'] as  List).map((topApp) => TopApps.fromAppUsage(topApp)).toList():null;
    return AppUsage(
      topApps:list,
      dayDate: data["date"] as String,
      totalUsage: fillTotalUsage(list??[]),
    );
  }
  static Duration fillTotalUsage(List<TopApps>list){
    Duration totalDuration=const Duration();
    for(var item in list){
      totalDuration+=item.timeUsage??const Duration();
    }
    return totalDuration;
  }
}





class TopApps{
  String?appName;
  Duration?timeUsage;
  String?appIcon;
  TopApps({this.appIcon, this.appName, this.timeUsage});
  factory TopApps.fromAppUsage(Map<dynamic,dynamic>usage){
   return TopApps(
     appIcon:usage['appIcon'] as String,
     appName: removeSpecifiedWords(usage['appName']as String),
     timeUsage: toDuration(usage['totalTimeInForeground']as int),
   );
  }
}
Duration toDuration(int milliseconds) {
  final duration = Duration(milliseconds: milliseconds);
  return duration;
}

List<String>removedWord=["com",".","katana","android","org","web"];
String removeSpecifiedWords(String originalString,) {
  String newString = originalString;

  for (String word in removedWord) {
    newString = newString.replaceAll(word,'');
  }
  newString = newString.replaceAll(RegExp(r'\s+'), ' ').trim();

  return newString;
}