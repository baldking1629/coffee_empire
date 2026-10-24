import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';

import '../theme/app_colors.dart';

class FloatingTextEntry {
  FloatingTextEntry({
    required this.text,
    required this.globalPosition,
    required this.emphasized,
    required this.id,
  });

  final String text;
  final Offset globalPosition;
  final bool emphasized;
  final int id;
  Duration? startedAt;
}

class FloatingTextController extends ChangeNotifier {
  static const int maxEntries = 8;

  final List<FloatingTextEntry> _entries = [];
  int _nextId = 0;

  List<FloatingTextEntry> get entries => List.unmodifiable(_entries);

  void spawn(String text, Offset globalPosition, {bool emphasized = false}) {
    if (_entries.length >= maxEntries) _entries.removeAt(0);
    _entries.add(
      FloatingTextEntry(
        text: text,
        globalPosition: globalPosition,
        emphasized: emphasized,
        id: _nextId++,
      ),
    );
    notifyListeners();
  }

  void remove(FloatingTextEntry entry) {
    _entries.remove(entry);
    notifyListeners();
  }
}

class FloatingTextLayer extends StatefulWidget {
  const FloatingTextLayer({
    super.key,
    required this.controller,
    required this.child,
  });

  static const Duration lifetime = Duration(milliseconds: 900);
  static const double riseDistance = 70;

  final FloatingTextController controller;
  final Widget child;

  @override
  State<FloatingTextLayer> createState() => _FloatingTextLayerState();
}

class _FloatingTextLayerState extends State<FloatingTextLayer>
    with SingleTickerProviderStateMixin {
  late final Ticker _ticker = createTicker(_onTick);
  Duration _elapsed = Duration.zero;

  @override
  void initState() {
    super.initState();
    widget.controller.addListener(_onEntriesChanged);
  }

  @override
  void dispose() {
    widget.controller.removeListener(_onEntriesChanged);
    _ticker.dispose();
    super.dispose();
  }

  void _onEntriesChanged() {
    for (final entry in widget.controller.entries) {
      entry.startedAt ??= _elapsed;
    }
    if (widget.controller.entries.isNotEmpty && !_ticker.isActive) {
      _elapsed = Duration.zero;
      for (final entry in widget.controller.entries) {
        entry.startedAt = Duration.zero;
      }
      _ticker.start();
    }
    if (mounted) setState(() {});
  }

  void _onTick(Duration elapsed) {
    _elapsed = elapsed;
    final expired = widget.controller.entries.where(
      (entry) =>
          elapsed - (entry.startedAt ?? elapsed) >= FloatingTextLayer.lifetime,
    );
    for (final entry in expired.toList()) {
      widget.controller.remove(entry);
    }
    if (widget.controller.entries.isEmpty) _ticker.stop();
    if (mounted) setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    final box = context.findRenderObject();
    return Stack(
      clipBehavior: Clip.none,
      children: [
        widget.child,
        if (box is RenderBox && box.hasSize)
          for (final entry in widget.controller.entries)
            _buildEntry(box, entry),
      ],
    );
  }

  Widget _buildEntry(RenderBox box, FloatingTextEntry entry) {
    final age = _elapsed - (entry.startedAt ?? _elapsed);
    final progress =
        (age.inMicroseconds / FloatingTextLayer.lifetime.inMicroseconds).clamp(
          0.0,
          1.0,
        );
    final origin = box.globalToLocal(entry.globalPosition);
    final rise =
        Curves.easeOut.transform(progress) * FloatingTextLayer.riseDistance;
    return PositionedDirectional(
      key: ValueKey(entry.id),
      start: Directionality.of(context) == TextDirection.rtl
          ? box.size.width - origin.dx - 60
          : origin.dx - 60,
      top: origin.dy - 24 - rise,
      width: 120,
      child: IgnorePointer(
        child: Opacity(
          opacity: 1 - progress,
          child: Text(
            entry.text,
            textAlign: TextAlign.center,
            textDirection: TextDirection.ltr,
            maxLines: 1,
            overflow: TextOverflow.visible,
            style: TextStyle(
              color: entry.emphasized ? AppColors.copper : AppColors.mint,
              fontSize: entry.emphasized ? 26 : 20,
              fontWeight: FontWeight.w900,
              shadows: const [Shadow(color: AppColors.shadow, blurRadius: 6)],
            ),
          ),
        ),
      ),
    );
  }
}
