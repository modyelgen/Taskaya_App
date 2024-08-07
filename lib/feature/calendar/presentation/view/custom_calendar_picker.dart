import 'package:flutter/material.dart';
import 'package:taskaya/core/utilites/app_theme/colors.dart';
import 'package:taskaya/core/utilites/app_theme/text_style.dart';
import 'package:taskaya/core/utilites/functions/extension.dart';
import 'package:taskaya/core/utilites/widgets/custom_big_button.dart';
import 'package:taskaya/feature/calendar/presentation/manager/calendar_bloc.dart';

class CustomCalendarWidget extends StatelessWidget {
  const CustomCalendarWidget({
    super.key,
    required this.width,
    required this.bloc,
    required this.height,
  });

  final double width;
  final CalendarBloc bloc;
  final double height;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsetsDirectional.all(width*0.025),
      width: width,
      decoration: BoxDecoration(
        color: bottomNavBarColor,
      ),
      child: Column(
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              IconButton(onPressed: (){
                bloc.add(ChangeCurrMonthEvent(forward: false));
              }, icon: const Icon(Icons.arrow_back_ios_new,color: Colors.white,)),
              Text(bloc.currentDate.month.getMonthName(),style: CustomTextStyle.fontBoldWhite16,),
              IconButton(onPressed: (){
                bloc.add(ChangeCurrMonthEvent(forward: true));
              }, icon: const Icon(Icons.arrow_forward_ios,color: Colors.white)),
            ],
          ),
          Text("${bloc.currentDate.year}",style: CustomTextStyle.fontNormal14.copyWith(color: customBorderColor),),
          SizedBox(height: height*0.02,),
          SizedBox(
            height: height*0.075,
            child: ListView.separated(
                scrollDirection: Axis.horizontal,
                controller: bloc.scrollController,

                physics:const BouncingScrollPhysics(),
                itemBuilder: (context,index){
                  return CustomBigButton(
                    onTap: (){
                      bloc.add(ChangeDayPickerEvent(index: index));
                    },
                    color:index==(bloc.currDay-1)?buttonColor:null,
                    altWidth: width*0.15,
                    borderRadius: 4,
                    altWidget: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Text(bloc.calendarDaysList[index].dayName,style: CustomTextStyle.fontNormal16.copyWith(color: index==(bloc.currDay-1)?Colors.white:null),),
                        const SizedBox(height: 3,),
                        Text("${bloc.calendarDaysList[index].dayNum}",style: CustomTextStyle.fontNormal14.copyWith(color: index==(bloc.currDay-1)?Colors.white:null),),
                      ],
                    ),
                  );
                },
                separatorBuilder: (context,index){
                  return SizedBox(width: width*0.01,);
                },
                itemCount: bloc.calendarDaysList.length),
          ),
        ],
      ),
    );
  }
}