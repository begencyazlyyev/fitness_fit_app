import 'package:flutter/material.dart';

class DateOfBirthWidget extends StatefulWidget {
  final DateTime? value;
  final ValueChanged<DateTime?> onChanged;

  const DateOfBirthWidget({
    super.key,
    required this.value,
    required this.onChanged,
  });

  @override
  State<DateOfBirthWidget> createState() => _DateOfBirthWidgetState();
}

class _DateOfBirthWidgetState extends State<DateOfBirthWidget> {
  late int _selectedDay;
  late int _selectedMonth;
  late int _selectedYear;

  final List<String> _months = [
    "January",
    "February",
    "March",
    "April",
    "May",
    "June",
    "July",
    "August",
    "September",
    "October",
    "November",
    "December",
  ];

  void _openDatePicker() {
    final DateTime now = DateTime.now();
    _selectedDay = widget.value?.day ?? now.day;
    _selectedMonth = widget.value?.month ?? now.month;
    _selectedYear = widget.value?.year ?? now.year;

    showModalBottomSheet(
      context: context,
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(top: Radius.circular(20)),
      ),
      builder: (context) {
        return StatefulBuilder(
          builder: (context, setModalState) {
            final int daysInMonth = DateUtils.getDaysInMonth(
              _selectedYear,
              _selectedMonth,
            );

            return Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 16),
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  // Handle bar
                  Container(
                    width: 40,
                    height: 4,
                    decoration: BoxDecoration(
                      color: Colors.grey.shade300,
                      borderRadius: BorderRadius.circular(10),
                    ),
                  ),
                  const SizedBox(height: 16),
                  const Text(
                    "Date of Birth",
                    style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
                  ),
                  const SizedBox(height: 16),

                  // Pickers row
                  SizedBox(
                    height: 180,
                    child: Row(
                      children: [
                        // Day picker
                        Expanded(
                          child: ListWheelScrollView.useDelegate(
                            itemExtent: 44,
                            perspective: 0.003,
                            diameterRatio: 1.5,
                            physics: const FixedExtentScrollPhysics(),
                            controller: FixedExtentScrollController(
                              initialItem: _selectedDay - 1,
                            ),
                            onSelectedItemChanged: (i) {
                              setModalState(() => _selectedDay = i + 1);
                            },
                            childDelegate: ListWheelChildBuilderDelegate(
                              childCount: daysInMonth,
                              builder: (context, index) {
                                final isSelected = index + 1 == _selectedDay;
                                return Center(
                                  child: Text(
                                    "${index + 1}",
                                    style: TextStyle(
                                      fontSize: isSelected ? 18 : 15,
                                      fontWeight: isSelected
                                          ? FontWeight.bold
                                          : FontWeight.normal,
                                      color: isSelected
                                          ? const Color(0xFF36454F)
                                          : Colors.grey,
                                    ),
                                  ),
                                );
                              },
                            ),
                          ),
                        ),

                        // Month picker
                        Expanded(
                          flex: 2,
                          child: ListWheelScrollView.useDelegate(
                            itemExtent: 44,
                            perspective: 0.003,
                            diameterRatio: 1.5,
                            physics: const FixedExtentScrollPhysics(),
                            controller: FixedExtentScrollController(
                              initialItem: _selectedMonth - 1,
                            ),
                            onSelectedItemChanged: (i) {
                              setModalState(() => _selectedMonth = i + 1);
                            },
                            childDelegate: ListWheelChildBuilderDelegate(
                              childCount: 12,
                              builder: (context, index) {
                                final isSelected = index + 1 == _selectedMonth;
                                return Center(
                                  child: Text(
                                    _months[index],
                                    style: TextStyle(
                                      fontSize: isSelected ? 18 : 15,
                                      fontWeight: isSelected
                                          ? FontWeight.bold
                                          : FontWeight.normal,
                                      color: isSelected
                                          ? const Color(0xFF36454F)
                                          : Colors.grey,
                                    ),
                                  ),
                                );
                              },
                            ),
                          ),
                        ),

                        // Year picker
                        Expanded(
                          child: ListWheelScrollView.useDelegate(
                            itemExtent: 44,
                            perspective: 0.003,
                            diameterRatio: 1.5,
                            physics: const FixedExtentScrollPhysics(),
                            controller: FixedExtentScrollController(
                              initialItem: now.year - _selectedYear,
                            ),
                            onSelectedItemChanged: (i) {
                              setModalState(() => _selectedYear = now.year - i);
                            },
                            childDelegate: ListWheelChildBuilderDelegate(
                              childCount: now.year - 1900 + 1,
                              builder: (context, index) {
                                final year = now.year - index;
                                final isSelected = year == _selectedYear;
                                return Center(
                                  child: Text(
                                    "$year",
                                    style: TextStyle(
                                      fontSize: isSelected ? 18 : 15,
                                      fontWeight: isSelected
                                          ? FontWeight.bold
                                          : FontWeight.normal,
                                      color: isSelected
                                          ? const Color(0xFF36454F)
                                          : Colors.grey,
                                    ),
                                  ),
                                );
                              },
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),

                  // Divider lines around selected item
                  const Divider(color: Color(0xFFE5E7EB)),
                  const SizedBox(height: 10),

                  // Confirm button
                  SizedBox(
                    width: double.infinity,
                    height: 48,
                    child: ElevatedButton(
                      style: ElevatedButton.styleFrom(
                        backgroundColor: const Color(0xFF36454F),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(10),
                        ),
                      ),
                      onPressed: () {
                        final selected = DateTime(
                          _selectedYear,
                          _selectedMonth,
                          _selectedDay.clamp(1, daysInMonth),
                        );
                        widget.onChanged(selected);
                        Navigator.pop(context);
                      },
                      child: const Text(
                        "Confirm",
                        style: TextStyle(
                          fontSize: 16,
                          fontWeight: FontWeight.bold,
                          color: Colors.white,
                        ),
                      ),
                    ),
                  ),
                  const SizedBox(height: 10),
                ],
              ),
            );
          },
        );
      },
    );
  }

  String _formatDate(DateTime date) {
    return "${date.day.toString().padLeft(2, '0')} / "
        "${date.month.toString().padLeft(2, '0')} / "
        "${date.year}";
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 25),
      child: GestureDetector(
        onTap: _openDatePicker,
        child: Container(
          height: 48,
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(8),
            color: Colors.grey.shade50,
            border: Border.all(width: 1.2, color: Colors.grey.shade400),
          ),
          child: Row(
            children: [
              const SizedBox(width: 12),
              const Icon(Icons.calendar_today_outlined, color: Colors.grey),
              const SizedBox(width: 12),
              Text(
                widget.value != null
                    ? _formatDate(widget.value!)
                    : "Date of Birth",
                style: TextStyle(
                  color: widget.value != null ? Colors.black : Colors.grey,
                  fontSize: 16,
                ),
              ),
              const Spacer(),
              const Icon(Icons.keyboard_arrow_down, color: Colors.grey),
              const SizedBox(width: 12),
            ],
          ),
        ),
      ),
    );
  }
}
