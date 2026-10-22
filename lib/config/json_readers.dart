import '../core/bignumber/big_number.dart';

typedef JsonMap = Map<String, dynamic>;

BigNumber readBig(JsonMap json, String key) => BigNumber.fromJson(json[key]);

double readDouble(JsonMap json, String key) => (json[key] as num).toDouble();

int readInt(JsonMap json, String key) => (json[key] as num).toInt();

String readString(JsonMap json, String key) => json[key] as String;

JsonMap readMap(JsonMap json, String key) => json[key] as JsonMap;

List<T> readList<T>(JsonMap json, String key, T Function(JsonMap) parse) =>
    (json[key] as List<dynamic>).cast<JsonMap>().map(parse).toList();

List<int> readIntList(JsonMap json, String key) =>
    (json[key] as List<dynamic>).cast<num>().map((n) => n.toInt()).toList();

List<double> readDoubleList(JsonMap json, String key) =>
    (json[key] as List<dynamic>).cast<num>().map((n) => n.toDouble()).toList();
