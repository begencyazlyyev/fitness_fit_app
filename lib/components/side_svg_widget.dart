import 'package:flutter/material.dart';
import 'package:flutter_application_1/components/text_style_widget.dart';
import 'package:flutter_application_1/data/notifiers.dart';
import 'package:flutter_svg/svg.dart';

class SideWidget extends StatelessWidget {
  final int index; // ← ADD THIS
  final String imageActive;
  final String imageInactive;
  final String title;
  final VoidCallback onTap;

  const SideWidget({
    super.key,
    required this.index, // ← ADD THIS
    required this.imageActive,
    required this.imageInactive,
    required this.title,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return ValueListenableBuilder(
      valueListenable: selectedPageNotifier,
      builder: (context, selectedPage, child) {
        final isSelected = selectedPage == index; // ← CLEAN BOOL

        return Card(
          color: isSelected ? Colors.white : Colors.transparent,
          elevation: 0,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(10),
          ),
          clipBehavior: Clip.antiAlias,
          child: Container(
            decoration: BoxDecoration(
              border: Border(
                left: BorderSide(
                  color: isSelected
                      ? const Color(0xFFE24B4A)
                      : Colors.transparent,
                  width: 3,
                ),
                bottom: BorderSide(
                  color: selectedPage == index
                      ? const Color(0xFFE24B4A)
                      : Colors.transparent,
                  width: 0.5,
                ),
              ),
            ),
            child: ListTile(
              contentPadding: const EdgeInsets.symmetric(
                horizontal: 14,
                vertical: 4,
              ),
              leading: Container(
                width: 36,
                height: 36,
                decoration: BoxDecoration(
                  color: isSelected ? const Color(0xFFFCEBEB) : Colors.white,
                  borderRadius: BorderRadius.circular(8),
                  border: isSelected
                      ? null
                      : Border.all(color: const Color(0xFF899499), width: 0.5),
                ),
                child: Center(
                  child: SvgPicture.asset(
                    isSelected ? imageActive : imageInactive,
                    width: 18,
                    height: 18,
                    colorFilter: ColorFilter.mode(
                      isSelected
                          ? const Color(0xFFE24B4A)
                          : const Color(0xFF899499),
                      BlendMode.srcIn,
                    ),
                  ),
                ),
              ),
              title: Text(
                title,
                style: KTextStyle.drawerText.copyWith(
                  fontSize: 14,
                  fontWeight: isSelected ? FontWeight.w500 : FontWeight.w400,
                  color: isSelected
                      ? const Color(0xFFA52A2A) // Text
                      : const Color(0xFF899499),
                  letterSpacing: 0.1,
                ),
              ),
              trailing: isSelected
                  ? Container(
                      width: 6,
                      height: 6,
                      decoration: const BoxDecoration(
                        color: Color(0xFFE24B4A),
                        shape: BoxShape.circle,
                      ),
                    )
                  : null,
              onTap: onTap,
            ),
          ),
        );
      },
    );
  }
}
