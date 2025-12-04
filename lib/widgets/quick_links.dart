import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';

class ExpandableQuickLink extends StatefulWidget {
  final String title;

  final Widget expandedContent;

  const ExpandableQuickLink({
    super.key,
    required this.title,

    required this.expandedContent,
  });

  @override
  State<ExpandableQuickLink> createState() => _ExpandableQuickLinkState();
}

class _ExpandableQuickLinkState extends State<ExpandableQuickLink>
    with SingleTickerProviderStateMixin {
  bool isExpanded = false;

  late AnimationController _controller;
  late Animation<double> _arrowRotation;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 250),
    );

    _arrowRotation = Tween<double>(
      begin: 0.0,
      end: 0.5,
    ).animate(CurvedAnimation(parent: _controller, curve: Curves.easeInOut));
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  void toggleExpand() {
    setState(() {
      isExpanded = !isExpanded;
      isExpanded ? _controller.forward() : _controller.reverse();
    });
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        // Main header clickable row
        InkWell(
          onTap: toggleExpand,
          child: Padding(
            padding: const EdgeInsets.symmetric(vertical: 12.0, horizontal: 4),
            child: Row(
              children: [
                SvgPicture.asset(
                  'assets/icons/user_manual.svg',
                  height: 24,
                  width: 24,
                ),
                const SizedBox(width: 12),
                // Title
                Text(
                  widget.title,
                  style: const TextStyle(
                    fontSize: 18,
                    color: Colors.black87,
                    fontWeight: FontWeight.w500,
                  ),
                ),

                const SizedBox(width: 8),

                // Dashed line
                Expanded(
                  child: LayoutBuilder(
                    builder: (context, constraints) {
                      final dashWidth = 6.0;
                      final dashSpace = 4.0;
                      final dashCount =
                          (constraints.maxWidth / (dashWidth + dashSpace))
                              .floor();

                      return Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: List.generate(dashCount, (_) {
                          return Container(
                            width: dashWidth,
                            height: 1,
                            color: Colors.grey,
                          );
                        }),
                      );
                    },
                  ),
                ),

                const SizedBox(width: 10),

                // Rotating arrow
                RotationTransition(
                  turns: _arrowRotation,
                  child: const Icon(
                    Icons.keyboard_arrow_down_rounded,
                    size: 28,
                    color: Colors.black87,
                  ),
                ),
              ],
            ),
          ),
        ),

        // Expandable content with animation
        AnimatedSize(
          duration: const Duration(milliseconds: 300),
          curve: Curves.easeInOut,
          child: isExpanded
              ? Padding(
                  padding: const EdgeInsets.only(bottom: 12, left: 8, right: 8),
                  child: widget.expandedContent,
                )
              : const SizedBox.shrink(),
        ),
      ],
    );
  }
}
