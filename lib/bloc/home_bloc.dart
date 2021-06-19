import 'package:rxdart/rxdart.dart';

class HomeBLoC {
  List<String> strList = [];
  var channelStrList = BehaviorSubject<List<String>>();

  void addValToChannel(val) {
    strList.add(val);
    channelStrList.add(strList);
  }
  void dispose() {
    channelStrList.close();
  }
}