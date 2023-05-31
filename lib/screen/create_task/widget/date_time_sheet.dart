import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class DateTimeSheet extends StatefulWidget {
  const DateTimeSheet({Key? key, this.value, required this.onTimeAdded})
      : super(key: key);

  final DateTime? value;
  final Function(DateTime) onTimeAdded;

  @override
  State<DateTimeSheet> createState() => _DateTimeSheetState();
}

class _DateTimeSheetState extends State<DateTimeSheet> {
  DateTime pickedDateTime = DateTime.now();

  @override
  void initState() {
    super.initState();
    if (widget.value != null) {
      pickedDateTime = widget.value!;
    }
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Padding(
        padding: const EdgeInsets.symmetric(
          horizontal: 10,
        ),
        child: Column(
          children: [
            const Padding(
              padding: EdgeInsets.only(top: 20, bottom: 10),
              child: Text(
                'Set Time',
                style: TextStyle(
                  fontSize: 17,
                  fontWeight: FontWeight.w600,
                ),
              ),
            ),
            ListTile(
              onTap: () async {
                var value = await showDatePicker(
                  context: context,
                  initialEntryMode: DatePickerEntryMode.calendarOnly,
                  initialDate: pickedDateTime,
                  firstDate: DateTime.now(),
                  lastDate: DateTime(DateTime.now().year + 1, -1),
                );
                setState(() {
                  value ??= DateTime.now();
                  pickedDateTime = pickedDateTime.copyWith(
                      year: value!.year, month: value!.month, day: value!.day);
                });
              },
              leading: const Icon(Icons.sunny),
              title: const Text(
                'Date',
                style: TextStyle(color: Colors.black),
              ),
              trailing: Text(DateFormat('dd/MM/yyyy').format(pickedDateTime)),
              contentPadding: EdgeInsets.zero,
            ),
            ListTile(
              onTap: () async {
                var newTime = await showTimePicker(
                    context: context,
                    initialTime: TimeOfDay(
                      hour: pickedDateTime.hour,
                      minute: pickedDateTime.minute,
                    ));
                if (newTime != null) {
                  setState(() {
                    pickedDateTime = pickedDateTime.copyWith(
                        hour: newTime.hour, minute: newTime.minute);
                  });
                }
              },
              leading: const Icon(Icons.timer),
              title: const Text(
                'Time',
                style: TextStyle(color: Colors.black),
              ),
              trailing: Text('${pickedDateTime.hour}:${pickedDateTime.minute}'),
              contentPadding: EdgeInsets.zero,
            ),
            const Divider(
              thickness: 1,
              indent: 10,
              endIndent: 10,
            ),
            MaterialButton(
              onPressed: () {
                widget.onTimeAdded.call(pickedDateTime);
                Navigator.of(context).pop();
              },
              color: Theme.of(context).primaryColor,
              padding: const EdgeInsets.symmetric(vertical: 10),
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(10),
              ),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: const [
                  Icon(
                    Icons.timer_sharp,
                    color: Colors.white,
                    size: 18,
                  ),
                  SizedBox(
                    width: 10,
                  ),
                  Text(
                    'Schedule',
                    style: TextStyle(color: Colors.white),
                  )
                ],
              ),
            )
          ],
        ),
      ),
    );
  }
}
