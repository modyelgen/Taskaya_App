import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:taskaya/core/utilites/dimensions/responsive_layout.dart';
import 'package:taskaya/feature/on_boarding_screen/data/on_boarding_data.dart';
import 'package:taskaya/feature/on_boarding_screen/presentation/manager/on_boarding_bloc.dart';
import 'package:taskaya/feature/on_boarding_screen/presentation/view/widgets/custom_on_boarding_page.dart';
class OnBoardingView extends StatelessWidget {
  const OnBoardingView({super.key,required this.toggleMode,required this.toggleLang});
final void Function() toggleMode;
final void Function() toggleLang;
  @override
  Widget build(BuildContext context) {
    final double width=BasicDimension.screenWidth(context);
    final double height=BasicDimension.screenHeight(context);
    return BlocProvider(
      create:(context)=>OnBoardingBloc(),
      child:BlocConsumer<OnBoardingBloc,OnBoardingState>(
          builder: (context,state){
            var bloc=BlocProvider.of<OnBoardingBloc>(context);
            return SafeArea(
              child: Scaffold(
                body: PageView.builder(
                  controller: bloc.pageController,
                  itemCount: 3,
                  onPageChanged: (int index){
                    bloc.add(TogglePageEvent(index:index));
                  },
                    itemBuilder: (context,index){
                      return CustomOnBoardingPage(height: height, toggleMode: toggleMode,toggleLang:toggleLang,width: width, model: onBoardingList[index], currIndex:index, moveBackward: (){
                        bloc.add(MoveBackwardEvent());},
                          moveForward: (){
                        bloc.add(MoveForwardEvent());
                  });
                }),
              ),
            );
          },
          listener: (context,state){
            if(state is OnBoardingFinishedState){
            }
          }) ,
    );
  }
}


