// ignore_for_file: non_constant_identifier_names

/*
 * Project      : dynamo
 * File         : smart_footer.dart
 * Description  : 
 * Author       : parthapaul
 * Date         : 2024-09-26
 * Version      : 1.0
 * Ticket       : 
 */

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:pull_to_refresh/pull_to_refresh.dart';

getCustomFooter() {
  return CustomFooter(
    builder: (context, mode) {
      Widget body;
      if (mode == LoadStatus.idle) {
        body = Text("pull up load");
      } else if (mode == LoadStatus.loading) {
        body = CupertinoActivityIndicator();
      } else if (mode == LoadStatus.failed) {
        body = Text("Load Failed!Click retry!");
      } else if (mode == LoadStatus.canLoading) {
        body = Text("release to load more");
      } else {
        body = Text("No more Data");
      }
      return Container(height: 55.0, child: Center(child: body));
    },
  );
}
