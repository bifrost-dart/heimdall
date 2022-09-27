import 'package:heimdall/core.dart';

List<dynamic> flattenForever(List<dynamic> list, List<dynamic> result) {
  for (var i = 0; i < list.length; i++) {
    var item = list[i];

    if (item is List<dynamic>) {
      flattenForever(item, result);
    } else {
      result.add(item);
    }
  }

  return result;
}

List<dynamic> listFlatten(List<dynamic> list) {
  return flattenForever(list, []);
}
