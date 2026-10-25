import 'package:coffee_empire/cafe/camera_fit.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  test('room fits at the largest whole-number scale and is centered', () {
    final fit = CameraFit.compute(
      viewWidth: 390,
      viewHeight: 600,
      cols: 8,
      rows: 10,
    );
    expect(fit.scale, 3);
    expect(fit.offsetX, closeTo((130 - 128) / 2, 1e-9));
    expect(fit.offsetY, closeTo((200 - 160) / 2, 1e-9));
    expect(fit.needsPan, isFalse);
  });

  test('scale never drops below 2 and then needs panning', () {
    final fit = CameraFit.compute(
      viewWidth: 200,
      viewHeight: 200,
      cols: 8,
      rows: 10,
    );
    expect(fit.scale, 2);
    expect(fit.needsPan, isTrue);
  });
}
