import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:taskaya/core/utilites/app_theme/colors.dart';
import 'package:taskaya/core/utilites/dimensions/responsive_layout.dart';
import 'package:taskaya/feature/home/presentation/manager/home_bloc.dart';
import 'package:taskaya/feature/home/presentation/view/widgets/custom_bottom_nav.dart';
import 'package:taskaya/feature/home/presentation/view/widgets/custom_drawer.dart';
import 'package:taskaya/feature/home/presentation/view/widgets/home_body.dart';

class HomeView extends StatelessWidget {
  const HomeView({super.key});

  @override
  Widget build(BuildContext context) {
    final double width = BasicDimension.screenWidth(context);
    final double height = BasicDimension.screenHeight(context);
    return BlocProvider<HomeBloc>(
      create: (context) => HomeBloc()..add(LoadCustomDataEvent()),  // Create the bloc here
      child: BlocConsumer<HomeBloc, HomeState>(
        listener: (context, state) {
          // Handle state changes
        },
        builder: (context, state) {
          var bloc = BlocProvider.of<HomeBloc>(context);
          return SafeArea(
            child: Scaffold(
              resizeToAvoidBottomInset: false,
              drawer: CustomDrawer(
                profilePath: bloc.profilePicPath,
                width: width,
                height: height,
                name: bloc.name,
              ),
              body: bloc.isLoading ? const Center(child: CircularProgressIndicator()) :
              Padding(
                padding: EdgeInsets.symmetric(
                  horizontal: width * 0.03,
                  vertical: height * 0.015,
                ),
                child: HomeBody(width: width, bloc: bloc, height: height),
              ),
              floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
              floatingActionButton: bloc.bottomNavCurrIndex==0?FloatingActionButton(
                shape: const CircleBorder(),
                onPressed: null,
                backgroundColor: buttonColor,
                child: Icon(
                  CupertinoIcons.add,
                  color: whiteColor,
                ),
              ):null,
              bottomNavigationBar: BottomNavBar(height: height, bloc: bloc),
            ),
          );
        },
      ),
    );
  }
}




