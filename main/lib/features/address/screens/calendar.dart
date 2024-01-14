import 'package:flutter/material.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: RentalApp(),
    );
  }
}

class RentalApp extends StatefulWidget {
  @override
  _RentalAppState createState() => _RentalAppState();
}

class _RentalAppState extends State<RentalApp> {
  DateTime? _startDate;
  DateTime? _endDate;

  void _selectStartDate() async {
    final pickedDate = await showDatePicker(
      context: context,
      initialDate: DateTime.now(),
      firstDate: DateTime.now(),
      lastDate: DateTime(DateTime.now().year + 1), // 최대 1년 이후까지 선택 가능
    );

    if (pickedDate != null && pickedDate != _endDate) {
      setState(() {
        _startDate = pickedDate;
      });
    }
  }

  void _selectEndDate() async {
    final pickedDate = await showDatePicker(
      context: context,
      initialDate: _startDate ?? DateTime.now(),
      firstDate: _startDate ?? DateTime.now(),
      lastDate: DateTime(DateTime.now().year + 1), // 최대 1년 이후까지 선택 가능
    );

    if (pickedDate != null) {
      setState(() {
        _endDate = pickedDate;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('물건 대여 어플'),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Text(
              '시작 날짜: ${_startDate != null ? _startDate.toString() : '설정 안 됨'}',
              style: const TextStyle(fontSize: 20),
            ),
            const SizedBox(height: 20),
            Text(
              '종료 날짜: ${_endDate != null ? _endDate.toString() : '설정 안 됨'}',
              style: const TextStyle(fontSize: 20),
            ),
            const SizedBox(height: 20),
            ElevatedButton(
              onPressed: _selectStartDate,
              child: const Text('시작 날짜 선택'),
            ),
            const SizedBox(height: 20),
            ElevatedButton(
              onPressed: _selectEndDate,
              child: const Text('종료 날짜 선택'),
            ),
          ],
        ),
      ),
    );
  }
}
