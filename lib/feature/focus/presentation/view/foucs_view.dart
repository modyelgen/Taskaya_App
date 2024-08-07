import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:taskaya/core/utilites/app_theme/text_style.dart';
import 'package:taskaya/core/utilites/dimensions/responsive_layout.dart';
import 'package:taskaya/core/utilites/widgets/warning_option.dart';
import 'package:taskaya/feature/focus/presentation/manager/focus_bloc.dart';
import 'package:taskaya/feature/focus/presentation/view/widgets/focus_body.dart';

class FocusView extends StatelessWidget {
  const FocusView({super.key});

  @override
  Widget build(BuildContext context) {
    final double height=BasicDimension.screenHeight(context);
    final double width=BasicDimension.screenWidth(context);
    return BlocProvider(
      create: (context)=>FocusBloc()..add(InitialFocusEvent()),
      child: BlocConsumer<FocusBloc,FocusState>(
          builder: (context,state){
            var bloc=BlocProvider.of<FocusBloc>(context);
            if(bloc.isLoading){
              return const Center(child: CircularProgressIndicator());
            }
            else if(bloc.allowDenied){
              return Center(
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text("Open Setting to Allow ",style: CustomTextStyle.fontBold18.copyWith(decoration: TextDecoration.underline)),
                    IconButton(onPressed: (){
                      bloc.openSetting();
                    }, icon: const Icon(Icons.settings,)),
                  ],
                ),
              );
            }
            else{
              return SafeArea(
                child: Scaffold(
                  body: FocusBody(width: width, height: height, bloc: bloc),
                ),
              );
            }
          },
          listener: (context,state)async{
            var bloc=BlocProvider.of<FocusBloc>(context);
            if(state is EnableShowAlertState){
             await showConfirmDialog(context,text: "Allow Taskaya to Get Apps Usage ?").then((value)async{
               if(value){
                await bloc.openSetting();
               }
               else{
                 bloc.add(DenyAllowAppUsageEvent());
               }
             });
            }
          }),
    );
  }
}













