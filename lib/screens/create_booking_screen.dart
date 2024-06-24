import 'package:flutter/material.dart';
import 'package:syncfusion_flutter_calendar/calendar.dart';

class CreateBookingScreen extends StatefulWidget {
  const CreateBookingScreen({super.key});

  @override
  State<CreateBookingScreen> createState() => _CreateBookingScreenState();
}

List<String> services = ["Hair Style","Nails","Waxing","Makeup"];
class _CreateBookingScreenState extends State<CreateBookingScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisAlignment: MainAxisAlignment.start,
        children: [
          SizedBox(
            height: 100,
          ),
          SizedBox(
            width: 350,
            height: 120,
            child: Center(
              child: SfCalendar(
                showDatePickerButton: true,
                scheduleViewSettings: ScheduleViewSettings(
                    monthHeaderSettings: MonthHeaderSettings(),
                    dayHeaderSettings: DayHeaderSettings()),
                showNavigationArrow: true,
                view: CalendarView.timelineDay,
                viewHeaderStyle: ViewHeaderStyle(
                  dayTextStyle: TextStyle(fontSize: 16),
                ),
                timeSlotViewSettings: TimeSlotViewSettings(dayFormat: "E"),
              ),
            ),
          ),
          Text("Service Type"),
        ],
      ),
    );
  }
}
