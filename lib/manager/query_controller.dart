import 'package:flutter/material.dart';

abstract class _IQueryController {
  getQuery();
}

class QueryController extends ChangeNotifier implements _IQueryController {
  @override
  Future<void> getQuery() async {}
}
