import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:taskaya/core/utilites/app_theme/colors.dart';
class CustomTextFormField extends StatelessWidget {
  const CustomTextFormField({super.key,this.label,this.suffix,this.prefix,this.controller,
    this.border,this.borderWidth,this.type,this.enablePassword,this.enableOutLine=true,this.labelFontSize,
    this.floatingLabelBehavior,this.onSaved,this.onChanged,this.validator,this.enableEnabledBorder=true,this.enableFocusBorder=true,this.enableNormalBorder=true,
    this.maxLength,this.inputFormatters,this.autoFillList,this.expand=false,this.minLine,this.onFiledSubmitted,this.borderColor,this.focusNode,this.style,this.initialValue,this.enable=true,this.align,this.autoFocus,this.maxLines,this.fillColor,this.filled});
  final String?label;
  final Widget?suffix ;
  final Widget?prefix;
  final double?border;
  final double?borderWidth;
  final TextInputType?type;
  final bool? enablePassword;
  final bool enableOutLine;
  final Color? borderColor;
  final double? labelFontSize;
  final FloatingLabelBehavior? floatingLabelBehavior;
  final TextEditingController ?controller;
  final void Function(String?)? onSaved;
  final void Function(String?)? onFiledSubmitted;
  final void Function(String)? onChanged;
  final String? Function(String?)? validator;
  final int? maxLength;
  final List<TextInputFormatter>? inputFormatters;
  final TextStyle? style;
  final bool enableNormalBorder;
  final bool enableFocusBorder;
  final bool enableEnabledBorder;
  final TextAlign? align;
  final bool?autoFocus;
  final int?maxLines;
  final Color?fillColor;
  final bool?filled;
  final bool? enable;
  final bool expand;
  final String?initialValue;
  final FocusNode?focusNode;
  final int?minLine;
  final Iterable<String>?autoFillList;
  @override
  Widget build(BuildContext context) {
    return TextFormField(
      minLines: minLine,
      autofillHints: autoFillList,
      expands: expand,
      onFieldSubmitted: onFiledSubmitted,
      focusNode:focusNode ,
      initialValue: initialValue,
      onSaved: onSaved,
      onChanged: onChanged,
      enabled: enable,
      maxLength: maxLength,
      autofocus: autoFocus??false,
      inputFormatters: inputFormatters,
      style: style,
      textAlign: align??TextAlign.start,
      validator: validator,
      controller:controller,
      keyboardType: type??TextInputType.text,
      maxLines: maxLines??1,
      obscureText: enablePassword==true ? true : false,
      obscuringCharacter: '*',
      decoration: InputDecoration(
        filled: filled??false,
        fillColor: fillColor,
        floatingLabelBehavior: floatingLabelBehavior??FloatingLabelBehavior.never,
        labelText: label,
        prefixIcon:prefix,
        suffixIcon: suffix,
        border:enableNormalBorder? buildOutlineInputBorder(borderRadius: border,borderWidth: borderWidth):InputBorder.none,
        focusedBorder: enableFocusBorder? buildOutlineInputBorder(colorBorder:enableOutLine?borderColor:fillColor ,borderRadius: border,borderWidth: borderWidth):InputBorder.none,
        enabledBorder: enableEnabledBorder? buildOutlineInputBorder(colorBorder:enableOutLine? borderColor:fillColor,borderRadius: border,borderWidth: borderWidth):InputBorder.none,
        labelStyle: TextStyle(color: const Color(0xffB4ADAD),fontSize: labelFontSize??14,),
      ),
    );
  }

  OutlineInputBorder buildOutlineInputBorder({Color? colorBorder,double?borderRadius,double?borderWidth}) {
    return  OutlineInputBorder(
        borderRadius:  BorderRadius.only(
          topLeft: Radius.circular(borderRadius??20),
          topRight: Radius.circular(borderRadius??20),
          bottomLeft: Radius.circular(borderRadius??20),
          bottomRight: Radius.circular(borderRadius??20),
        ),
        borderSide: BorderSide(color: colorBorder??customBorderColor,width: borderWidth??2));
  }
}