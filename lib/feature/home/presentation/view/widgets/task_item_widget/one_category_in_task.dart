import 'package:flutter/material.dart';
import 'package:taskaya/core/utilites/app_theme/text_style.dart';
import 'package:taskaya/core/utilites/functions/get_related_color.dart';
import 'package:taskaya/core/utilites/widgets/custom_big_button.dart';
import 'package:taskaya/feature/home/data/models/task_model.dart';

class OneCategoryInTask extends StatelessWidget {
  const OneCategoryInTask({
    super.key,
    required this.model,
    required this.width,
    this.enableWidth=false,
  });

  final CategoryModel model;
  final double width;
  final bool enableWidth;

  @override
  Widget build(BuildContext context) {
    return CustomBigButton(
      altWidth: enableWidth?width*0.3:null,
      color: model.color,
      borderRadius: 4,
      altWidget:  Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Icon(model.icon,color: getRelatedColor(model.color!),),
          const SizedBox(width: 4,),
          SizedBox(
            width: width*0.175,
            child: Text(model.name!,style: CustomTextStyle.fontBoldWhite16.copyWith(fontSize: 14,overflow: TextOverflow.ellipsis),maxLines: 1,),
          ),
        ],
      ),);
  }
}