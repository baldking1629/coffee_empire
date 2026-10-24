import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/material.dart';

import '../../../app/theme/app_colors.dart';
import '../../../config/economy_config.dart';
import '../../../engine/lab_math.dart';
import '../../../l10n/app_localizations.dart';
import '../lab_labels.dart';

class FlavorRadar extends StatelessWidget {
  const FlavorRadar({super.key, required this.profile});

  static const int maxValue = 100;

  final FlavorProfile profile;

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context);
    RadarDataSet bounds(int value) => RadarDataSet(
      dataEntries: [
        for (final _ in FlavorAttribute.values)
          RadarEntry(value: value.toDouble()),
      ],
      fillColor: Colors.transparent,
      borderColor: Colors.transparent,
      entryRadius: 0,
    );
    return RadarChart(
      RadarChartData(
        dataSets: [
          bounds(0),
          bounds(maxValue),
          RadarDataSet(
            dataEntries: [
              for (final value in profile.values)
                RadarEntry(value: value.toDouble()),
            ],
            fillColor: AppColors.copper.withValues(alpha: 0.35),
            borderColor: AppColors.copper,
            borderWidth: 2,
            entryRadius: 3,
          ),
        ],
        radarShape: RadarShape.polygon,
        radarBackgroundColor: Colors.transparent,
        radarBorderData: const BorderSide(color: AppColors.cardBorder),
        gridBorderData: const BorderSide(color: AppColors.cardBorder),
        tickBorderData: const BorderSide(color: Colors.transparent),
        ticksTextStyle: const TextStyle(color: Colors.transparent, fontSize: 1),
        tickCount: 4,
        titleTextStyle: const TextStyle(
          color: AppColors.textSecondary,
          fontSize: 12,
        ),
        titlePositionPercentageOffset: 0.12,
        getTitle: (index, angle) => RadarChartTitle(
          text: flavorName(l10n, FlavorAttribute.values[index]),
        ),
      ),
    );
  }
}
