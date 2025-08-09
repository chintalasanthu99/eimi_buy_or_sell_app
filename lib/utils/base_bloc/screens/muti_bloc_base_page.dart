
import 'package:eimi_buy_or_sell_app/utils/app_colors.dart';
import 'package:eimi_buy_or_sell_app/utils/base_bloc/base_bloc.dart';
import 'package:eimi_buy_or_sell_app/utils/base_bloc/base_bloc2.dart';
import 'package:eimi_buy_or_sell_app/utils/base_bloc/base_state.dart';
import 'package:eimi_buy_or_sell_app/utils/core/core.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import 'package:flutter_bloc/flutter_bloc.dart';


class BasePage extends StatefulWidget {
  BasePage({Key? key}) : super(key: key);

  @override
  _BasePageState createState() => _BasePageState();
}

class _BasePageState extends State<BasePage> {
  final BaseBloc _bloc = BaseBloc();
  final BaseBloc2 baseBloc2 = BaseBloc2();

  _BasePageState();

  @override
  void initState() {
    initPlatformState();
    super.initState();
  }

  @override
  void dispose() {
    // TODO: implement dispose
    _bloc.close();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: true,
      body: MultiBlocProvider(
        providers: [
          BlocProvider(
            create: (_) => _bloc,
          ),
          BlocProvider(
            create: (_) => baseBloc2,
          ),
        ],
        child: buildPage1(),
      ),
    );
  }

  Widget buildPage1() {
    return BlocListener<BaseBloc, BaseState>(
      listener: (context, state) async {
        if (state is BaseError) {
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(
                duration: Duration(milliseconds: 2000),
                content: customThemeText(state.errorMessage, 14,
                    fontWeight: FontWeight.w600, color: Colors.white),
                backgroundColor: AppColors.primary),
          );
        } else if (state is DataLoaded) {
          //ADD YOUR FUNCTIONALITY
        }
      },
      child: BlocListener<BaseBloc2, BaseState>(
          listener: (context, state) async {
            if (state is BaseError) {
              ScaffoldMessenger.of(context).showSnackBar(
                SnackBar(
                    duration: Duration(milliseconds: 2000),
                    content: customThemeText(state.errorMessage, 14,
                        fontWeight: FontWeight.w600, color: Colors.white),
                    backgroundColor: AppColors.primary),
              );
            } else if (state is DataLoaded) {
              //ADD YOUR FUNCTIONALITY
            }
          },
          child: BlocBuilder<BaseBloc, BaseState>(
            bloc: _bloc,
            builder: (context, state) {
              return BlocBuilder<BaseBloc2, BaseState>(
                bloc: baseBloc2,
                builder: (context, state) {
                  return Center(
                    child: buildUI(state, context),
                  );
                },
              );
            },
          )),
    );
  }

  Widget buildUI(state, context) {
    return Stack(
      children: <Widget>[
        Container(
          color: AppColors.white,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: <Widget>[
              //APP BAR

              //BODY
              Expanded(
                child: Container(
                  color: AppColors.white,
                  child: SingleChildScrollView(
                    child: Container(
                      margin: const EdgeInsets.symmetric(
                          horizontal: 15, vertical: 10),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.stretch,
                        children: <Widget>[
                          VerticalSpace(
                            height: deviceHeight(context) * 0.10,
                          ),
                          Column(
                            children: [
                              //BODY WIDGETS
                            ],
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
              ),
              //BOTTOM WIDGETS
            ],
          ),
        ),
      ],
    );
  }

  //UI WIDGETS   -> We have to use custom components whatever we have in project.

  // void _showToastBar(String message) {
  //   Fluttertoast.showToast(
  //       msg: message,
  //       toastLength: Toast.LENGTH_LONG,
  //       gravity: ToastGravity.CENTER,
  //       timeInSecForIosWeb: 6,
  //       backgroundColor: AppColors.primary,
  //       textColor: Colors.white,
  //       fontSize: 16.0);
  // }

  void _showSnackBar(String message) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: customThemeText(message, 14,
            textAlign: TextAlign.center,
            fontWeight: FontWeight.w600,
            color: Colors.white),
        backgroundColor: AppColors.primary,
        // behavior: SnackBarBehavior.floating,
        // elevation: 1.0,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(0.0),
        ),
      ),
    );
  }

  //FUNCTIONALITY
  Future<void> onRefresh() async {
    bool data = false;
    // WRITE YOUR REFRESH LOGIC
  }
  Future<void> initPlatformState() async {
    if (!mounted) return;
  }

//API CALLS
}
