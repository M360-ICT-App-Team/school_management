import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

import '../../../../../core/constants/app_colors.dart';
import '../../data/model/current_semester_list_model.dart';



/// ---- Card Widget ----
class SemesterPagerCard extends StatefulWidget {
  final List<CurrentSemesterListModel> items;
  final EdgeInsets padding;
  const SemesterPagerCard({
    super.key,
    required this.items,
    this.padding = const EdgeInsets.all(12),
  });

  @override
  State<SemesterPagerCard> createState() => _SemesterPagerCardState();
}

class _SemesterPagerCardState extends State<SemesterPagerCard> {
  int index = 0;

  void _next() {
    if (index < widget.items.length - 1) {
      setState(() => index++);
    }
  }

  void _prev() {
    if (index > 0) {
      setState(() => index--);
    }
  }

  @override
  Widget build(BuildContext context) {
    if (widget.items.isEmpty) {
      return _shell(
        child: const Center(child: Text('কোনো ডাটা পাওয়া যায়নি')),
        canPrev: false,
        canNext: false,
      );
    }
    final item = widget.items[index];
    final df = DateFormat('dd MMM, yyyy');

    final canPrev = index > 0;
    final canNext = index < widget.items.length - 1;

    return _shell(
      canPrev: canPrev,
      canNext: canNext,
      onPrev: _prev,
      onNext: _next,
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          // Title line (e.g., "৪র্থ সেমিস্টার")
          Text(
            item.semester,
            style: const TextStyle(fontSize: 18, fontWeight: FontWeight.w700),
          ),
          const SizedBox(height: 8),
          _row('মোট উপস্থিতঃ', '${item.totalPresent} দিন'),
          _row('মোট অনুপস্থিতঃ', '${item.totalAbsent} দিন'),
          _row('মোট ছুটিঃ', '${item.totalLeave} দিন'),
          _row('মোট সিদ্ধান্ত হয়নিঃ', '${item.totalNoAction} দিন'),
          const SizedBox(height: 6),
        ],
      ),
    );
  }

  Widget _row(String left, String right) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 2),
      child: Text('$left $right',
          style: const TextStyle(fontSize: 14, color: Colors.black87)),
    );
  }

  Widget _shell({
    required Widget child,
    bool canPrev = true,
    bool canNext = true,
    VoidCallback? onPrev,
    VoidCallback? onNext,
  }) {
    return Padding(
      padding: const EdgeInsets.all(12.0),
      child: Container(
        padding: widget.padding,
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(14),
          border: Border.all(color: AppColors.blue, width: 2),
          boxShadow: [
            BoxShadow(
              color: Colors.black.withOpacity(.05),
              blurRadius: 10,
              offset: const Offset(0, 3),
            )
          ],
        ),
        child: Row(
          children: [
            _arrowButton(
              icon: Icons.keyboard_arrow_left,
              enabled: canPrev,
              onTap: onPrev,
            ),
            const SizedBox(width: 6),
            Expanded(child: child),
            const SizedBox(width: 6),
            _arrowButton(
              icon: Icons.keyboard_arrow_right,
              enabled: canNext,
              onTap: onNext,
            ),
          ],
        ),
      ),
    );
  }

  Widget _arrowButton({
    required IconData icon,
    required bool enabled,
    VoidCallback? onTap,
  }) {
    final bg = enabled ? const Color(0xFFEAF4FF) : const Color(0xFFF1F1F1);
    final fg = enabled ? Colors.black87 : Colors.black26;
    return InkWell(
      onTap: enabled ? onTap : null,
      borderRadius: BorderRadius.circular(999),
      child: Container(
        width: 34,
        height: 34,
        decoration: BoxDecoration(
          color: bg,
          shape: BoxShape.circle,
          border: Border.all(
            color: enabled ? const Color(0xFF9EC9FF) : const Color(0xFFDFDFDF),
          ),
        ),
        child: Icon(icon, color: fg),
      ),
    );
  }
}
