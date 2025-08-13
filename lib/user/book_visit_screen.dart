import 'package:Eimi/utils/app_colors.dart';
import 'package:Eimi/utils/base_bloc/base_state.dart';
import 'package:Eimi/utils/common_screens/custom_container.dart';
import 'package:Eimi/utils/core/core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:intl/intl.dart';

import '../utils/base_bloc/base_bloc.dart';


/* ------------------------ UI Pieces ------------------------ */

class _DateSelector extends StatelessWidget {
  const _DateSelector({
    required this.days,
    required this.selected,
    required this.onSelected,
  });

  final List<DateTime> days;
  final DateTime selected;
  final ValueChanged<DateTime> onSelected;

  @override
  Widget build(BuildContext context) {
    return Container(
      height: deviceHeight(context) * 0.12,
      child: ListView.separated(
        scrollDirection: Axis.horizontal,
        itemCount: days.length,
        separatorBuilder: (_, __) => const SizedBox(width: 12),
        itemBuilder: (context, index) {
          final d = days[index];
          final isSelected = _sameDay(d, selected);
          return _DatePill(
            date: d,
            selected: isSelected,
            onTap: () => onSelected(d),
          );
        },
      ),
    );
  }

  bool _sameDay(DateTime a, DateTime b) =>
      a.year == b.year && a.month == b.month && a.day == b.day;
}

class _DatePill extends StatelessWidget {
  const _DatePill({
    required this.date,
    required this.selected,
    required this.onTap,
  });

  final DateTime date;
  final bool selected;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    final dayName = DateFormat('E').format(date); // Sat
    final dayNum = DateFormat('d').format(date);  // 26
    final month = DateFormat('MMM').format(date); // Aug

    final border = RoundedRectangleBorder(
      borderRadius: BorderRadius.circular(12),
      side: BorderSide(
        color: selected
            ? AppColors.primary
            : AppColors.black,
      ),
    );

    final bg = selected
        ? AppColors.green10
        : AppColors.white;


    return Material(
      color: bg,
      shape: border,
      child: InkWell(
        borderRadius: BorderRadius.circular(12),
        onTap: onTap,
        child: Container(
          width: 72,
          padding: const EdgeInsets.symmetric(vertical: 10, horizontal: 8),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              customThemeText(dayName, 14,fontWeight: FontWeight.w500),
               VerticalSpace(height: 4),
              customThemeText(dayNum,18,fontWeight: FontWeight.w700),
               VerticalSpace(height: 2),
              customThemeText(month,12,fontWeight: FontWeight.w500),
            ],
          ),
        ),
      ),
    );
  }
}

class _TimeGrid extends StatelessWidget {
  const _TimeGrid({
    required this.slots,
    required this.selected,
    required this.onTap,
  });

  final List<TimeSlot> slots;
  final TimeSlot? selected;
  final ValueChanged<TimeSlot> onTap;

  @override
  Widget build(BuildContext context) {
    // Responsive columns
    final width = MediaQuery.of(context).size.width;
    final crossAxisCount = width > 420 ? 4 : 3;

    return GridView.builder(
      itemCount: slots.length,
      shrinkWrap: true,
      physics: const NeverScrollableScrollPhysics(),
      gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: crossAxisCount,
        crossAxisSpacing: 12,
        mainAxisSpacing: 12,
        mainAxisExtent: 44,
      ),
      itemBuilder: (context, i) {
        final slot = slots[i];
        final isSelected = selected?.label == slot.label &&
            selected?.dateTime == slot.dateTime;

        return _TimeChip(
          label: slot.label,
          enabled: slot.available,
          selected: isSelected,
          onTap: () => onTap(slot),
        );
      },
    );
  }
}

class _TimeChip extends StatelessWidget {
  const _TimeChip({
    required this.label,
    required this.enabled,
    required this.selected,
    required this.onTap,
  });

  final String label;
  final bool enabled;
  final bool selected;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    final scheme = Theme.of(context).colorScheme;

    final borderColor = selected
        ? scheme.primary
        : (enabled ? scheme.outlineVariant : scheme.outlineVariant);

    final bgColor = !enabled
        ? scheme.surfaceVariant.withOpacity(0.6)
        : (selected ? scheme.primary.withOpacity(0.08) : Colors.white);

    final textColor = !enabled
        ? scheme.onSurface.withOpacity(0.4)
        : (selected ? scheme.primary : scheme.onSurface);

    return Opacity(
      opacity: enabled ? 1 : 0.9,
      child: Material(
        color: bgColor,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(12),
          side: BorderSide(color: borderColor),
        ),
        child: InkWell(
          onTap: enabled ? onTap : null,
          borderRadius: BorderRadius.circular(12),
          child: Center(
            child: Text(
              label,
              style: TextStyle(
                fontWeight: FontWeight.w600,
                color: textColor,
              ),
            ),
          ),
        ),
      ),
    );
  }
}

/* ------------------------ Models ------------------------ */

class TimeSlot {
  final String label;
  final DateTime dateTime;
  final bool available;

  TimeSlot({
    required this.label,
    required this.dateTime,
    required this.available,
  });
}





class BookVisitPage extends StatefulWidget {
  const BookVisitPage({super.key});

  @override
  State<BookVisitPage> createState() => _BookVisitPageState();
}

class _BookVisitPageState extends State<BookVisitPage> {
  final BaseBloc _bloc = BaseBloc();
  final ScrollController _scrollController = ScrollController();
  final int daysToShow = 5;
  late final List<DateTime> _days;
  DateTime? _selectedDay;

  late final Map<String, List<TimeSlot>> _slotsByDay;
  TimeSlot? _selectedSlot;
  _BookVisitPageState();

  @override
  void initState() {
    initPlatformState();

    super.initState();
    final now = DateTime.now();
    _days = List.generate(daysToShow, (i) {
      final d = DateTime(now.year, now.month, now.day).add(Duration(days: i));
      return d;
    });
    _selectedDay = _days.first;

    _slotsByDay = {
      for (final d in _days)
        _key(d): _mockSlotsForDay(d),
    };
  }

  @override
  void dispose() {
    _bloc.close();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: true,
      body: BlocProvider(
        create: (_) => _bloc,
        child: buildPage(),
      ),
    );
  }


  Widget buildPage() {
    return BlocListener<BaseBloc, BaseState>(listener: (context, state) async {
      if (state is BaseError) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
              duration: Duration(milliseconds: 2000),
              content: customThemeText(state.errorMessage,14,fontWeight: FontWeight.w600,color: Colors.white),
              backgroundColor: AppColors.primary),
        );
      } else if (state is DataLoaded) {
        //ADD YOUR FUNCTIONALITY
      }
    }, child: BlocBuilder<BaseBloc, BaseState>(
      bloc: _bloc,
      builder: (context, state) {
        return Center(
          child: CustomContainer(
              buildUI(state, context), state, onRefresh, statusBarColor: AppColors.transparent),
        );
      },
    ));
  }

  Widget buildUI(state, context) {
    final theme = Theme.of(context);
    final daySlots = _slotsByDay[_key(_selectedDay!)] ?? [];
    return Container(
      color: AppColors.white,
      child: SafeArea(
        top: true,
        child: Stack(
          children: <Widget>[
            Container(
              color: AppColors.white,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: <Widget>[
                  //APP BAR
                  Container(
                    padding: EdgeInsets.symmetric(horizontal: 16, vertical: 10),
                    child: InkWell(
                      onTap: (){
                        Navigator.pop(context);
                      },
                      child: Row(
                        children: [
                          Icon(Icons.arrow_back),
                          HorizontalSpace(),
                          customThemeText("Back", 18,fontWeight: FontWeight.w700,color: AppColors.black),

                        ],
                      ),
                    ),
                  ),
                  //BODY
                  Expanded(
                    child: Container(
                      color: AppColors.white,
                      child: SingleChildScrollView(
                        controller: _scrollController,
                        physics: AlwaysScrollableScrollPhysics(),
                        child: Container(
                          margin:
                          const EdgeInsets.symmetric(horizontal: 16, vertical: 10),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.stretch,
                            children: <Widget>[
                              VerticalSpace(height:10,),
                              Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children:  [
                                  //BODY WIDGETS
                                  customThemeText('Select Date Of Visit', 16,fontWeight: FontWeight.w700),
                                   
                                  VerticalSpace(height: 12),
                                  _DateSelector(
                                    days: _days,
                                    selected: _selectedDay!,
                                    onSelected: (d) {
                                      setState(() {
                                        _selectedDay = d;
                                        _selectedSlot = null;
                                      });
                                    },
                                  ),
                                   VerticalSpace(height: 24),
                                  customThemeText('Select Time Slot',16,fontWeight: FontWeight.w700),
                                   VerticalSpace(height: 12),
                                  _TimeGrid(
                                    slots: daySlots,
                                    selected: _selectedSlot,
                                    onTap: (slot) {
                                      if (!slot.available) return;
                                      setState(() => _selectedSlot = slot);
                                    },
                                  ),
                                ],
                              ),

                            ],
                          ),
                        ),
                      ),
                    ),
                  ),
                  //BOTTOM WIDGETS
                  buttonWidget(),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }


  //UI WIDGETS   -> We have to use custom components whatever we have in project.

  List<TimeSlot> _mockSlotsForDay(DateTime day) {
    final base = DateTime(day.year, day.month, day.day);
    final raw = <String, bool>{
      '10:00 AM': true,
      '11:00 AM': true,
      '12:00 PM': false,
      '2:00 PM': false,
      '3:00 PM': true,
      '4:00 PM': false,
      '5:00 PM': true,
      '7:00 PM': true,
      '8:00 PM': true,
    };

    return raw.entries.map((e) {
      final time = e.key;
      final dt = _parseLabelToDateTime(base, time);
      return TimeSlot(label: time, dateTime: dt, available: e.value);
    }).toList();
  }

  static String _key(DateTime d) => DateFormat('yyyy-MM-dd').format(d);

  DateTime _parseLabelToDateTime(DateTime day, String label) {
    final parsed = DateFormat('h:mm a').parse(label);
    return DateTime(
      day.year,
      day.month,
      day.day,
      parsed.hour,
      parsed.minute,
    );
  }
  void _onConfirm() {
    _showSnackBar( 'Booked ${DateFormat('EEE, dd MMM').format(_selectedDay!)} at ${_selectedSlot!.label}');
  }

  Widget buttonWidget(){
    return Container(
        margin: EdgeInsets.symmetric(horizontal: 16,vertical: 10),
        padding: EdgeInsets.symmetric(horizontal: 16,vertical: 10),
        width: double.infinity,
        // height: 50,
        decoration: BoxDecoration(
            color: AppColors.primary,
            borderRadius: BorderRadius.circular(16)),
        child: customThemeText(
            "Confirm Visit",16,
            fontWeight: FontWeight.w600,
            color: Colors.white,
            textAlign: TextAlign.center
        )
    ).onTap((){
      if(_selectedSlot != null ){
        _onConfirm();
      }
      // Navigator.push(
      //   context,
      //   MaterialPageRoute(builder: (_) =>  ProductUploadSuccessScreen()),
      // );
    });
  }


  //FUNCTIONALITY
  void _showToastBar(String message) {
    Fluttertoast.showToast(
        msg: message,
        toastLength: Toast.LENGTH_LONG,
        gravity: ToastGravity.CENTER,
        timeInSecForIosWeb: 6,
        backgroundColor : AppColors.primary,
        textColor: Colors.white,
        fontSize: 16.0
    );
  }

  void _showSnackBar(String message) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: customThemeText(
            message,
            14,
            textAlign: TextAlign.center,fontWeight: FontWeight.w600,color: Colors.white
        ),
        backgroundColor: AppColors.primary,
        // behavior: SnackBarBehavior.floating,
        // elevation: 1.0,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(0.0),
        ),
      ),
    );
  }



  Future<void> onRefresh()async {
    bool data = false;
    // WRITE YOUR REFRESH LOGIC
  }

  //API CALLS
  Future<void> initPlatformState() async {
    if (!mounted) return;
  }


}
