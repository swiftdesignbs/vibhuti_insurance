// import 'package:flutter/material.dart';
// import 'package:vibhuti_insurance_mobile_app/screens/main_screen.dart';
// import 'package:vibhuti_insurance_mobile_app/utils/app_text_theme.dart';
// import 'package:vibhuti_insurance_mobile_app/widgets/custom_appbar.dart';

// class BaseScaffold extends StatefulWidget {
//   final Widget body;
//   final String? title;
//   final bool showWelcomeMessage;
//   final int currentIndex;
//   final ValueChanged<int>? onNavigationTap;
//   final List<Widget>? actions;
//   final Widget? leading;

//   const BaseScaffold({
//     super.key,
//     required this.body,
//     this.title,
//     this.showWelcomeMessage = false,
//     this.currentIndex = 0,
//     this.onNavigationTap,
//     this.actions,
//     this.leading,
//   });

//   @override
//   State<BaseScaffold> createState() => _BaseScaffoldState();
// }

// class _BaseScaffoldState extends State<BaseScaffold> {
//   final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       key: _scaffoldKey,
//       appBar: PreferredSize(
//         preferredSize: const Size.fromHeight(70),
//         child: AppBar(
//           backgroundColor: AppTextTheme.appBarColor,
//           automaticallyImplyLeading: false,
//           leading:
//               widget.leading ??
//               IconButton(
//                 onPressed: () => _scaffoldKey.currentState?.openDrawer(),
//                 icon: Image.asset(
//                   'assets/icons/menu.png',
//                   height: 24,
//                   width: 24,
//                 ),
//               ),
//           title: _buildAppBarTitle(),
//           actions:
//               widget.actions ??
//               [
//                 Padding(
//                   padding: const EdgeInsets.symmetric(horizontal: 20),
//                   child: CircleAvatar(
//                     backgroundColor: Colors.grey.shade200,
//                     child: IconButton(
//                       onPressed: () {
//                         widget.onNavigationTap?.call(3); // Navigate to profile
//                       },
//                       icon: Image.asset(
//                         'assets/icons/profile_icon.png',
//                         height: 24,
//                         width: 24,
//                       ),
//                     ),
//                   ),
//                 ),
//               ],
//         ),
//       ),
//       drawer: AppDrawer(scaffoldKey: _scaffoldKey),
//       body: widget.body,
//       bottomNavigationBar: widget.onNavigationTap != null
//           ? _buildBottomNavigationBar()
//           : null,
//     );
//   }

//   Widget _buildAppBarTitle() {
//     if (widget.showWelcomeMessage) {
//       return Column(
//         crossAxisAlignment: CrossAxisAlignment.start,
//         mainAxisAlignment: MainAxisAlignment.center,
//         children: [
//           Text('Welcome', style: AppTextTheme.pageTitle),
//           Text('Krishnan Murthy', style: AppTextTheme.pageTitle),
//         ],
//       );
//     } else if (widget.title != null) {
//       return Text(widget.title!, style: AppTextTheme.pageTitle);
//     } else {
//       return const SizedBox.shrink();
//     }
//   }

//   Widget _buildBottomNavigationBar() {
//     return Container(
//       decoration: BoxDecoration(
//         color: Colors.white,
//         borderRadius: const BorderRadius.only(
//           topLeft: Radius.circular(20),
//           topRight: Radius.circular(20),
//         ),
//         border: Border.all(color: Colors.grey.shade300, width: 1),
//         boxShadow: [
//           BoxShadow(
//             color: Colors.black12,
//             blurRadius: 8,
//             offset: const Offset(0, -2),
//           ),
//         ],
//       ),
//       child: ClipRRect(
//         borderRadius: const BorderRadius.only(
//           topLeft: Radius.circular(20),
//           topRight: Radius.circular(20),
//         ),
//         child: BottomNavigationBar(
//           currentIndex: widget.currentIndex,
//           onTap: widget.onNavigationTap,
//           type: BottomNavigationBarType.fixed,
//           backgroundColor: Colors.white,
//           selectedItemColor: AppTextTheme.primaryColor,
//           unselectedItemColor: Colors.grey,
//           showSelectedLabels: false,
//           showUnselectedLabels: false,
//           iconSize: 42,
//           items: [
//             _buildNavItem('assets/icons/nav1.png'),
//             _buildNavItem('assets/icons/nav2.png'),
//             _buildNavItem('assets/icons/nav3.png'),
//             _buildNavItem('assets/icons/nav4.png'),
//             _buildNavItem('assets/icons/nav5.png'),
//           ],
//         ),
//       ),
//     );
//   }

//   BottomNavigationBarItem _buildNavItem(String iconPath) {
//     return BottomNavigationBarItem(
//       icon: Image.asset(iconPath, height: 42, width: 42),
//       activeIcon: CircleAvatar(
//         backgroundColor: AppTextTheme.primaryColor,
//         child: Image.asset(
//           iconPath,
//           height: 40,
//           width: 40,
//           color: Colors.white,
//         ),
//       ),
//       label: '',
//     );
//   }
// }
