import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:police_complaint_web/screens/view_complaint.dart';
import 'package:police_complaint_web/utilites/utils.dart';

import '../constants/app_colors.dart';
import '../constants/app_text_style.dart';
import '../constants/firebase_references.dart';

class AcceptComplaints extends StatefulWidget {
  const AcceptComplaints({super.key});

  @override
  State<AcceptComplaints> createState() => _AcceptComplaintsState();
}

class _AcceptComplaintsState extends State<AcceptComplaints> {
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
                Text("Accept Complaints", style: AppTextStyle.normalTextStyle()),
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
                    child: Padding(
                        padding: const EdgeInsets.all(10),
                        child: StreamBuilder<QuerySnapshot>(
                          stream: FirebaseFirestore.instance.collection('complaints').
                          where('stationId', isEqualTo: FirebaseReferences().auth.currentUser!.uid).
                          where('status',isEqualTo: 'accept').snapshots(),
                          builder: (context, snapshot) {
                            if(snapshot.hasData){
                              return ListView.builder(
                                itemCount: snapshot.data!.docs.length,
                                itemBuilder: (context, index) {
                                  return Container(
                                    height: 80,
                                    margin: const EdgeInsets.only(bottom: 5),
                                    color: Colors.grey.withOpacity(0.3),
                                    padding: EdgeInsets.all(10),
                                    child: Row(
                                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                      children: [
                                        Row(
                                          children: [
                                            Container(
                                              width: 80,
                                              height: double.infinity,
                                              color: Colors.brown,
                                              child: Center(
                                                child: Text("1",style: TextStyle(fontSize: 20,color: AppColors.whiteColor),),
                                              ),
                                            ),
                                            SizedBox(width: 20),
                                            Column(
                                              crossAxisAlignment: CrossAxisAlignment.start,
                                              children: [
                                                Text("${snapshot.data!.docs[index]['name']} / ${snapshot.data!.docs[index]['fatherName']}",style: TextStyle(fontSize: 20,color: AppColors.greenColor),),
                                                Text(snapshot.data!.docs[index]['date'],style: TextStyle(fontSize: 20,color: AppColors.greenColor),),
                                              ],
                                            )
                                          ],
                                        ),
                                        Row(
                                          children: [
                                            Column(
                                              children: [
                                                Text("Status",style: TextStyle(fontSize: 20,color: AppColors.greenColor),),
                                                CircleAvatar(radius: 15,
                                                    backgroundColor: snapshot.data!.docs[index]['status'] == 'processing' ? AppColors.processingColor :
                                                    snapshot.data!.docs[index]['status'] == 'accept' ? AppColors.processedColor :
                                                    snapshot.data!.docs[index]['status'] == 'reject' ? AppColors.rejectColor : AppColors.whiteColor
                                                )
                                              ],
                                            ),
                                            SizedBox(width: 20),
                                            Column(
                                              children: [
                                                Row(
                                                  children: [
                                                    CupertinoButton(
                                                      onPressed: () { Get.to(ViewComplaint(
                                                        name: snapshot.data!.docs[index]['name'],
                                                        complaintType: snapshot.data!.docs[index]['complaintType'],
                                                        alreadyVisit: snapshot.data!.docs[index]['visit'],
                                                        placeOfIncident: snapshot.data!.docs[index]['placeOfIncident'],
                                                        address: snapshot.data!.docs[index]['placeOfIncident'],
                                                        district: snapshot.data!.docs[index]['districtOfIncident'],
                                                        gender: snapshot.data!.docs[index]['gender'],
                                                        mobileNo: snapshot.data!.docs[index]['mobileNumber'],
                                                        cnic: snapshot.data!.docs[index]['cnicNo'],
                                                        email: snapshot.data!.docs[index]['email'],
                                                        fatherName: snapshot.data!.docs[index]['fatherName'],
                                                        date: snapshot.data!.docs[index]['date'],
                                                        id: snapshot.data!.docs[index]['id'],
                                                      ));},
                                                      padding: EdgeInsets.zero,
                                                      child: Container(
                                                        width: 80,
                                                        height: 30,
                                                        decoration: BoxDecoration(
                                                          color: AppColors.greenColor,
                                                          borderRadius: BorderRadius.circular(3),
                                                        ),
                                                        child: const Center(child: Text("View",style: TextStyle(color: AppColors.whiteColor),)),
                                                      ),
                                                    ),
                                                    const SizedBox(width: 10),
                                                    CupertinoButton(
                                                      onPressed: () {
                                                        Utils().alertDialog(
                                                          context: context,
                                                          text: "Are you sure to delete this complaint",
                                                          onPressed: () {
                                                            FirebaseFirestore.instance.collection('complaints').doc(snapshot.data!.docs[index]['id']).delete();
                                                            Get.back();
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
                                                        child: const Center(child: Text("Delete",style: TextStyle(color: AppColors.whiteColor),)),
                                                      ),
                                                    ),
                                                  ],
                                                ),
                                              ],
                                            )
                                          ],
                                        )
                                      ],
                                    ),
                                  );
                                },
                              );
                            }else{
                              return Center(child: CircularProgressIndicator());
                            }
                          },
                        )
                    )
                )
            ),
          ],
        ),
      ),
    );
  }
}
