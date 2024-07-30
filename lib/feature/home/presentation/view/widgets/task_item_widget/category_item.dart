import 'package:flutter/cupertino.dart';
import 'package:taskaya/core/utilites/app_theme/text_style.dart';
import 'package:taskaya/core/utilites/functions/get_related_color.dart';
import 'package:taskaya/feature/home/data/models/task_model.dart';
class CategoryItem extends StatelessWidget {
  const CategoryItem({super.key,required this.height,required this.width,this.model});
  final double width;
  final double height;
  final CategoryModel? model;
  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Container(
          width: width*0.175,
          height: height*0.075,
          decoration: BoxDecoration(
            color: model?.color??const Color(0xff80FFD1),
            borderRadius: BorderRadius.circular(4),
          ),
          child: Icon(model?.icon??CupertinoIcons.add,color: getRelatedColor(model?.color??const Color(0xff80FFD1),),size: width*0.1,),
        ),
        SizedBox(height: height*0.01,),
        SizedBox(
            width: width*0.175,
            child: Text(model?.name??"Create New",style: CustomTextStyle.fontBoldWhite16.copyWith(fontSize: 14,),overflow: TextOverflow.ellipsis,maxLines: 2,textAlign: TextAlign.center,)),
      ],
    );
  }
}