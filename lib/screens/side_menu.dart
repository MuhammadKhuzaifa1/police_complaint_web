import 'dart:typed_data';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:easy_sidemenu/easy_sidemenu.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:image_picker_web/image_picker_web.dart';
import 'package:police_complaint_web/constants/app_assets.dart';
import 'package:police_complaint_web/constants/app_colors.dart';
import 'package:police_complaint_web/constants/app_text_style.dart';
import 'package:police_complaint_web/constants/firebase_references.dart';
import 'package:police_complaint_web/screens/accept_complaints.dart';
import 'package:police_complaint_web/screens/dashboard.dart';
import 'package:police_complaint_web/screens/new_complaints.dart';
import 'package:police_complaint_web/screens/reject_complaints.dart';
import 'package:uuid/uuid.dart';
import '../utilites/utils.dart';

class SideMenuScreen extends StatefulWidget {
  const SideMenuScreen({Key? key,}) : super(key: key);

  @override
  _SideMenuScreenState createState() => _SideMenuScreenState();
}

class _SideMenuScreenState extends State<SideMenuScreen> {
  PageController pageController = PageController();
  SideMenuController sideMenu = SideMenuController();

  String? name; 
  String? email;
  String? imageUrl;
  Uint8List? _imageData;
  String? id;

  getdata(){
    FirebaseReferences().stationsReference.doc(FirebaseReferences().auth.currentUser!.uid).get().then((value){
      setState(() {
        name = value['name'];
        email = value['email'];
        imageUrl = value['imageUrl'];
        id = value['id'];
      });
    });
  }

  @override
  void initState() {
    getdata();
    sideMenu.addListener((index) {
      pageController.jumpToPage(index);
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Dashboard",style: TextStyle(color: AppColors.whiteColor),),
        backgroundColor: AppColors.greenColor,
        elevation: 0.0,
        centerTitle: true,
      ),
      body: Row(
        mainAxisAlignment: MainAxisAlignment.start,
        children: [
          SideMenu(
            controller: sideMenu,
            style: SideMenuStyle(
              // showTooltip: false,
              displayMode: SideMenuDisplayMode.auto,
              itemOuterPadding: const EdgeInsets.symmetric(horizontal: 5.0,vertical: 5.0),
              hoverColor: Colors.green.withOpacity(0.4),
              backgroundColor: AppColors.greenColor,
              selectedHoverColor: Color.alphaBlend(
                  Color.fromRGBO(
                      Theme.of(context).colorScheme.surfaceTint.red,
                      Theme.of(context).colorScheme.surfaceTint.green,
                      Theme.of(context).colorScheme.surfaceTint.blue,
                      0.08),
                  AppColors.whiteColor),
              selectedColor: Colors.white,
              selectedTitleTextStyle: const TextStyle(color: AppColors.greenColor),
              selectedIconColor: AppColors.greenColor,
              openSideMenuWidth: 250,
              // decoration: BoxDecoration(
              //   borderRadius: BorderRadius.all(Radius.circular(10)),
              // ),
              // backgroundColor: Colors.blueGrey[700]
            ),
            title: Column(
              children: [
                ConstrainedBox(
                  constraints: const BoxConstraints(
                    maxHeight: 200,
                    maxWidth: 150,
                  ),
                  child: Column(
                    children: [
                      imageUrl == null ?
                      GestureDetector(
                        onTap: (){
                          _pickImage(id.toString());
                        },
                        child: CircleAvatar(
                          backgroundImage: NetworkImage(
                            AppAssets.logo,
                          ),
                          radius: 70,
                        ),
                      ):GestureDetector(
                        onTap: (){
                          _pickImage(id.toString());
                        },
                        child: CircleAvatar(
                          backgroundImage: NetworkImage(
                            imageUrl.toString(),
                          ),
                          radius: 70,
                        ),
                      ),
                      const SizedBox(height: 4),
                      Text(name ?? "Mardan Statino",style: TextStyle(fontSize: 16,color: AppColors.whiteColor),),
                      Text(email ?? "demo@gamil.com",style: TextStyle(fontSize: 16,color: AppColors.whiteColor),),
                    ],
                  ),
                ),
                const Divider(
                  indent: 8.0,
                  endIndent: 8.0,
                ),
              ],
            ),
            footer: const Padding(
              padding: EdgeInsets.all(8.0),
              child: Text(
                'OPTEDCODE',
                style: TextStyle(fontSize: 15),
              ),
            ),
            items: [
              SideMenuItem(
                priority: 0,
                title: 'Dashboard',
                onTap: (index, _) {
                  sideMenu.changePage(index);
                },
                icon: const Icon(Icons.home),
                tooltipContent: "This is a tooltip for Dashboard item",
              ),
              SideMenuItem(
                priority: 1,
                title: 'New Complaint',
                onTap: (index, _) {
                  sideMenu.changePage(index);
                },
                icon: const Icon(Icons.supervisor_account),
              ),
              SideMenuItem(
                priority: 2,
                title: 'Processed',
                onTap: (index, _) {
                  sideMenu.changePage(index);
                },
                icon: const Icon(Icons.check_circle),
              ),
              SideMenuItem(
                priority: 3,
                title: 'Rejected',
                onTap: (index, _) {
                  sideMenu.changePage(index);
                },
                icon: const Icon(Icons.cancel),
              ),
              // SideMenuItem(
              //   priority: 5,
              //   title: 'Police Station',
              //   onTap: (index, _) {
              //     sideMenu.changePage(index);
              //   },
              //   icon: const Icon(Icons.houseboat),
              // ),
              const SideMenuItem(
                priority: 6,
                title: 'Logout',
                icon: Icon(Icons.exit_to_app),
              ),
            ],
          ),
          Expanded(
            child: PageView(
              controller: pageController,
              children: [
                Dashboard(),
                NewComplaints(),
                AcceptComplaints(),
                RejectComplaints(),
                Container(
                  color: Colors.white,
                  child: const Center(
                    child: Text(
                      'Settings',
                      style: TextStyle(fontSize: 35),
                    ),
                  ),
                ),
                // PoliceStations(),
                // Container(
                //   color: Colors.white,
                //   child: const Center(
                //     child: Text(
                //       'Settings',
                //       style: TextStyle(fontSize: 35),
                //     ),
                //   ),
                // ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Future<void> _pickImage(String id) async {
    final mediaInfo = await ImagePickerWeb.getImageInfo;
    if (mediaInfo != null) {
      setState(() {
        _imageData = mediaInfo.data;
      });
      final firebaseStorageRef = FirebaseStorage.instance.ref().child("${Uuid().v4()}.jpg");
      await firebaseStorageRef.putData(_imageData!);
      String downloadURL = await firebaseStorageRef.getDownloadURL();
      FirebaseReferences().stationsReference.doc(id).update({
        'imageUrl' : downloadURL.toString(),
      }).then((value){
        setState(() {
          print(downloadURL);
          imageUrl = downloadURL.toString();
        });
        Utils.toastMessage("Image Update successfully");
      });
    }
  }

}