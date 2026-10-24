import 'dart:convert';
import 'dart:ui';

typedef JsonMap = Map<String, dynamic>;

class PaletteCatalog {
  PaletteCatalog({required this.slots, required this.sets});

  factory PaletteCatalog.fromJsonString(String source) {
    final json = jsonDecode(source) as JsonMap;
    return PaletteCatalog(
      slots: (json['slots'] as List<dynamic>).cast<String>(),
      sets: (json['sets'] as JsonMap).map(
        (name, colors) => MapEntry(
          name,
          (colors as JsonMap).map(
            (slot, hex) => MapEntry(slot, parseHexColor(hex as String)),
          ),
        ),
      ),
    );
  }

  static const String baseSet = 'base';
  static const String separator = '+';

  final List<String> slots;
  final Map<String, Map<String, Color>> sets;
  final Map<String, Map<String, Color>> _resolved = {};

  static String keyOf(Iterable<String> overlays) =>
      [baseSet, ...overlays.where((name) => name != baseSet)].join(separator);

  Map<String, Color> resolve(String paletteKey) =>
      _resolved.putIfAbsent(paletteKey, () {
        final colors = <String, Color>{...?sets[baseSet]};
        for (final name in paletteKey.split(separator)) {
          if (name == baseSet) continue;
          final overlay = sets[name];
          if (overlay == null) {
            throw ArgumentError.value(name, 'paletteKey', 'unknown palette');
          }
          colors.addAll(overlay);
        }
        return colors;
      });
}

Color parseHexColor(String hex) {
  final digits = hex.startsWith('#') ? hex.substring(1) : hex;
  if (digits.length != 6) throw FormatException('Invalid color: $hex');
  return Color(0xFF000000 | int.parse(digits, radix: 16));
}
