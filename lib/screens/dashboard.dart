import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:police_complaint_web/constants/app_colors.dart';
import 'package:police_complaint_web/constants/firebase_references.dart';
import 'package:police_complaint_web/screens/view_complaint.dart';
import 'package:police_complaint_web/utilites/pie_chart.dart';
import 'package:police_complaint_web/utilites/utils.dart';

import '../constants/app_text_style.dart';

class Dashboard extends StatefulWidget {
  const Dashboard({Key? key}) : super(key: key);

  @override
  State<Dashboard> createState() => _DashboardState();
}

class _DashboardState extends State<Dashboard> {
  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(20),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text("Summary", style: AppTextStyle.normalTextStyle()),
              const SizedBox(height: 10),
              SizedBox(
                height: 230,
                child: ListView(
                  scrollDirection: Axis.horizontal,
                  children: [
                    box2(color: Colors.orange),
                    box1(text: "Processing",color: AppColors.processingColor),
                    box1(text: "Processed",color: AppColors.processedColor),
                    box1(text: "Reject",color: AppColors.rejectColor),
                  ],
                )
              ),
            ],
          ),
          const SizedBox(height: 30),
          Text("Total Complaint", style: AppTextStyle.normalTextStyle()),
          const SizedBox(height: 10),
          Expanded(
            child: Container(
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
                    where('stationId', isEqualTo: FirebaseReferences().auth.currentUser!.uid).snapshots(),
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
              ),
            ),
          )
        ],
      ),
    );
  }

  Widget box1({String? count, Color? color, String? text}){
    return Container(
      padding: EdgeInsets.all(10),
      margin: EdgeInsets.symmetric(horizontal: 10),
      height: 230,
      width: 170,
      decoration: BoxDecoration(
        color: AppColors.whiteColor,
        boxShadow: [
          BoxShadow(
            color: Colors.black26,
            blurRadius: 20,
            offset: Offset(1,2),
            spreadRadius: 2,
          )
        ]
      ),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(text!,style: const TextStyle(fontSize: 20),),
          FittedBox(child: Text("223",style: TextStyle(color: color,fontSize: 40),)),
          CupertinoButton(
            onPressed: () {},
            padding: EdgeInsets.zero,
            child: Container(
              width: double.infinity,
              height: 30,
              decoration: BoxDecoration(
                color: color,
                borderRadius: BorderRadius.circular(3),
              ),
              child: const Center(child: Text("See All",style: TextStyle(color: AppColors.whiteColor),)),
            ),
          )
        ],
      ),
    );
  }
  Widget box2({String? count, Color? color}){
    return Container(
      padding: const EdgeInsets.all(20),
      margin: const EdgeInsets.only(right: 10),
      height: 230,
      width: 500,
      decoration: const BoxDecoration(
        color: AppColors.whiteColor,
        boxShadow: [
          BoxShadow(
            color: Colors.black26,
            blurRadius: 20,
            offset: Offset(1,2),
            spreadRadius: 2,
          )
        ]
      ),
      child: const Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Column(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  CircleAvatar(radius: 7,backgroundColor: Colors.yellow,),
                  SizedBox(width: 5),
                  Text("Total Complaints",style: TextStyle(fontSize: 16),),
                ],
              ),
              SizedBox(height: 10),
              Row(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  CircleAvatar(radius: 7,backgroundColor: AppColors.processingColor,),
                  SizedBox(width: 5),
                  Text("Processing",style: TextStyle(fontSize: 16),),
                ],
              ),
              SizedBox(height: 10),
              Row(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  CircleAvatar(radius: 7,backgroundColor: AppColors.processedColor,),
                  SizedBox(width: 5),
                  Text("Processed",style: TextStyle(fontSize: 16),),
                ],
              ),
              SizedBox(height: 10),
              Row(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  CircleAvatar(radius: 7,backgroundColor: AppColors.rejectColor,),
                  SizedBox(width: 5),
                  Text("Rejected",style: TextStyle(fontSize: 16),),
                ],
              ),
            ],
          ),
          PieChartSample2()
        ],
      ),
    );
  }
}
