import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:taskaya/core/utilites/app_theme/colors.dart';
import 'package:taskaya/core/utilites/dimensions/responsive_layout.dart';
import 'package:taskaya/feature/calendar/presentation/view/calendar_view.dart';
import 'package:taskaya/feature/focus/presentation/view/foucs_view.dart';
import 'package:taskaya/feature/home/presentation/manager/home_bloc.dart';
import 'package:taskaya/feature/home/presentation/view/widgets/add_task_pop.dart';
import 'package:taskaya/feature/home/presentation/view/widgets/custom_bottom_nav.dart';
import 'package:taskaya/feature/home/presentation/view/widgets/custom_drawer.dart';
import 'package:taskaya/feature/home/presentation/view/widgets/home_body.dart';
import 'package:taskaya/feature/profile/presentation/view/profile_view.dart';


class HomeView extends StatelessWidget {
  const HomeView({super.key});

  @override
  Widget build(BuildContext context) {
    final double width = BasicDimension.screenWidth(context);
    final double height = BasicDimension.screenHeight(context);
    return BlocProvider<HomeBloc>(
      create: (context) => HomeBloc()..add(LoadCustomDataEvent())..add(LoadTaskEvent()),  // Create the bloc here
      child: BlocConsumer<HomeBloc, HomeState>(
        listener: (context, state) {
          // Handle state changes
        },
        builder: (context, state) {
          var bloc = BlocProvider.of<HomeBloc>(context);
          return SafeArea(
            child: PopScope(
              canPop: bloc.canPoop,
              onPopInvoked: (enable) async{
                 if(bloc.bottomNavCurrIndex>0){
                  bloc.add(ChangeBottomNavIconEvent(currIndex: 0));
                }
                else{
                  //Navigator.pop(context);
                  bloc.add(AllowToPopEvent(allow: true));
                }
              },
              child: Scaffold(
                resizeToAvoidBottomInset: false,
                drawer:bloc.bottomNavCurrIndex==0? CustomDrawer(
                  profilePath: bloc.profilePicPath,
                  width: width,
                  height: height,
                  name: bloc.name,
                ):null,
                body: [HomeBody(width: width, bloc: bloc, height: height),const CalendarView(),const FocusView(),ProfileView(name:bloc.name,profilePath:bloc.profilePicPath)][bloc.bottomNavCurrIndex],
                floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
                floatingActionButton:FloatingActionButton(
                  shape: const CircleBorder(),
                  onPressed:bloc.bottomNavCurrIndex==0? ()async{
                    await showModalBottomSheet(context: context,
                        isScrollControlled: true,
                        isDismissible: false,
                        builder: (context)=>Padding(
                          padding: EdgeInsets.only(bottom:MediaQuery.of(context).viewInsets.bottom),
                          child:AddTaskPop(height: height, width: width,bloc: bloc,),
                    ));
                  }:null,
                  backgroundColor: buttonColor,
                  child: Icon(
                    CupertinoIcons.add,
                    color: whiteColor,
                  ),
                ),
                bottomNavigationBar: BottomNavBar(currIndex:bloc.bottomNavCurrIndex ,changeIndex:({required int currIndex}){
                  bloc.add(ChangeBottomNavIconEvent(currIndex: currIndex));
                } ,),
              ),
            ),
          );
        },
      ),
    );
  }
}




