import 'package:flutter/material.dart';
import 'package:fl_chart/fl_chart.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:kobi/presentation/widget/reusables.dart';

class ExpenseChart extends StatelessWidget {
  final Map<String, double> dataMap;
  final double total;
  final String currentFilter;

  const ExpenseChart({
    super.key,
    required this.dataMap,
    required this.total,
    required this.currentFilter,
  });

  Color _categoryColor(String category) {
    switch (category.toLowerCase()) {
      case 'subscription':
        return const Color(0xFFFC5C7D);
      case 'music':
        return const Color(0xFF6A82FB);
      case 'fitness':
        return const Color(0xFF56ab2f);
      case 'utilities':
        return const Color(0xFFbb6bd9);
      default:
        return const Color(0xFF2D9CDB);
    }
  }

  double _getStartAngle() {
    switch (currentFilter.toLowerCase()) {
      case 'may':
        return 270;
      case 'april':
        return 90;
      case 'all':
      default:
        return 180;
    }
  }

  @override
  Widget build(BuildContext context) {
    final List<PieChartSectionData> sections = dataMap.entries.map((entry) {
      final color = _categoryColor(entry.key);
      return PieChartSectionData(
        color: color,
        value: entry.value,
        title: '',
        radius: 40.r,
        showTitle: false,
      );
    }).toList();

    return Container(
      margin: EdgeInsets.symmetric(horizontal: 16.w),
      width: double.infinity,
      child: Column(
        children: [
          SizedBox(
            height: 240.h,
            child: Stack(
              alignment: Alignment.center,
              children: [
                PieChart(
                  PieChartData(
                    sections: sections,
                    centerSpaceRadius: 70.r,
                    sectionsSpace: 3,
                    startDegreeOffset: _getStartAngle(),
                    borderData: FlBorderData(show: false),
                  ),
                ),
                Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    reusableText(
                      '\$${total.toStringAsFixed(2)}',
                      textColor,
                      22.sp,
                      FontWeight.w700,
                      0.5,
                    ),
                    SizedBox(height: 4.h),
                    reusableText(
                      'Netflix Expenses',
                      textColor,
                      14.sp,
                      FontWeight.w500,
                      0,
                    ),
                  ],
                ),
              ],
            ),
          ),
          sb(h: 16.h),
          Wrap(
            spacing: 12.w,
            runSpacing: 8.h,
            alignment: WrapAlignment.center,
            children: dataMap.keys.map((category) {
              final color = _categoryColor(category);
              return Row(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Container(
                    width: 12.w,
                    height: 12.h,
                    margin: EdgeInsets.only(right: 6.w),
                    decoration: BoxDecoration(
                      color: color,
                      shape: BoxShape.circle,
                    ),
                  ),
                  Text(
                    category,
                    style: TextStyle(fontSize: 12.sp),
                  ),
                ],
              );
            }).toList(),
          ),
        ],
      ),
    );
  }
}
