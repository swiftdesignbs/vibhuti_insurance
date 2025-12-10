import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:vibhuti_insurance_mobile_app/utils/app_text_theme.dart';

class CustomDropdownOverlay extends StatefulWidget {
  final String label;
  final List<String> options;
  final String? selectedValue;
  final Function(String) onSelected;
  final bool? enabled; // <-- added

  const CustomDropdownOverlay({
    super.key,
    required this.label,
    required this.options,
    required this.selectedValue,
    required this.onSelected,
    this.enabled, // <-- added
  });

  @override
  State<CustomDropdownOverlay> createState() => _CustomDropdownOverlayState();
}

class _CustomDropdownOverlayState extends State<CustomDropdownOverlay> {
  final LayerLink _layerLink = LayerLink();
  OverlayEntry? _overlayEntry;
  bool isOpen = false;

  final TextEditingController controller = TextEditingController();

  @override
  void initState() {
    super.initState();
    controller.text = widget.selectedValue ?? "";
  }

  void toggleDropdown() {
    if (isOpen) {
      closeDropdown();
    } else {
      openDropdown();
    }
  }

  void openDropdown() {
    closeDropdown();
    final overlay = Overlay.of(context);

    _overlayEntry = OverlayEntry(
      builder: (context) {
        return Positioned(
          width: MediaQuery.of(context).size.width - 32,
          child: CompositedTransformFollower(
            link: _layerLink,
            offset: const Offset(0, 70),
            showWhenUnlinked: false,
            child: Material(
              // elevation: 4,
              color: Colors.transparent,
              child: Container(
                height: 260,
                padding: const EdgeInsets.symmetric(horizontal: 16),
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(30),
                  border: Border.all(
                    color: AppTextTheme.primaryColor,
                    width: 1,
                  ),
                ),
                child: ListView.builder(
                  padding: EdgeInsets.symmetric(vertical: 12),
                  itemCount: widget.options.length,
                  itemBuilder: (context, index) {
                    final item = widget.options[index];
                    return InkWell(
                      onTap: () {
                        widget.onSelected(item);
                        controller.text = item;
                        closeDropdown();
                      },
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(item, style: AppTextTheme.subItemTitle),
                          Divider(color: Colors.grey.shade300, thickness: 1),
                        ],
                      ),
                    );
                  },
                ),
              ),
            ),
          ),
        );
      },
    );

    overlay.insert(_overlayEntry!);
    setState(() => isOpen = true);
  }

  void closeDropdown() {
    _overlayEntry?.remove();
    _overlayEntry = null;
    setState(() => isOpen = false);
  }

  @override
  void didUpdateWidget(covariant CustomDropdownOverlay oldWidget) {
    super.didUpdateWidget(oldWidget);

    if (oldWidget.selectedValue != widget.selectedValue) {
      controller.text = widget.selectedValue ?? "";
    }
  }

  @override
  Widget build(BuildContext context) {
    return CompositedTransformTarget(
      link: _layerLink,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(widget.label, style: AppTextTheme.subItemTitle),
          const SizedBox(height: 5),

          // TEXT FIELD LOOK
          AbsorbPointer(
            absorbing: widget.enabled == false, // disable if false
            child: Opacity(
              opacity: widget.enabled == false ? 0.4 : 1.0,
              child: GestureDetector(
                onTap: toggleDropdown,
                child: Container(
                  height: 50,
                  padding: const EdgeInsets.symmetric(horizontal: 12),
                  decoration: BoxDecoration(
                    //  color: Colors.grey.shade100,
                    borderRadius: BorderRadius.circular(25),
                    border: Border.all(color: AppTextTheme.primaryColor),
                  ),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        controller.text.isEmpty ? "Select" : controller.text,
                        style: AppTextTheme.subItemTitle,
                      ),
                      SvgPicture.asset(
                        isOpen
                            ? "assets/icons/up_icon.svg"
                            : "assets/icons/down_icon.svg",
                        color: AppTextTheme.primaryColor,
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
