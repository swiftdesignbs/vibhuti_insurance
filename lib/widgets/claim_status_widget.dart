import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:vibhuti_insurance_mobile_app/alerts/toast.dart';
import 'package:vibhuti_insurance_mobile_app/utils/app_text_theme.dart';

class ClaimStatusWidget extends StatelessWidget {
  final String title;
  final String description;
  final String status; // "completed", "under_process", "pending"
  final bool hasBadge;
  final String badgeText;
  final bool isCurrent;
  final VoidCallback? onPendingAction; // callback for pending button

  const ClaimStatusWidget({
    super.key,
    required this.title,
    required this.description,
    required this.status,
    this.isCurrent = false,
    this.hasBadge = false,
    this.badgeText = "",
    this.onPendingAction,
  });

  Color _getStatusColor() {
    switch (status.toLowerCase()) {
      case "completed":
        return Color(0XFF3BCF85);
      case "pending":
        return Color(0XFFFF8306);
      default:
        return Colors.grey;
    }
  }

  IconData _getStatusIcon() {
    switch (status.toLowerCase()) {
      case "completed":
        return Icons.check;
      case "pending":
        return Icons.warning_amber_rounded;
      default:
        return Icons.circle;
    }
  }

  @override
  Widget build(BuildContext context) {
    final color = _getStatusColor();
    final icon = _getStatusIcon();

    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Column(
          children: [
           // const SizedBox(height: 6), // ✅ push hexagon down
            // CustomPaint(
            //   size: const Size(40, 40),
            //   painter: HexagonPainter(color),
            //   child: SizedBox(
            //     width: 40,
            //     height: 40,
            //     child: Center(child: Icon(icon, color: Colors.white, size: 18)),
            //   ),
            // ),
            SizedBox(
              width: 40,
              child: Column(
                children: [
                  const SizedBox(
                    height: 9,
                  ), // ✅ pushes icon down to align with title
                  SvgPicture.asset(
                    status.toLowerCase() == "completed"
                        ? "assets/icons/check.svg"
                        : "assets/icons/exclamation.svg",
                    width: 40,
                    height: 40,
                  ),
                ],
              ),
            ),

            SizedBox(height: 15),
            if (!isCurrent) Container(width: 8, height: 30, decoration: BoxDecoration(color: color, borderRadius: BorderRadius.circular(15)),),
          ],
        ),
        const SizedBox(width: 16),
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(title, style: AppTextTheme.subTitle),
              const SizedBox(height: 8),
              Text(description, style: AppTextTheme.paragraph),

              if (hasBadge && badgeText.isNotEmpty) ...[
                const SizedBox(height: 8),
                Container(
                  padding: const EdgeInsets.symmetric(
                    horizontal: 12,
                    vertical: 6,
                  ),
                  decoration: BoxDecoration(
                    color: AppTextTheme.primaryColor.withOpacity(0.1),
                    borderRadius: BorderRadius.circular(15),
                    border: Border.all(color: AppTextTheme.primaryColor),
                  ),
                  child: Text(
                    badgeText,
                    style: TextStyle(
                      fontSize: 12,
                      fontWeight: FontWeight.bold,
                      color: AppTextTheme.primaryColor,
                    ),
                  ),
                ),
              ],

              // ✅ Show TextButton if status == pending
              if (status.toLowerCase() == "pending") ...[
                TextButton(
                  onPressed:
                      onPendingAction ??
                      () {
                        CustomToast.show(
                          context: context,
                          message: 'Pending action clicked!',
                          success: true,
                        );
                      },
                  style: TextButton.styleFrom(
                    foregroundColor: AppTextTheme.primaryColor,
                    padding: const EdgeInsets.symmetric(
                      horizontal: 0,
                      vertical: 6,
                    ),
                    textStyle: const TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: 14,
                    ),
                  ),
                  child: Text(
                    "View Details",
                    style: AppTextTheme.subTitle.copyWith(
                      color: AppTextTheme.primaryColor,
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                ),
              ],
            ],
          ),
        ),
      ],
    );
  }
}

class HexagonPainter extends CustomPainter {
  final Color color;
  HexagonPainter(this.color);

  @override
  void paint(Canvas canvas, Size size) {
    final Paint paint = Paint()..color = color;
    final Path path = Path();

    double width = size.width;
    double height = size.height;

    path.moveTo(width * 0.5, 0);
    path.lineTo(width, height * 0.25);
    path.lineTo(width, height * 0.75);
    path.lineTo(width * 0.5, height);
    path.lineTo(0, height * 0.75);
    path.lineTo(0, height * 0.25);
    path.close();

    canvas.drawPath(path, paint);
  }

  @override
  bool shouldRepaint(CustomPainter oldDelegate) => false;
}
