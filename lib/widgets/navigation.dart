import 'package:app_passo/bloc/bottomNavBar.dart';
import 'package:app_passo/view/assistintelligent.dart';
import 'package:app_passo/view/createalarm.dart';
import 'package:app_passo/view/homescreen.dart';
import 'package:app_passo/view/weather.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:iconly/iconly.dart';
import 'package:lottie/lottie.dart';

class CustomNavigation extends StatefulWidget {
  const CustomNavigation({super.key});

  @override
  State<CustomNavigation> createState() => _CustomNavigationState();
}

class _CustomNavigationState extends State<CustomNavigation> {
  late PageController pageController;
  late BottomNavCubit bottomNavCubit;

  @override
  void initState() {
    super.initState();
    pageController = PageController();
  }

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    bottomNavCubit = BlocProvider.of<BottomNavCubit>(context);
  }

  @override
  void dispose() {
    pageController.dispose();
    super.dispose();
  }

  final List<Widget> pageView = const [
    MyHomePage(),
    WeatherScreen(),
    SleepStatsScreen(),
  ];

  void onPageChanged(int page) {
    if (mounted) {
      bottomNavCubit.changeSelectedIndex(page);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: _mainWrapperBody(),
      bottomNavigationBar: _mainWrapperBottomNavBar(),
      floatingActionButtonLocation: FloatingActionButtonLocation.endDocked,
      floatingActionButton: Padding(
        padding: const EdgeInsets.only(top: 10),
        child: _mainFloating(),
      ),
    );
  }

  Widget _mainWrapperBottomNavBar() {
    return BlocBuilder<BottomNavCubit, int>(
      builder: (context, selectedIndex) {
        return BottomAppBar(
          color: Color(0xFF141414),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            mainAxisSize: MainAxisSize.min,
            children: [
              Expanded(
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  children: [
                    _bottomAppBarItem(
                      defaultIcon: IconlyLight.folder,
                      page: 0,
                      label: "Alarma",
                      filledIcon: IconlyBold.folder,
                    ),
                    _bottomAppBarItem(
                      defaultIcon: IconlyLight.activity,
                      page: 1,
                      label: "Clima",
                      filledIcon: IconlyBold.work,
                    ),
                    _bottomAppBarItem(
                      defaultIcon: IconlyLight.chat,
                      page: 2,
                      label: "Asistent",
                      filledIcon: IconlyBold.chat,
                    ),
                  ],
                ),
              ),
              const SizedBox(width: 50, height: 10),
            ],
          ),
        );
      },
    );
  }

  PageView _mainWrapperBody() {
    return PageView(
      onPageChanged: onPageChanged,
      controller: pageController,
      children: pageView,
    );
  }

  FloatingActionButton _mainFloating() {
    return FloatingActionButton(
      onPressed: () {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(
            behavior: SnackBarBehavior.floating,
            backgroundColor: Color(0xFF141414),
            content: Text("📮¡Acuerdate de activarla luego de crearla!"),
          ),
        );
        Navigator.push(
          context,
          MaterialPageRoute(builder: (context) => const CreateAlarm()),
        );
      },
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(50)),
      backgroundColor: Color(0xFF141414),
      child: Lottie.asset(
        'assets/add_alarm.json',
        width: 70,
        height: 70,
        fit: BoxFit.cover,
      ),
    );
  }

  Widget _bottomAppBarItem({
    required IconData defaultIcon,
    required int page,
    required String label,
    required IconData filledIcon,
  }) {
    final selectedIndex = bottomNavCubit.state;
    final isSelected = selectedIndex == page;

    return GestureDetector(
      onTap: () {
        bottomNavCubit.changeSelectedIndex(page);
        pageController.animateToPage(
          page,
          duration: const Duration(milliseconds: 300),
          curve: Curves.fastLinearToSlowEaseIn,
        );
      },
      child: Container(
        color: Colors.transparent,
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Icon(
              isSelected ? filledIcon : defaultIcon,
              color: isSelected ? const Color(0xFF0527EC) : Colors.grey,
              size: 26,
            ),
            const SizedBox(height: 3),
            Text(
              label,
              style: GoogleFonts.aBeeZee(
                color: isSelected ? Color(0xFF0527EC) : Colors.grey,
                fontSize: 13,
                fontWeight: isSelected ? FontWeight.w600 : FontWeight.w400,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
