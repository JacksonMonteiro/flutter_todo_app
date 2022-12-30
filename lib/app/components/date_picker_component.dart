
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class DatePickerComponent extends StatelessWidget {
  final DateTime selectedDate;
  final Function(DateTime) onDateChanged;

  const DatePickerComponent({
    Key? key,
    required this.selectedDate,
    required this.onDateChanged,
  }) : super(key: key);

  _showDatePicker(BuildContext context) {
    showDatePicker(
      context: context,
      initialDate: DateTime.now(),
      firstDate: DateTime(2020),
      lastDate: DateTime.now(),
    ).then((pickedDate) {
      if (pickedDate == null) {
        return;
      }

      onDateChanged(pickedDate);
    });
  }

  @override
  Widget build(BuildContext context) {
    return SizedBox(
            height: 70,
            child: Row(children: [
              Expanded(
                child: Text(
                  'Data Selecionada: ${DateFormat('dd/MM/y').format(selectedDate)}',
                ),
              ),
              Container(
                margin: const EdgeInsets.only(left: 10),
                child: ElevatedButton(
                  onPressed: () => _showDatePicker(context),
                  style: ButtonStyle(
                      elevation: MaterialStateProperty.all(0),
                      backgroundColor: MaterialStateProperty.all(Colors.white)),
                  child: Text(
                    'Selecionar data',
                    style:
                        TextStyle(color: Theme.of(context).colorScheme.primary),
                  ),
                ),
              )
            ]),
          );
  }
}