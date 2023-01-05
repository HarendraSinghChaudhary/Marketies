// ignore_for_file: prefer_const_constructors, unused_field

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:marketies/components/p_default_button.dart';
import 'package:marketies/screens/onboarding/p_login.dart';
import 'package:marketies/utils/constant.dart';
import 'package:marketies/utils/widget.dart';
import 'package:table_calendar/table_calendar.dart';
import 'package:intl/intl.dart';

class Pkyc extends StatefulWidget {
  @override
  State<Pkyc> createState() => _PkycState();
}

class _PkycState extends State<Pkyc> {
  final CalendarFormat _calendarFormat = CalendarFormat.month;

  DateTime _focusedDay = DateTime.now();

  DateTime? _selectedDay;

  RxString dateNow = "Date of Birth".obs;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: Padding(
          padding: EdgeInsets.symmetric(horizontal: w * 0.04),
          child: Column(
            children: [
              space(h * 0.1),
              Text(
                "Complete Your KYC!",
                style: GoogleFonts.cabin(
                    color: pWhiteColor,
                    fontSize: w * 0.055,
                    fontWeight: FontWeight.w700),
              ),
              space(h * 0.015),
              Center(
                child: Text(
                  "Please complete kyc to withdraw your payout",
                  style: GoogleFonts.cabin(
                      foreground: Paint()..shader = linearGradient,
                      fontSize: w * 0.04,
                      fontWeight: FontWeight.w600),
                ),
              ),
              space(h * 0.02),
              nameFormField(),
              space(h * 0.02),
              GenderDrop(),
              space(h * 0.02),
              cityFormField(),
              space(h * 0.02),
              pincodeFormField(),
              space(h * 0.02),
              panNumbnerFormField(),
              space(h * 0.02),
              OccupationDrop(),
              space(h * 0.02),
              AnnualIncomeDrop(),
              space(h * 0.02),
              InkWell(
                onTap: () {
                  calendarModelBottomSheet();
                },
                child: Container(
                  height: h * 0.07,
                  width: double.infinity,
                  decoration: BoxDecoration(
                    color: pPrimaryColor,
                    borderRadius: BorderRadius.circular(10),
                  ),
                  child: Row(
                    children: [
                      SizedBox(
                        width: w * 0.03,
                      ),
                      Icon(
                        Icons.cake,
                        color: pWhiteColor,
                      ),
                      SizedBox(
                        width: w * 0.03,
                      ),
                      Text(
                        _selectedDay.toString() == "null"
                            ? "Date of Birth"
                            : _selectedDay.toString().substring(0, 11),
                        style: GoogleFonts.cabin(
                            color: pWhiteColor,
                            fontSize: w * 0.043,
                            fontWeight: FontWeight.w300),
                      ),
                    ],
                  ),
                ),
              ),
              space(h * 0.02),
              PDefaultButton(
                  width: double.infinity,
                  height: h * 0.08,
                  text: "Submit",
                  press: () {
                    Get.to(() => Pkyc());
                  }),
            ],
          ),
        ),
      ),
    );
  }

  calendarModelBottomSheet() {
    WidgetsBinding.instance.addPostFrameCallback((_) async {
      await showModalBottomSheet(
          backgroundColor: Colors.transparent,
          context: context,
          builder: (builder) {
            return StatefulBuilder(builder: (context, setState) {
              return Container(
                decoration: BoxDecoration(
                    color: Colors.transparent,
                    borderRadius: BorderRadius.only(
                        topLeft: const Radius.circular(10.0),
                        topRight: const Radius.circular(10.0))),
                //could change this to Color(0xFF737373),
                //so you don't have to change MaterialApp canvasColor
                child: Card(
                  child: TableCalendar(
                    daysOfWeekHeight: 40,

                    // startingDayOfWeek: StartingDayOfWeek.monday,
                    daysOfWeekStyle: DaysOfWeekStyle(
                      dowTextFormatter: (date, locale) {
                        return DateFormat.E().format(date).substring(0, 1);
                      },
                      weekdayStyle: const TextStyle(color: kPrimaryColor),
                      weekendStyle: const TextStyle(color: kPrimaryColor),
                      decoration: BoxDecoration(
                        color: const Color(0xffF4F6F8),
                        borderRadius: BorderRadius.circular(5),
                      ),
                    ),
                    calendarStyle: CalendarStyle(
                        todayDecoration: BoxDecoration(
                            shape: BoxShape.circle,
                            color: kPrimaryColor.withOpacity(0.5)),
                        selectedDecoration: const BoxDecoration(
                          shape: BoxShape.circle,
                          color: kPrimaryColor,
                        )),
                    firstDay: DateTime(2015),
                    headerStyle: const HeaderStyle(
                        headerPadding: EdgeInsets.zero,
                        titleCentered: true,
                        headerMargin: EdgeInsets.only(left: 0, bottom: 0),
                        titleTextStyle: TextStyle(
                          fontSize: 18,
                          color: Color(0xff333333),
                        ),
                        formatButtonVisible: false,
                        rightChevronIcon: Padding(
                          padding: EdgeInsets.all(5.0),
                          child: Icon(
                            Icons.arrow_right,
                            size: 30,
                            color: kPrimaryColor,
                          ),
                        ),
                        leftChevronIcon: Padding(
                          padding: EdgeInsets.all(5.0),
                          child: Icon(
                            Icons.arrow_left,
                            size: 30,
                            color: kPrimaryColor,
                          ),
                        )),
                    lastDay: DateTime(2030),
                    focusedDay: _focusedDay,
                    calendarFormat: _calendarFormat,
                    selectedDayPredicate: (day) {
                      return isSameDay(_selectedDay, day);
                    },
                    onDaySelected: (selectedDay, focusedDay) {
                      if (!isSameDay(_selectedDay, selectedDay)) {
                        setState(() {
                          _selectedDay = selectedDay;
                          _focusedDay = focusedDay;
                        });
                      }

                      Get.back();
                    },
                    onPageChanged: (focusedDay) {
                      _focusedDay = focusedDay;
                      setState(() {});
                    },
                  ),
                ),
              );
            });
          });
    });
  }

  // full name textfield
  TextFormField nameFormField() {
    return TextFormField(
      validator: (val) {
        if (val == null || val.isEmpty) {
          return 'Email address or UniqueId is required';
        }
        // if (!GetUtils.isEmail(val)) {
        //   return 'Email address ';
        // }
        return null;
      },
      // autovalidateMode:
      //     AutovalidateMode.onUserInteraction,
      // controller: emailController,

      style: TextStyle(
          color: pWhiteColor, fontSize: 16, fontWeight: FontWeight.w400),
      keyboardType: TextInputType.emailAddress,
      cursorColor: pWhiteColor,
      decoration: InputDecoration(
        fillColor: pPrimaryColor,
        // fillColor: Colors.black,
        filled: true,
        contentPadding: EdgeInsets.symmetric(vertical: 20, horizontal: 16),
        counterText: '',
        hintText: "Full Name (As Per PAN) ",
        hintStyle: TextStyle(
            color: pWhiteColor, fontSize: 16, fontWeight: FontWeight.w400),
        border: OutlineInputBorder(
          borderSide: BorderSide(
            color: pPrimaryColor,
            width: 1.0,
          ),
        ),
        focusedErrorBorder: OutlineInputBorder(
            borderSide: BorderSide(color: Colors.red, width: 1.0)),
        focusedBorder: OutlineInputBorder(
            borderSide: BorderSide(color: pWhiteColor),
            borderRadius: BorderRadius.all(Radius.circular(10))),
        enabledBorder: OutlineInputBorder(
            borderSide: BorderSide(
              color: pPrimaryColor,
            ),
            borderRadius: BorderRadius.all(Radius.circular(10))),
        disabledBorder: OutlineInputBorder(
            borderSide: BorderSide(color: pWhiteColor, width: 1.0)),
        errorBorder: OutlineInputBorder(
            borderSide: BorderSide(color: Colors.red, width: 1.0)),

        prefixIconConstraints: BoxConstraints(minWidth: 4),

        prefixIcon: Padding(
          padding: EdgeInsets.all(12),
          child: Icon(
            Icons.person_rounded,
            color: pWhiteColor,
          ),
        ),
      ),
    );
  }

// city textfield
  TextFormField cityFormField() {
    return TextFormField(
      validator: (val) {
        if (val == null || val.isEmpty) {
          return 'Email address or UniqueId is required';
        }
        // if (!GetUtils.isEmail(val)) {
        //   return 'Email address ';
        // }
        return null;
      },
      // autovalidateMode:
      //     AutovalidateMode.onUserInteraction,
      // controller: emailController,

      style: TextStyle(
          color: pWhiteColor, fontSize: 16, fontWeight: FontWeight.w400),
      keyboardType: TextInputType.emailAddress,
      cursorColor: pWhiteColor,
      decoration: InputDecoration(
        fillColor: pPrimaryColor,
        // fillColor: Colors.black,
        filled: true,
        contentPadding: EdgeInsets.symmetric(vertical: 20, horizontal: 16),
        counterText: '',
        hintText: "City",
        hintStyle: TextStyle(
            color: pWhiteColor, fontSize: 16, fontWeight: FontWeight.w400),
        border: OutlineInputBorder(
          borderSide: BorderSide(
            color: pPrimaryColor,
            width: 1.0,
          ),
        ),
        focusedErrorBorder: OutlineInputBorder(
            borderSide: BorderSide(color: Colors.red, width: 1.0)),
        focusedBorder: OutlineInputBorder(
            borderSide: BorderSide(color: pWhiteColor),
            borderRadius: BorderRadius.all(Radius.circular(10))),
        enabledBorder: OutlineInputBorder(
            borderSide: BorderSide(
              color: pPrimaryColor,
            ),
            borderRadius: BorderRadius.all(Radius.circular(10))),
        disabledBorder: OutlineInputBorder(
            borderSide: BorderSide(color: pWhiteColor, width: 1.0)),
        errorBorder: OutlineInputBorder(
            borderSide: BorderSide(color: Colors.red, width: 1.0)),

        prefixIconConstraints: BoxConstraints(minWidth: 4),

        prefixIcon: Padding(
          padding: EdgeInsets.all(12),
          child: Icon(
            Icons.location_city,
            color: pWhiteColor,
          ),
        ),
      ),
    );
  }

  // pincode textfiled
  TextFormField pincodeFormField() {
    return TextFormField(
      validator: (val) {
        if (val == null || val.isEmpty) {
          return 'Email address or UniqueId is required';
        }
        // if (!GetUtils.isEmail(val)) {
        //   return 'Email address ';
        // }
        return null;
      },
      // autovalidateMode:
      //     AutovalidateMode.onUserInteraction,
      // controller: emailController,

      style: TextStyle(
          color: pWhiteColor, fontSize: 16, fontWeight: FontWeight.w400),
      keyboardType: TextInputType.emailAddress,
      cursorColor: pWhiteColor,
      decoration: InputDecoration(
        fillColor: pPrimaryColor,
        // fillColor: Colors.black,
        filled: true,
        contentPadding: EdgeInsets.symmetric(vertical: 20, horizontal: 16),
        counterText: '',
        hintText: "Pincode",
        hintStyle: TextStyle(
            color: pWhiteColor, fontSize: 16, fontWeight: FontWeight.w400),
        border: OutlineInputBorder(
          borderSide: BorderSide(
            color: pPrimaryColor,
            width: 1.0,
          ),
        ),
        focusedErrorBorder: OutlineInputBorder(
            borderSide: BorderSide(color: Colors.red, width: 1.0)),
        focusedBorder: OutlineInputBorder(
            borderSide: BorderSide(color: pWhiteColor),
            borderRadius: BorderRadius.all(Radius.circular(10))),
        enabledBorder: OutlineInputBorder(
            borderSide: BorderSide(
              color: pPrimaryColor,
            ),
            borderRadius: BorderRadius.all(Radius.circular(10))),
        disabledBorder: OutlineInputBorder(
            borderSide: BorderSide(color: pWhiteColor, width: 1.0)),
        errorBorder: OutlineInputBorder(
            borderSide: BorderSide(color: Colors.red, width: 1.0)),

        prefixIconConstraints: BoxConstraints(minWidth: 4),

        prefixIcon: Padding(
          padding: EdgeInsets.all(12),
          child: Icon(
            Icons.location_city,
            color: pWhiteColor,
          ),
        ),
      ),
    );
  }

  // . pan number textfield
  TextFormField panNumbnerFormField() {
    return TextFormField(
      validator: (val) {
        if (val == null || val.isEmpty) {
          return 'Email address or UniqueId is required';
        }
        // if (!GetUtils.isEmail(val)) {
        //   return 'Email address ';
        // }
        return null;
      },
      // autovalidateMode:
      //     AutovalidateMode.onUserInteraction,
      // controller: emailController,

      style: TextStyle(
          color: pWhiteColor, fontSize: 16, fontWeight: FontWeight.w400),
      keyboardType: TextInputType.emailAddress,
      cursorColor: pWhiteColor,
      decoration: InputDecoration(
        fillColor: pPrimaryColor,
        // fillColor: Colors.black,
        filled: true,
        contentPadding: EdgeInsets.symmetric(vertical: 20, horizontal: 16),
        counterText: '',
        hintText: "Pan Number",
        hintStyle: TextStyle(
            color: pWhiteColor, fontSize: 16, fontWeight: FontWeight.w400),
        border: OutlineInputBorder(
          borderSide: BorderSide(
            color: pPrimaryColor,
            width: 1.0,
          ),
        ),
        focusedErrorBorder: OutlineInputBorder(
            borderSide: BorderSide(color: Colors.red, width: 1.0)),
        focusedBorder: OutlineInputBorder(
            borderSide: BorderSide(color: pWhiteColor),
            borderRadius: BorderRadius.all(Radius.circular(10))),
        enabledBorder: OutlineInputBorder(
            borderSide: BorderSide(
              color: pPrimaryColor,
            ),
            borderRadius: BorderRadius.all(Radius.circular(10))),
        disabledBorder: OutlineInputBorder(
            borderSide: BorderSide(color: pWhiteColor, width: 1.0)),
        errorBorder: OutlineInputBorder(
            borderSide: BorderSide(color: Colors.red, width: 1.0)),

        prefixIconConstraints: BoxConstraints(minWidth: 4),

        prefixIcon: Padding(
          padding: EdgeInsets.all(12),
          child: Icon(
            Icons.person_rounded,
            color: pWhiteColor,
          ),
        ),
      ),
    );
  }
}

class GenderDrop extends StatelessWidget {
  RxString dropdownValue = "Select Gender".obs;

  RxList<String> dropdownList =
      <String>["Select Gender", "Male", "Female", "Others"].obs;

  @override
  Widget build(BuildContext context) {
    return Container(
      height: h * 0.07,
      width: double.infinity,
      decoration: BoxDecoration(
        color: pPrimaryColor,
        borderRadius: BorderRadius.circular(10),
      ),
      child: Row(
        children: [
          SizedBox(
            width: w * 0.03,
          ),
          Icon(
            Icons.male,
            color: pWhiteColor,
            size: 30,
          ),
          SizedBox(
            width: w * 0.03,
          ),
          Obx(() => DropdownButtonHideUnderline(
                child: DropdownButton<String>(
                  dropdownColor: pPrimaryColor,
                  elevation: 0,
                  iconDisabledColor: pWhiteColor,
                  iconEnabledColor: pWhiteColor,

                  // Initial Value
                  value: dropdownValue.value,

                  // Down Arrow Icon
                  icon: const Icon(Icons.keyboard_arrow_down),

                  // Array list of items
                  items: dropdownList.map((String items) {
                    return DropdownMenuItem(
                      value: items,
                      child: Text(
                        items,
                        style: const TextStyle(color: pWhiteColor),
                      ),
                    );
                  }).toList(),
                  // After selecting the desired option,it will
                  // change button value to selected value
                  onChanged: (String? newValue) {
                    dropdownValue.value = newValue!;
                  },
                ),
              )),
        ],
      ),
    );
  }
}

class OccupationDrop extends StatelessWidget {
  RxString dropdownValue = "Occupation".obs;

  RxList<String> dropdownList = <String>[
    "Occupation",
    "Financial Advisor",
    "Student",
    "Sales Agent",
    "Govt Employee",
    "Youtuber Or Influencer",
    "Business Owner",
    "Housewife",
    "Bank Employee",
    "Farmer",
    "Private Job",
    "Not Working",
    "Others"
  ].obs;

  @override
  Widget build(BuildContext context) {
    return Container(
      height: h * 0.07,
      width: double.infinity,
      decoration: BoxDecoration(
        color: pPrimaryColor,
        borderRadius: BorderRadius.circular(10),
      ),
      child: Row(
        children: [
          SizedBox(
            width: w * 0.03,
          ),
          Icon(
            Icons.male,
            color: pWhiteColor,
            size: 30,
          ),
          SizedBox(
            width: w * 0.03,
          ),
          Obx(() => DropdownButtonHideUnderline(
                child: DropdownButton<String>(
                  dropdownColor: pPrimaryColor,
                  elevation: 0,
                  iconDisabledColor: pWhiteColor,
                  iconEnabledColor: pWhiteColor,

                  // Initial Value
                  value: dropdownValue.value,

                  // Down Arrow Icon
                  icon: const Icon(Icons.keyboard_arrow_down),

                  // Array list of items
                  items: dropdownList.map((String items) {
                    return DropdownMenuItem(
                      value: items,
                      child: Text(
                        items,
                        style: const TextStyle(color: pWhiteColor),
                      ),
                    );
                  }).toList(),
                  // After selecting the desired option,it will
                  // change button value to selected value
                  onChanged: (String? newValue) {
                    dropdownValue.value = newValue!;
                  },
                ),
              )),
        ],
      ),
    );
  }
}

class AnnualIncomeDrop extends StatelessWidget {
  RxString dropdownValue = "Annual Income".obs;

  RxList<String> dropdownList = <String>[
    "Annual Income",
    "₹0-1 Lakh",
    "₹1-2.5 Lakh",
    "₹2.5-5 Lakh",
    "₹5+ Lakhs",
  ].obs;

  @override
  Widget build(BuildContext context) {
    return Container(
      height: h * 0.07,
      width: double.infinity,
      decoration: BoxDecoration(
        color: pPrimaryColor,
        borderRadius: BorderRadius.circular(10),
      ),
      child: Row(
        children: [
          SizedBox(
            width: w * 0.03,
          ),
          Icon(
            Icons.payment,
            color: pWhiteColor,
            size: 30,
          ),
          SizedBox(
            width: w * 0.03,
          ),
          Obx(() => DropdownButtonHideUnderline(
                child: DropdownButton<String>(
                  dropdownColor: pPrimaryColor,
                  elevation: 0,
                  iconDisabledColor: pWhiteColor,
                  iconEnabledColor: pWhiteColor,

                  // Initial Value
                  value: dropdownValue.value,

                  // Down Arrow Icon
                  icon: const Icon(Icons.keyboard_arrow_down),

                  // Array list of items
                  items: dropdownList.map((String items) {
                    return DropdownMenuItem(
                      value: items,
                      child: Text(
                        items,
                        style: const TextStyle(color: pWhiteColor),
                      ),
                    );
                  }).toList(),
                  // After selecting the desired option,it will
                  // change button value to selected value
                  onChanged: (String? newValue) {
                    dropdownValue.value = newValue!;
                  },
                ),
              )),
        ],
      ),
    );
  }

  // calander bottomsheet

}
