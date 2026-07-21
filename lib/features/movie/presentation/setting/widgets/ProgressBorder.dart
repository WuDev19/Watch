import 'package:flutter/material.dart';

import '../../../../../core/colors/VColors.dart';

class ProgressBorder extends StatelessWidget {
  final Widget child;
  final double progress; // 0.0 -> 1.0
  final double borderWidth;
  final double borderRadius;
  final Color progressColor;
  final Color backgroundColor;

  const ProgressBorder({
    super.key,
    required this.child,
    required this.progress,
    this.borderWidth = 4,
    this.borderRadius = 20,
    this.progressColor =  VColors.colorIcon,
    this.backgroundColor = VColors.white,
  });

  @override
  Widget build(BuildContext context) {
    return CustomPaint(
      foregroundPainter: _ProgressPainter(
        progress: progress,
        strokeWidth: borderWidth,
        radius: borderRadius,
        color: progressColor,
        backgroundColor: backgroundColor,
      ),
      child: Padding(
        padding: EdgeInsets.all(borderWidth),
        child: ClipRRect(
          borderRadius: BorderRadius.circular(borderRadius - borderWidth),
          child: child,
        ),
      ),
    );
  }
}

class _ProgressPainter extends CustomPainter {
  final double progress;
  final double strokeWidth;
  final double radius;
  final Color color;
  final Color backgroundColor;

  _ProgressPainter({
    required this.progress,
    required this.strokeWidth,
    required this.radius,
    required this.color,
    required this.backgroundColor,
  });

  @override
  void paint(Canvas canvas, Size size) {
    final rect = (Offset.zero & size).deflate(strokeWidth / 2);
    final rrect = RRect.fromRectAndRadius(rect, Radius.circular(radius));

    final bgPaint = Paint()
      ..color = backgroundColor
      ..style = PaintingStyle.stroke
      ..strokeWidth = strokeWidth;

    final progressPaint = Paint()
      ..color = color
      ..style = PaintingStyle.stroke
      ..strokeWidth = strokeWidth
      ..strokeCap = StrokeCap.round;

    // Vẽ nền viền (100%) — dùng RRect có sẵn, không cần quan tâm điểm bắt đầu
    canvas.drawRRect(rrect, bgPaint);

    // Tự dựng path bắt đầu từ giữa cạnh trái, đi theo chiều kim đồng hồ
    final r = Radius.circular(radius);
    final midY = rect.top + rect.height / 2;

    final progressPath = Path()
      ..moveTo(rect.left, midY) // điểm bắt đầu: giữa cạnh trái
      ..lineTo(rect.left, rect.top + radius) // đi lên theo cạnh trái
      ..arcToPoint(Offset(rect.left + radius, rect.top), radius: r, clockwise: true) // bo góc trên-trái
      ..lineTo(rect.right - radius, rect.top) // cạnh trên
      ..arcToPoint(Offset(rect.right, rect.top + radius), radius: r, clockwise: true) // bo góc trên-phải
      ..lineTo(rect.right, rect.bottom - radius) // cạnh phải
      ..arcToPoint(Offset(rect.right - radius, rect.bottom), radius: r, clockwise: true) // bo góc dưới-phải
      ..lineTo(rect.left + radius, rect.bottom) // cạnh dưới
      ..arcToPoint(Offset(rect.left, rect.bottom - radius), radius: r, clockwise: true) // bo góc dưới-trái
      ..lineTo(rect.left, midY); // đi lên tiếp về lại điểm bắt đầu

    final metric = progressPath.computeMetrics().first;
    final totalLength = metric.length;
    final progressLength = totalLength * progress.clamp(0.0, 1.0);

    if (progressLength <= 0) return;

    canvas.drawPath(
      metric.extractPath(0, progressLength),
      progressPaint,
    );
  }

  @override
  bool shouldRepaint(covariant _ProgressPainter old) {
    return old.progress != progress ||
        old.color != color ||
        old.backgroundColor != backgroundColor;
  }
}