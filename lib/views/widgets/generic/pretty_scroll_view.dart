import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:tarbus_app/config/app_colors.dart';
import 'package:tarbus_app/views/widgets/generic/no_glov_behaviour.dart';

class PrettyScrollView extends StatefulWidget {
  final String title;
  final String? subTitle;
  final Widget body;

  const PrettyScrollView(
      {Key? key, required this.title, this.subTitle, required this.body})
      : super(key: key);

  @override
  State<StatefulWidget> createState() => _PrettyScrollView();
}

class _PrettyScrollView extends State<PrettyScrollView> {
  ScrollController scrollController = ScrollController();
  bool _visible = false;

  @override
  void initState() {
    super.initState();
    scrollController.addListener(() {
      setState(() {
        if (scrollController.offset > 42) {
          _visible = true;
        } else if (_visible) {
          _visible = false;
        }
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    TextStyle widgetStyle =
        CupertinoTheme.of(context).textTheme.navLargeTitleTextStyle;

    Widget _buildTitle(double bigSize, double smallSize) {
      return RichText(
        text: TextSpan(
          text: widget.title,
          style: widgetStyle.copyWith(
            fontSize: bigSize,
          ),
          children: [
            if (widget.subTitle != null)
              TextSpan(
                text: ' ${widget.subTitle}',
                style: widgetStyle.copyWith(
                  fontSize: smallSize,
                  color: AppColors.of(context).primaryColor,
                ),
              )
          ],
        ),
      );
    }

    return NestedScrollView(
      controller: scrollController,
      headerSliverBuilder: (BuildContext context, bool innerBoxIsScrolled) {
        return <Widget>[
          SliverOverlapAbsorber(
            handle: NestedScrollView.sliverOverlapAbsorberHandleFor(context),
            sliver: SliverAppBar(
              expandedHeight: 120.0,
              floating: false,
              pinned: true,
              elevation: 1,
              forceElevated: _visible ? true : false,
              backgroundColor: Theme.of(context).scaffoldBackgroundColor,
              titleSpacing: 0,
              title: AppBar(
                title: AnimatedOpacity(
                    opacity: _visible ? 1.0 : 0.0,
                    duration: const Duration(milliseconds: 150),
                    // The green box must be a child of the AnimatedOpacity widget.
                    child: _buildTitle(20, 10)),
                backgroundColor: _visible
                    ? Colors.white
                    : Theme.of(context).scaffoldBackgroundColor,
              ),
              flexibleSpace: FlexibleSpaceBar(
                titlePadding: EdgeInsetsDirectional.only(
                  bottom: 16.0,
                  start: 12.0,
                ),
                title: Row(
                  crossAxisAlignment: CrossAxisAlignment.end,
                  children: [
                    _buildTitle(22, 8),
                  ],
                ),
              ),
            ),
          ),
        ];
      },
      body: Builder(builder: (context) {
        return ScrollConfiguration(
          behavior: NoGlowBehaviour(),
          child: CustomScrollView(
            slivers: <Widget>[
              SliverOverlapInjector(
                handle:
                    NestedScrollView.sliverOverlapAbsorberHandleFor(context),
              ),
              SliverToBoxAdapter(
                child: widget.body,
              ),
            ],
          ),
        );
      }),
    );
  }
}
