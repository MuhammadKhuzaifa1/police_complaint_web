import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:police_complaint_web/constants/app_colors.dart';
import 'package:police_complaint_web/constants/app_text_style.dart';
import 'package:police_complaint_web/utilites/utils.dart';

class ViewComplaint extends StatefulWidget {
  String? name, fatherName, email, cnic, mobileNo, gender, date,
      district, address, placeOfIncident, alreadyVisit, complaintType, id;
  ViewComplaint({
    this.name,
    this.fatherName,
    this.email,
    this.cnic,
    this.mobileNo,
    this.gender,
    this.district,
    this.address,
    this.placeOfIncident,
    this.alreadyVisit,
    this.complaintType,
    this.date,
    this.id,
    Key? key}) : super(key: key);

  @override
  State<ViewComplaint> createState() => _ViewComplaintState();
}

class _ViewComplaintState extends State<ViewComplaint> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.all(15),
        child: Column(
          children: [
            const SizedBox(height: 20),
            Row(
              children: [
                InkWell(
                  onTap: () { Get.back(); },
                  child: const CircleAvatar(
                    radius: 15,
                    backgroundColor: AppColors.greenColor,
                    child: Center(
                      child: Icon(Icons.arrow_back,color: AppColors.whiteColor),
                    ),
                  ),
                ),
                const SizedBox(width: 20),
                Text(widget.name.toString(), style: AppTextStyle.normalTextStyle()),
              ],
            ),
            const SizedBox(height: 10),
            Expanded(
              child: Container(
                padding: const EdgeInsets.all(20),
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
                child: SingleChildScrollView(
                  child: Column(
                    children: [
                      Center(
                        child: Text("Complainant Details",style: AppTextStyle.normalTextStyle(),),
                      ),
                      const SizedBox(height: 10),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text("Name",style: AppTextStyle.normalTextStyle(),),
                          Text(widget.name.toString(),style: AppTextStyle.normalTextStyle(),),
                        ],
                      ),
                      const SizedBox(height: 5),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text("Father Name",style: AppTextStyle.normalTextStyle(),),
                          Text(widget.fatherName.toString(),style: AppTextStyle.normalTextStyle(),),
                        ],
                      ),
                      const SizedBox(height: 5),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text("Email",style: AppTextStyle.normalTextStyle(),),
                          Text(widget.email.toString(),style: AppTextStyle.normalTextStyle(),),
                        ],
                      ),
                      const SizedBox(height: 5),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text("CNlC No",style: AppTextStyle.normalTextStyle(),),
                          Text(widget.cnic.toString(),style: AppTextStyle.normalTextStyle(),),
                        ],
                      ),
                      const SizedBox(height: 5),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text("Mobile Number",style: AppTextStyle.normalTextStyle(),),
                          Text(widget.mobileNo.toString(),style: AppTextStyle.normalTextStyle(),),
                        ],
                      ),
                      const SizedBox(height: 5),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text("Gender",style: AppTextStyle.normalTextStyle(),),
                          Text(widget.gender.toString(),style: AppTextStyle.normalTextStyle(),),
                        ],
                      ),
                      const SizedBox(height: 5),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text("Home District",style: AppTextStyle.normalTextStyle(),),
                          Text(widget.district.toString(),style: AppTextStyle.normalTextStyle(),),
                        ],
                      ),
                      const SizedBox(height: 5),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text("Address",style: AppTextStyle.normalTextStyle(),),
                          Text(widget.address.toString(),style: AppTextStyle.normalTextStyle(),),
                        ],
                      ),
                      const SizedBox(height: 10),
                      const Divider(color: AppColors.greenColor),
                      const SizedBox(height: 10),
                      Center(
                        child: Text("Information Report",style: AppTextStyle.normalTextStyle(),),
                      ),
                      const SizedBox(height: 10),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text("Date/ Time of Incident",style: AppTextStyle.normalTextStyle(),),
                          Text(widget.date.toString(),style: AppTextStyle.normalTextStyle(),),
                        ],
                      ),
                      const SizedBox(height: 5),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text("Place of Incident",style: AppTextStyle.normalTextStyle(),),
                          Text(widget.placeOfIncident.toString(),style: AppTextStyle.normalTextStyle(),),
                        ],
                      ),
                      const SizedBox(height: 5),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text("District of Incident",style: AppTextStyle.normalTextStyle(),),
                          Text(widget.district.toString(),style: AppTextStyle.normalTextStyle(),),
                        ],
                      ),
                      const SizedBox(height: 5),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text("Already Visited Police Station",style: AppTextStyle.normalTextStyle(),),
                          Text(widget.alreadyVisit.toString(),style: AppTextStyle.normalTextStyle(),),
                        ],
                      ),
                      const SizedBox(height: 5),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text("Complaint Type",style: AppTextStyle.normalTextStyle(),),
                          Text(widget.complaintType.toString(),style: AppTextStyle.normalTextStyle(),),
                        ],
                      ),
                      const SizedBox(height: 5),
                    ],
                  ),
                ),
              ),
            ),
            const SizedBox(height: 10),
            Row(
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                CupertinoButton(
                  onPressed: () {
                    Utils().alertDialog(
                      context: context,
                      text: "Are you sure to accept this complaint",
                      onPressed: () {
                        FirebaseFirestore.instance.collection('complaints').doc(widget.id.toString()).update({
                          'status' : 'accept',
                        });
                      },
                    );
                  },
                  padding: EdgeInsets.zero,
                  child: Container(
                    width: 100,
                    height: 30,
                    decoration: BoxDecoration(
                      color: AppColors.greenColor,
                      borderRadius: BorderRadius.circular(3),
                    ),
                    child: const Center(child: Text("Processing",style: TextStyle(color: AppColors.whiteColor),)),
                  ),
                ),
                const SizedBox(width: 10),
                CupertinoButton(
                  onPressed: () {
                    Utils().alertDialog(
                      context: context,
                      text: "Are you sure to reject this complaint",
                      onPressed: () {
                        FirebaseFirestore.instance.collection('complaints').doc(widget.id.toString()).update({
                          'status' : 'reject',
                        });
                      },
                    );
                  },
                  padding: EdgeInsets.zero,
                  child: Container(
                    width: 80,
                    height: 30,
                    decoration: BoxDecoration(
                      color: Colors.red,
                      borderRadius: BorderRadius.circular(3),
                    ),
                    child: const Center(child: Text("Reject",style: TextStyle(color: AppColors.whiteColor),)),
                  ),
                ),
              ],
            )
          ],
        ),
      ),
    );
  }
}
