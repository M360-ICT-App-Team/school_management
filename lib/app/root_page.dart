// import 'package:flutter/material.dart';
// import '../core/constants/app_sizes.dart';
// import '../core/model/nav_model.dart';
// import '../core/widgets/app_bottom_nav_item.dart';


// class RootPage extends StatefulWidget {
//   const RootPage({super.key});

//   @override
//   State<RootPage> createState() => _RootPageState();
// }

// class _RootPageState extends State<RootPage> {
//   final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();
//   final ValueNotifier<int> currentPage = ValueNotifier<int>(2);

//   final List<NavModel> navItems = [];

//   @override
//   void dispose() {
//     currentPage.dispose();
//     super.dispose();
//   }

//   @override
//   void initState() {
//     super.initState();
//     context.read<ProfileBloc>().add(FetchProfileEvent());
//     navItems.addAll([
//       NavModel(
//         page: const VisaSearchPage(),
//         icon: HugeIcons.strokeRoundedPassport01,
//       ),
//       NavModel(
//         page: const SearchHotelScreen(),
//         icon: HugeIcons.strokeRoundedHotel01,
//       ),
//       NavModel(
//         page: FlightSearchPage(
//           openDrawer: () => _scaffoldKey.currentState?.openDrawer(),
//         ),
//         icon: HugeIcons.strokeRoundedAirplane01,
//       ),
//       NavModel(
//         page: const AirportAssistancePage(),
//         icon: HugeIcons.strokeRoundedAirport,
//       ),
//       NavModel(
//         page: const HealthCareWebPage(url: "https://letsfly.trip.health/"),
//         icon: HugeIcons.strokeRoundedHealth,
//       ),
//     ]);
//   }

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       key: _scaffoldKey,
//       drawer: const AppDrawer(),
//       body: Stack(
//         children: [
//           ValueListenableBuilder<int>(
//             valueListenable: currentPage,
//             builder: (_, value, __) => navItems[value].page,
//           ),
//           Positioned(
//             bottom: 0,
//             left: 0,
//             right: 0,
//             child: Container(
//               height: AppSizes.height(context, 120),
//               width: double.maxFinite,
//               decoration: BoxDecoration(
//                 gradient: LinearGradient(
//                   colors: [
//                     AppColors.white.withValues(alpha: 0),
//                     AppColors.white,
//                   ],
//                   begin: Alignment.topCenter,
//                   end: Alignment.bottomCenter,
//                 ),
//               ),
//             ),
//           ),
//           Positioned(
//             bottom: AppSizes.bodyPadding,
//             left: 0,
//             right: 0,
//             child: SafeArea(
//               child: Container(
//                 margin: const EdgeInsets.symmetric(
//                   horizontal: AppSizes.bodyPadding,
//                 ),
//                 padding: EdgeInsets.all(AppSizes.insidePadding / 2),
//                 decoration: BoxDecoration(
//                   color: AppColors.white,
//                   borderRadius: BorderRadius.circular(AppSizes.radiusLarge * 2),
//                   boxShadow: [AppColors.appShadow],
//                 ),
//                 child: ValueListenableBuilder<int>(
//                   valueListenable: currentPage,
//                   builder: (_, value, __) {
//                     return Row(
//                       mainAxisAlignment: MainAxisAlignment.spaceAround,
//                       children: List.generate(navItems.length, (index) {
//                         return AppBottomNavItem(
//                           iconData: navItems[index].icon,
//                           isSelected: index == value,
//                           onTap: () => currentPage.value = index,
//                         );
//                       }),
//                     );
//                   },
//                 ),
//               ),
//             ),
//           ),
//         ],
//       ),
//     );
//   }
// }
