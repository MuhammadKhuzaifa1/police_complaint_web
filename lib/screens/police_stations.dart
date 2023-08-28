import 'package:dropdown_button2/dropdown_button2.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:police_complaint_web/components/app_buttons.dart';
import '../components/app_textfield.dart';
import '../constants/app_colors.dart';
import '../constants/district_list.dart';

class PoliceStations extends StatefulWidget {
  const PoliceStations({Key? key}) : super(key: key);

  @override
  State<PoliceStations> createState() => _PoliceStationsState();
}

class _PoliceStationsState extends State<PoliceStations> {

  final _formkey = GlobalKey<FormState>();
  final stationNameController = TextEditingController();
  final stationAddressController = TextEditingController();
  final stationNameFocusNode = FocusNode();
  final stationAddressFocusNode = FocusNode();
  String? selectedDistricts;

  @override
  void dispose() {
    stationNameController.dispose();
    stationAddressController.dispose();
    stationNameFocusNode.dispose();
    stationAddressFocusNode.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.all(15),
        child: Container(
          padding: const EdgeInsets.all(15),
          decoration: const BoxDecoration(
            boxShadow: [
              BoxShadow(
                color: Colors.black26,
                blurRadius: 20,
                offset: Offset(1,2),
                spreadRadius: 2,
              )
            ],
            color: Colors.white,
          ),
          child: Row(
            children: [
              Expanded(
                child: ListView.builder(
                  itemBuilder: (context, index) {
                    return Container(
                      height: 130,
                      margin: const EdgeInsets.only(bottom: 5),
                      color: Colors.grey.withOpacity(0.3),
                      padding: const EdgeInsets.all(10),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Row(
                            children: [
                              Container(
                                width: 130,
                                height: double.infinity,
                                color: Colors.brown,
                                child: Center(
                                  child: Text("1",style: TextStyle(fontSize: 16,color: AppColors.whiteColor),),
                                ),
                              ),
                              const SizedBox(width: 20),
                              Column(
                                children: [
                                  Text("data",style: TextStyle(fontSize: 20,color: AppColors.greenColor),),
                                  Text("data",style: TextStyle(fontSize: 20,color: AppColors.greenColor),),
                                ],
                              )
                            ],
                          ),
                          CupertinoButton(
                            onPressed: () { },
                            padding: EdgeInsets.zero,
                            child: Container(
                              width: 80,
                              height: 30,
                              decoration: BoxDecoration(
                                color: Colors.red,
                                borderRadius: BorderRadius.circular(3),
                              ),
                              child: const Center(child: Text("Delete",style: TextStyle(color: AppColors.whiteColor),)),
                            ),
                          ),
                        ],
                      ),
                    );
                  },
                ),
              ),
              SizedBox(width: 10),
              Container(
                padding: const EdgeInsets.all(20),
                width: 400,
                height: double.infinity,
                decoration: const BoxDecoration(
                  boxShadow: [
                    BoxShadow(
                      color: Colors.black26,
                      blurRadius: 20,
                      offset: Offset(1,2),
                      spreadRadius: 2,
                    )
                  ],
                  color: Colors.white,
                ),
                child: Form(
                  key: _formkey,
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                     Column(
                       children: [
                         Container(
                           width: double.infinity,
                           height: 250,
                           color: Colors.red,
                         ),
                         const SizedBox(height: 10),
                         InputTextField(
                           myController: stationNameController,
                           focusNode: stationNameFocusNode,
                           prefixIcon: Icons.drive_file_rename_outline,
                           keyboardType: TextInputType.text,
                           obsureText: false,
                           hint: "Enter Police Station Name",
                           onFieldSubmittedValue: (value) {},
                           onValidator: (value) {
                             if (value.toString().isNotEmpty) {
                               return null;
                             } else {
                               return "Enter Station name";
                             }
                           },
                         ),
                         InputTextField(
                           myController: stationAddressController,
                           focusNode: stationAddressFocusNode,
                           prefixIcon: Icons.location_on,
                           keyboardType: TextInputType.text,
                           obsureText: false,
                           hint: "Enter Police Station Address",
                           onFieldSubmittedValue: (value) {},
                           onValidator: (value) {
                             if (value.toString().isNotEmpty) {
                               return null;
                             } else {
                               return "Enter Station address";
                             }
                           },
                         ),
                         DropdownButtonHideUnderline(
                           child: DropdownButton2<String>(
                             isExpanded: true,
                             hint:  Row(
                               children: [
                                 const Icon(
                                   Icons.list,
                                   size: 20,
                                   color: AppColors.greenColor,
                                 ),
                                 const SizedBox(
                                   width: 4,
                                 ),
                                 Expanded(
                                   child: Text(
                                     'Select Station Districts',
                                     style: Theme.of(context)
                                         .textTheme
                                         .bodyText2!
                                         .copyWith(height: 0, color: AppColors.greenColor),
                                     overflow: TextOverflow.ellipsis,
                                   ),
                                 ),
                               ],
                             ),
                             items: Districts().district_list.map((String item) => DropdownMenuItem<String>(
                               value: item,
                               child: Text(item,
                                 style: const TextStyle(
                                   fontSize: 14,
                                   fontWeight: FontWeight.bold,
                                   color: Colors.white,
                                 ),
                                 overflow: TextOverflow.ellipsis,
                               ),
                             )).toList(),
                             value: selectedDistricts,
                             onChanged: (String? value) {
                               setState(() {
                                 selectedDistricts = value;
                               });
                             },
                             buttonStyleData: ButtonStyleData(
                               height: 55,
                               width: double.infinity,
                               padding: const EdgeInsets.only(left: 14, right: 14),
                               decoration: BoxDecoration(
                                 borderRadius: BorderRadius.circular(10),
                                 border: Border.all(color: AppColors.greenColor),
                                 color: Colors.grey.withOpacity(0.4),
                               ),
                               elevation: 0,
                             ),
                             iconStyleData: const IconStyleData(
                               icon: Icon(
                                 Icons.arrow_forward_ios_outlined,
                               ),
                               iconSize: 14,
                               iconEnabledColor: AppColors.greenColor,
                               iconDisabledColor: AppColors.greenColor,
                             ),
                             dropdownStyleData: DropdownStyleData(
                               maxHeight: 200,
                               width: 200,
                               decoration: BoxDecoration(
                                 borderRadius: BorderRadius.circular(14),
                                 border: Border.all(color: AppColors.greenColor),
                                 color: AppColors.greenColor,
                               ),
                               offset: const Offset(-20, 0),
                               scrollbarTheme: ScrollbarThemeData(
                                 radius: const Radius.circular(40),
                                 thickness: MaterialStateProperty.all<double>(6),
                                 thumbVisibility: MaterialStateProperty.all<bool>(true),
                               ),
                             ),
                             menuItemStyleData: const MenuItemStyleData(
                               height: 40,
                               padding: EdgeInsets.only(left: 14, right: 14),
                             ),
                           ),
                         ),
                         const SizedBox(height: 10),
                       ],
                     ),
                      AppButtons().normalButton(
                        text: "Add Station",
                        loading: false,
                        onPressed: () {},
                      )
                    ],
                  ),
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
