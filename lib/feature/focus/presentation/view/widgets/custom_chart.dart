import 'package:flutter/material.dart';
import 'package:taskaya/core/utilites/constants/parameters.dart';
import 'package:taskaya/feature/focus/presentation/view/widgets/day_in_chart.dart';

class CustomChart extends StatelessWidget {
  const CustomChart({super.key,required this.height,required this.width});
  final double width;
  final double height;
  @override
  Widget build(BuildContext context) {
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
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      ...List.generate(5, (index)=>Text("${5-index}")),
                    ],
                  ),
                ),
                SizedBox(width: width*0.025,),
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
            SizedBox(
              width: width*0.75,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  ...List.generate(weekDay.length, (index)=>SizedBox(
                      width: width*0.1,
                      child: Text(weekDay[index],textAlign: TextAlign.center,))),
                ],
              ),
            ),
          ],
        ),
        SizedBox(
            width: width*0.75,
            height: height*0.28,
            child:Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                ...List.generate(7, (index)=>CustomDayContainerUsage(width: width))
              ],
            )
        ),
      ],
    );
  }
}
