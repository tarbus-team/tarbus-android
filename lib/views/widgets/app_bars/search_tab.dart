import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:tarbus_app/config/app_colors.dart';

const String BACKGROUND_BUS_STOP = 'assets/images/background_bus_stops.png';
const String BACKGROUND_BUS_LINE = 'assets/images/background_bus_lines.png';
const String BACKGROUND_CONNECTION = 'assets/images/background_connections.png';

enum SearchTabType { bus_line, bus_stop, connection }

class SearchTab extends StatelessWidget {
  final String? title;
  final Widget? titleWidget;
  final bool isPrimary;
  final SearchTabType type;
  final Function onTap;

  const SearchTab({
    Key? key,
    this.title,
    required this.onTap,
    this.titleWidget,
    this.isPrimary = false,
    required this.type,
  }) : super(key: key);

  String getBackgroundSrc() {
    switch (type) {
      case SearchTabType.bus_line:
        return BACKGROUND_BUS_LINE;
      case SearchTabType.bus_stop:
        return BACKGROUND_BUS_STOP;
      default:
        return BACKGROUND_CONNECTION;
    }
  }

  @override
  Widget build(BuildContext context) {
    return Card(
      semanticContainer: true,
      clipBehavior: Clip.antiAliasWithSaveLayer,
      child: InkWell(
        onTap: () => onTap(),
        child: Stack(
          children: [
            Positioned.fill(
              child: Image.asset(
                getBackgroundSrc(),
                fit: BoxFit.cover,
                colorBlendMode: !isPrimary ? BlendMode.lighten : null,
                color: !isPrimary ? Colors.white.withOpacity(0.4) : null,
              ),
            ),
            Positioned.fill(
              child: Container(
                color: AppColors.of(context).primaryColor.withOpacity(
                      isPrimary ? 0.55 : 0.25,
                    ),
              ),
            ),
            Positioned(
              bottom: 10,
              left: 10,
              child: titleWidget ??
                  Text(
                    title!,
                    style: TextStyle(
                      fontSize: 25,
                      fontWeight: FontWeight.w900,
                      color: Colors.white,
                    ),
                  ),
            ),
          ],
        ),
      ),
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(10.0),
      ),
      elevation: 5,
    );
  }
}
