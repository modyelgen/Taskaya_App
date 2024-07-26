import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:taskaya/core/utilites/app_theme/colors.dart';
import 'package:taskaya/core/utilites/app_theme/text_style.dart';
import 'package:taskaya/core/utilites/custom_localization/custom_app_localization.dart';

class OptionPickImage extends StatelessWidget {
  const OptionPickImage({
    super.key,
    required this.width,
    required this.height,
    required this.deleteImage,
    required this.pickImage
  });

  final double width;
  final double height;
  final void Function()deleteImage;
  final void Function({required ImageSource source})pickImage;

  @override
  Widget build(BuildContext context) {
    return Container(
      height: height*0.2,
      padding: EdgeInsets.symmetric(horizontal: width*0.05,vertical: height*0.015),
      decoration: const BoxDecoration(
          borderRadius: BorderRadius.only(topLeft: Radius.circular(12),topRight: Radius.circular(12))
      ),
      child: Column(
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text("profilePic".tr(context),style: CustomTextStyle.fontBold16,),
              IconButton(onPressed:deleteImage, icon:  const Icon(CupertinoIcons.delete_simple))
            ],
          ),
          SizedBox(height: height*0.015),
          Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Column(
                children: [
                  Container(
                    width:width*0.125,
                    decoration: BoxDecoration(
                      shape:BoxShape.circle,
                      border: Border.all(color: purpleColor),
                    ),
                    child: IconButton(onPressed:(){pickImage(source: ImageSource.camera);},icon: Icon(CupertinoIcons.camera,color: purpleColor,)),
                  ),
                  SizedBox(
                    height: height*0.015,
                  ),
                  Text("camera".tr(context),style: CustomTextStyle.fontNormal12,),
                ],
              ),
              SizedBox(width: width*0.05,),
              Column(
                children: [
                  Container(
                    width:width*0.125,
                    decoration: BoxDecoration(
                      shape:BoxShape.circle,
                      border: Border.all(color: purpleColor),
                    ),
                    child: IconButton(onPressed: (){
                      pickImage(source: ImageSource.gallery);
                    }, icon: Icon(CupertinoIcons.photo,color: purpleColor,)),
                  ),
                  SizedBox(
                    height: height*0.015,
                  ),
                  Text("gallery".tr(context),style: CustomTextStyle.fontNormal12,),
                ],
              ),
            ],
          ),
        ],
      ),
    );
  }
}