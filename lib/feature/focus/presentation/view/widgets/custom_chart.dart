import 'package:flutter/material.dart';
import 'package:taskaya/core/utilites/constants/parameters.dart';
import 'package:taskaya/core/utilites/functions/get_curr_week_days.dart';
import 'package:taskaya/feature/focus/data/model/focus_model.dart';
import 'package:taskaya/feature/focus/presentation/manager/focus_bloc.dart';
import 'package:taskaya/feature/focus/presentation/view/widgets/day_in_chart.dart';

class CustomChart extends StatelessWidget {
  const CustomChart({super.key,required this.height,required this.width,required this.bloc});
  final double width;
  final double height;
  final FocusBloc bloc;
  @override
  Widget build(BuildContext context) {
    final List<AppUsage>list=bloc.appUsageList;
    return Stack(
      alignment: AlignmentDirectional.center,
      children: [
        Column(
          children: [
            Row(
              crossAxisAlignment: CrossAxisAlignment.end,
              children: [
                SizedBox(
                  height: height*0.28,
                  width: width*0.07,
                  child: ListView.separated(
                    physics: const NeverScrollableScrollPhysics(),
                    padding: EdgeInsets.zero,
                    itemCount: 5,
                    itemBuilder:(context,index){
                      return SizedBox(
                          height: height*0.02,
                          width: width*0.07,
                          child: Text("${roundDurationToNearestHour(bloc.steps[index])}h"));
                    } ,
                    separatorBuilder:(context,index){
                      return SizedBox(height: height*0.18/4);
                    } ,
                  ),
                ),
                SizedBox(width: width*0.015,),
                Row(
                  crossAxisAlignment: CrossAxisAlignment.end,
                  children: [
                    SizedBox(
                        height: height*0.3,
                        child: const VerticalDivider(thickness: 2,width: 0,)),
                    SizedBox(
                        width: width*0.8,
                        child: const Divider(thickness: 2,height: 0,)),
                  ],
                ),
              ],
            ),
            Padding(
              padding: EdgeInsetsDirectional.only(start: width*0.05),
              child: SizedBox(
                width: width*0.75,
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    ...List.generate(weekDay.length, (index)=>SizedBox(
                        width: width*0.1,
                        child: Text(getWeekDaysList(list)[index],textAlign: TextAlign.center,))),
                  ],
                ),
              ),
            ),
          ],
        ),
        SizedBox(
            width: width*0.75,
            height: height*0.28,
            child:Padding(
              padding: EdgeInsetsDirectional.only(bottom: height*0.015,start: width*0.04),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                 crossAxisAlignment: CrossAxisAlignment.end,
                children: [
                  ...List.generate(list.length, (currIndex)=>GestureDetector(
                      onTap: (){
                        bloc.add(ChangeDayUsageEvent(index: currIndex));

                      },
                      child: CustomDayContainerUsage(width: width,
                        height: height,
                        percentage:list[currIndex].totalUsage!.inMilliseconds/bloc.largerDuration,
                        enable: bloc.currDayIndex==currIndex,
                        dayDuration: list[currIndex].totalUsage!,
                      )
                  ))
                ],
              ),
            )
        ),
      ],
    );
  }
}
