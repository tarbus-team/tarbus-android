import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:tarbus2021/app/app_colors.dart';
import 'package:tarbus2021/app/app_consts.dart';
import 'package:tarbus2021/app/app_dimens.dart';
import 'package:tarbus2021/app/app_string.dart';
import 'package:tarbus2021/presentation/custom_widgets/appbar_title.dart';
import 'package:tarbus2021/utils/web_page_utils.dart';

class AboutUsView extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Theme.of(context).scaffoldBackgroundColor,
        title: Row(
          children: [AppBarTitle(title: AppString.titleAboutApplication)],
        ),
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: EdgeInsets.all(AppDimens.margin_view_horizontally),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              Padding(
                padding: EdgeInsets.symmetric(vertical: 30),
                child: SvgPicture.asset(
                  'assets/logo_tarbus_header.svg',
                  width: 55,
                  height: 55,
                  color: AppColors.instance(context).homeLinkColor,
                ),
              ),
              Text('${AppString.labelAboutApp}\n', style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold)),
              Text(
                '${AppString.textAppDescription}\n',
                style: TextStyle(
                  fontWeight: FontWeight.normal,
                ),
              ),
              Text('${AppString.labelAboutUs}\n', style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold)),
              Text(
                '${AppString.textAboutUs} \n',
                style: TextStyle(
                  fontWeight: FontWeight.normal,
                ),
              ),
              Text('${AppString.labelContactWithDeveloper}\n', style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold)),
              Text(
                '${AppString.textDeveloperDesc} \n',
                style: TextStyle(
                  fontWeight: FontWeight.normal,
                ),
              ),
              SizedBox(
                height: 60.0,
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    InkWell(
                      onTap: () {
                        WebPageUtils.openURL(AppConsts.FACEBOOK_DEVELOPER);
                      },
                      child: ClipRRect(
                        borderRadius: BorderRadius.circular(10.0),
                        child: Image.asset('assets/icons/social_fb.png'),
                      ),
                    ),
                    InkWell(
                      onTap: () {
                        WebPageUtils.openURL(AppConsts.LINKEDIN_DEVELOPER);
                      },
                      child: ClipRRect(
                        borderRadius: BorderRadius.circular(10.0),
                        child: Image.asset('assets/icons/social_ln.png'),
                      ),
                    ),
                    InkWell(
                      onTap: () {
                        WebPageUtils.openURL('mailto:${AppConsts.MAIL_DEVELOPER}');
                      },
                      child: ClipRRect(
                        borderRadius: BorderRadius.circular(10.0),
                        child: Image.asset('assets/icons/social_mail.png'),
                      ),
                    ),
                    InkWell(
                      onTap: () {
                        WebPageUtils.openURL(AppConsts.GITHUB_DEVELOPER);
                      },
                      child: ClipRRect(
                        borderRadius: BorderRadius.circular(10.0),
                        child: Image.asset('assets/icons/social_gh.png'),
                      ),
                    ),
                  ],
                ),
              ),
              SizedBox(
                height: 50,
              ),
              Text('${AppString.labelCooperation}\n', style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold)),
              Text(
                '${AppString.textCooperationDesc} \n',
                style: TextStyle(
                  fontWeight: FontWeight.normal,
                ),
              ),
              SizedBox(
                height: 60.0,
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    InkWell(
                      onTap: () {
                        WebPageUtils.openURL(AppConsts.FACEBOOK_TARBUS);
                      },
                      child: ClipRRect(
                        borderRadius: BorderRadius.circular(10.0),
                        child: Image.asset('assets/icons/social_fb.png'),
                      ),
                    ),
                    InkWell(
                      onTap: () {
                        WebPageUtils.openURL('mailto:${AppConsts.MAIL_TARBUS}');
                      },
                      child: ClipRRect(
                        borderRadius: BorderRadius.circular(10.0),
                        child: Image.asset('assets/icons/social_mail.png'),
                      ),
                    ),
                    InkWell(
                      onTap: () {
                        WebPageUtils.openURL(AppConsts.GITHUB_TARBUS);
                      },
                      child: ClipRRect(
                        borderRadius: BorderRadius.circular(10.0),
                        child: Image.asset('assets/icons/social_gh.png'),
                      ),
                    ),
                  ],
                ),
              ),
              SizedBox(
                height: 100,
              ),
            ],
          ),
        ),
      ),
    );
  }
}
