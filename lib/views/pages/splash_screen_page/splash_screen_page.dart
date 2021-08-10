import 'package:auto_route/auto_route.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/svg.dart';
import 'package:tarbus_app/bloc/app_cubit/app_cubit.dart';
import 'package:tarbus_app/bloc/init_app_cubit/init_app_cubit.dart';
import 'package:tarbus_app/config/app_colors.dart';
import 'package:tarbus_app/shared/router/routes.gr.dart';
import 'package:tarbus_app/views/widgets/generic/message_spinner.dart';

class SplashScreenPage extends StatefulWidget {
  @override
  State<StatefulWidget> createState() => _SplashScreenPage();
}

class _SplashScreenPage extends State<SplashScreenPage> {
  @override
  void initState() {
    context.read<InitAppCubit>().initApp(context);
    super.initState();
  }

  Widget _getSpinnerWidget(InitAppState state) {
    if (state is InitStarted) {
      return _buildInitialSpinner('Trwa sprawdzanie rozkładu jazdy');
    } else if (state is InitLoading) {
      return _buildInitialSpinner('Trwa sprawdzanie rozkładu jazdy');
    } else if (state is UpdatingSchedule) {
      return _buildInitialSpinner('Aktualizowanie rozkładu');
    } else if (state is InitFailure) {
      return Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Text(
            state.error,
            textAlign: TextAlign.center,
            style: Theme.of(context).textTheme.headline3!.copyWith(
                  color: Colors.red,
                ),
          ),
          SizedBox(
            height: 25,
          ),
          ElevatedButton(
            onPressed: () {
              context.read<InitAppCubit>().initApp(context);
            },
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Icon(Icons.refresh),
                SizedBox(
                  width: 10,
                ),
                Text('Spróbuj ponownie'),
              ],
            ),
          ),
          ElevatedButton(
            style: ButtonStyle(
              backgroundColor: MaterialStateProperty.all(Colors.white),
              elevation: MaterialStateProperty.all(0),
              shape: MaterialStateProperty.all(
                RoundedRectangleBorder(
                  side: BorderSide(
                    width: 1,
                    color: Colors.grey.shade400,
                  ),
                  borderRadius: BorderRadius.circular(5),
                ),
              ),
            ),
            onPressed: () async {
              await context.read<AppCubit>().initApp(AppNetworkStatus.OFFLINE);
              context.router.replace(AppRoute());
            },
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Text(
                  'Uruchom w trybie offline',
                  style: TextStyle(color: Colors.black),
                ),
              ],
            ),
          ),
        ],
      );
    } else {
      // (state is WeatherError)
      return _buildInitialSpinner('Co w innym przypadku');
    }
  }

  Widget _buildInitialSpinner(String message) {
    return MessageSpinner(
      message: message,
    );
  }

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<InitAppCubit, InitAppState>(
      listener: (context, state) {
        if (state is FirstAppRun) {
          context.router.replace(FirstConfigRoute());
        }
        if (state is InitSuccess) {
          context.read<AppCubit>().initApp(AppNetworkStatus.ONLINE);
          context.router.replace(AppRoute());
        }
      },
      builder: (context, state) {
        return Scaffold(
          body: Center(
            child: Stack(
              children: [
                Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    SvgPicture.asset(
                      'assets/images/logo.svg',
                      color: AppColors.of(context).primaryColor,
                      width: MediaQuery.of(context).size.width * 0.85,
                    ),
                    if (!(state is UpdatingSchedule || state is InitFailure))
                      TextButton(
                        onPressed: () {},
                        child: Text("Uruchom w trybie offline".toUpperCase(),
                            style: Theme.of(context)
                                .textTheme
                                .headline1!
                                .copyWith(
                                    color: AppColors.of(context).primaryColor,
                                    fontSize: 15.0,
                                    fontWeight: FontWeight.w800)),
                      ),
                  ],
                ),
                Positioned(
                  left: 0,
                  right: 0,
                  bottom: 20,
                  child: Column(
                    children: [
                      _getSpinnerWidget(state),
                    ],
                  ),
                ),
              ],
            ),
          ),
        );
      },
    );
  }
}
