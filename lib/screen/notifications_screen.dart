import 'package:flutter/material.dart';
import 'package:flutter_slidable/flutter_slidable.dart';
import 'package:project3/data.dart';
import 'package:project3/theme/theme.dart';
import 'package:project3/widgets/bottom_bar.dart';
import 'package:project3/widgets/customformfeild.dart';
import 'package:share_plus/share_plus.dart';

class NotificationsScreen extends StatefulWidget {
  const NotificationsScreen({super.key});
  static String id = "Notification Screen";

  @override
  State<NotificationsScreen> createState() => _NotificationsScreenState();
}

class _NotificationsScreenState extends State<NotificationsScreen> {
  final List<NavigationItem> navigationItems = getNavigationItemList();
  NavigationItem? selectedItem;

  @override
  void initState() {
    super.initState();
    setState(() {
      selectedItem = navigationItems[1];
    });
  }

  void _onNavigationItemSelected(NavigationItem item) {
    setState(() {
      selectedItem = item;
    });
  }

  void shareCar() {
    Share.share('Notification');
  }

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    // get the notification message and display on screen
    // final message = ModalRoute.of(context)!.settings.arguments as RemoteMessage;
    return Scaffold(
      appBar: AppBar(
        iconTheme: const IconThemeData(color: Colors.white),
        backgroundColor: lightColorScheme.primary,
        elevation: 0,
        centerTitle: true,
        title: const Text(
          'Notification',
          style: TextStyle(
            fontSize: 26,
            color: Colors.white,
            fontWeight: FontWeight.bold,
          ),
        ),
      ),
      body: Column(
        children: [
          Padding(
            padding: const EdgeInsets.all(16),
            child: Customformfeild(
          
              hintText: 'Search notifications',
              labeltext: const Text('notifications'),
              icon: Icons.search,
            ),
          ),
          const SizedBox(height: 10),
          Expanded(
            child: ListView.separated(
                itemBuilder: (context, index) {
                  return Slidable(
                    endActionPane: ActionPane(
                      extentRatio: 0.3,
                      motion: const ScrollMotion(),
                      children: [
                        SlidableAction(
                          onPressed: (context) {
                            shareCar;
                          },
                          icon: Icons.share,
                          backgroundColor: Colors.grey[300]!,
                        ),
                        SlidableAction(
                          onPressed: (context) {},
                          icon: Icons.delete,
                          foregroundColor: Colors.white,
                          backgroundColor: Colors.red[700]!,
                        ),
                      ],
                    ),
                    child: ListTile(
                      isThreeLine: true,
                      contentPadding:
                          EdgeInsets.symmetric(horizontal: size.width * 0.08),
                      leading: const CircleAvatar(
                        radius: 25,
                        backgroundImage:
                            AssetImage('assets/images/profile.jpg'),
                      ),
                      title: const Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text(
                            'Team',
                            style: TextStyle(
                              fontWeight: FontWeight.w600,
                            ),
                          ),
                          Text(
                            '2h Ago',
                            style: TextStyle(
                              fontSize: 12,
                            ),
                          ),
                        ],
                      ),
                      subtitle: const Text(
                        'please share in project before friday, the next meeting agenda will based on it',
                        maxLines: 2,
                        overflow: TextOverflow.ellipsis,
                      ),
                    ),
                  );
                },
                separatorBuilder: (context, index) => Divider(
                      color: Colors.grey[400],
                      indent: size.width * .08,
                      endIndent: size.width * .08,
                    ),
                itemCount: 10),
          ),
        ],
      ),
      bottomNavigationBar: CustomBottomNavigationBar(
        navigationItems: navigationItems,
        selectedItem: selectedItem!,
        onItemSelected: _onNavigationItemSelected,
      ),
    );
  }

  // Widget listView() {
  //   return ListView.separated(
  //     itemBuilder: (context, index) {
  //       return listViewItem(index);
  //     },
  //     separatorBuilder: (context, index) {
  //       return Divider(height: 0);
  //     },
  //     itemCount: 15,
  //   );
  // }

  // Widget listViewItem(int index) {
  //   return Container(
  //     margin: const EdgeInsets.symmetric(horizontal: 13,vertical: 10),
  //     child: Row(
  //       crossAxisAlignment: CrossAxisAlignment.start,
  //       children: [
  //         prefixIcon(index),
  //         Expanded(
  //           child: Container(
  //             margin: const EdgeInsets.only(left: 10),
  //             child: Column(
  //               crossAxisAlignment: CrossAxisAlignment.start,
  //               children: [
  //                 message(index),
  //                 timeAndDate(index),
  //               ],
  //             ),
  //           ),
  //         ),
  //       ],
  //     ),
  //   );
  // }

  // Widget prefixIcon(int index) {
  //   return Container(
  //     height: 50,
  //     width: 50,
  //     padding: const EdgeInsets.all(10),
  //     decoration:
  //         BoxDecoration(shape: BoxShape.circle, color: Colors.grey.shade300),
  //     child: Icon(
  //       Icons.notifications,
  //       size: 25,
  //       color: Colors.grey.shade700,
  //     ),
  //   );
  // }

  // Widget message(int index) {
  //   double textsize = 14;
  //   return Container(
  //     child: RichText(
  //       maxLines: 3,
  //       overflow: TextOverflow.ellipsis,
  //       text: TextSpan(
  //           text: 'message',
  //           style: TextStyle(
  //             fontSize: textsize,
  //             color: Colors.black,
  //             fontWeight: FontWeight.bold,
  //           ),
  //           children: const [
  //             TextSpan(
  //                 text: 'Notification Description',
  //                 style: TextStyle(
  //                   fontWeight: FontWeight.w400,
  //                 )),
  //           ]),
  //     ),
  //   );
  // }

  // Widget timeAndDate(int index) {
  //   return Container(
  //     margin: const EdgeInsets.only(top: 5),
  //     child: const Row(
  //       mainAxisAlignment: MainAxisAlignment.spaceBetween,
  //       children: [
  //         Text(
  //           '24/12/2024',
  //           style: TextStyle(
  //             fontSize: 10,
  //           ),
  //         ),
  //         Text(
  //           '09:15 am',
  //           style: TextStyle(
  //             fontSize: 10,
  //           ),
  //         ),
  //       ],
  //     ),
  //   );
  // }
}
//  Column(
//         children: [
//           // Text(message.notification!.title.toString()),
//           // Text(message.notification!.body.toString()),
//         ],
//       ),