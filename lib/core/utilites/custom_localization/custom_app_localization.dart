import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class CustomAppLocalization{
  final Locale?locale;
  CustomAppLocalization({required this.locale});

  static CustomAppLocalization? of(BuildContext context){
    return Localizations.of(context,CustomAppLocalization);
  }
  static const LocalizationsDelegate<CustomAppLocalization> delegate= CustomAppLocalizationDelegate();

  late Map<String,String> _localizedString;
  Future loadJsonLang()async{
    String jsonString=await rootBundle.loadString('assets/languages/${locale!.languageCode}.json');
    Map<String,dynamic>jsonMap=json.decode(jsonString);
    _localizedString=jsonMap.map((key, value) => MapEntry(key, value.toString()));
  }
  String translateText (String key)=>_localizedString[key]??"";
}

class CustomAppLocalizationDelegate extends LocalizationsDelegate<CustomAppLocalization>{
  const CustomAppLocalizationDelegate();
  @override
  bool isSupported(Locale locale) {
    return ['en','ar'].contains(locale.languageCode);
  }

  @override
  Future<CustomAppLocalization> load(Locale locale) async{
    CustomAppLocalization customAppLocalization=CustomAppLocalization(locale: locale);
    await customAppLocalization.loadJsonLang();
    return customAppLocalization;
  }

  @override
  bool shouldReload(covariant LocalizationsDelegate<CustomAppLocalization> old)=>false;

}
extension TranslateX on String {
  String tr (BuildContext context)=>CustomAppLocalization.of(context)!.translateText(this);
}