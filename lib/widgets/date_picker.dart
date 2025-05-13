import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:syncfusion_flutter_datepicker/datepicker.dart';
// ignore: depend_on_referenced_packages

/// My app class to display the date range picker
class DatePicker extends StatefulWidget {
  final Function(String, String) onDateRangeSelected;

  const DatePicker({super.key, required this.onDateRangeSelected});

  @override
  DatePickerState createState() => DatePickerState();
}

/// State for DatePicker
class DatePickerState extends State<DatePicker> {
  void _onSelectionChanged(DateRangePickerSelectionChangedArgs args) {
    if (args.value is PickerDateRange) {
      final start = args.value.startDate;
      final end = args.value.endDate ?? args.value.startDate;
      widget.onDateRangeSelected(
        DateFormat('yyyy-MM-dd').format(start),
        DateFormat('yyyy-MM-dd').format(end),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: <Widget>[
        Positioned(
          left: 0,
          top: 80,
          right: 0,
          bottom: 0,
          child: SfDateRangePicker(
            onSelectionChanged: _onSelectionChanged,
            selectionMode: DateRangePickerSelectionMode.range,
            view: DateRangePickerView.month,
            showActionButtons: true,
            onSubmit: (Object? val) {
              if (val is PickerDateRange) {
                final start = val.startDate;
                final end = val.endDate ?? val.startDate;
                widget.onDateRangeSelected(
                  DateFormat('yyyy-MM-dd').format(start!),
                  DateFormat('yyyy-MM-dd').format(end!),
                );
                Navigator.pop(context);
              }
            },
            onCancel: () {
              Navigator.pop(context);
            },
            initialSelectedRange: PickerDateRange(
              DateTime.now().subtract(const Duration(days: 4)),
              DateTime.now().add(const Duration(days: 3)),
            ),
          ),
        ),
      ],
    );
  }
}
