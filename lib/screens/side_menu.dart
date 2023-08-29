import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:easy_sidemenu/easy_sidemenu.dart';
import 'package:flutter/material.dart';
import 'package:police_complaint_web/constants/app_assets.dart';
import 'package:police_complaint_web/constants/app_colors.dart';
import 'package:police_complaint_web/constants/app_text_style.dart';
import 'package:police_complaint_web/constants/firebase_references.dart';
import 'package:police_complaint_web/screens/dashboard.dart';
import 'package:police_complaint_web/screens/police_stations.dart';

import '../testing.dart';
import '../utilites/pie_chart.dart';

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

  getdata(){
    FirebaseReferences().stationsReference.doc(FirebaseReferences().auth.currentUser!.uid).get().then((value){
      setState(() {
        name = value['name'];
        email = value['email'];
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
                      Image.asset(
                        AppAssets.logo,
                      ),
                      const SizedBox(height: 4),
                      Text(name??"Mardan Statino",style: TextStyle(fontSize: 16,color: AppColors.whiteColor),),
                      Text(email??"demo@gamil.com",style: TextStyle(fontSize: 16,color: AppColors.whiteColor),),
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
                title: 'Processing',
                onTap: (index, _) {
                  sideMenu.changePage(index);
                },
                icon: const Icon(Icons.access_time_filled_rounded),
              ),
              SideMenuItem(
                priority: 3,
                title: 'Processed',
                onTap: (index, _) {
                  sideMenu.changePage(index);
                },
                icon: const Icon(Icons.check_circle),
              ),
              SideMenuItem(
                priority: 4,
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
                PieChartSample2(),
                Container(
                  color: Colors.white,
                  child: const Center(
                    child: Text(
                      'Files',
                      style: TextStyle(fontSize: 35),
                    ),
                  ),
                ),
                Container(
                  color: Colors.white,
                  child: const Center(
                    child: Text(
                      'Download',
                      style: TextStyle(fontSize: 35),
                    ),
                  ),
                ),
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

}