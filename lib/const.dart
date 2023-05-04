import 'dart:math';

import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';

const apiKey = 'AIzaSyBLc1ebz3sar3ni4ixO6q6HyUuUIs2sL4A';
const projectId = 'furniture-company-2e0ad';

class AdjustableScrollController extends ScrollController {
  AdjustableScrollController([int extraScrollSpeed = 40]) {
    super.addListener(() {
      ScrollDirection scrollDirection = super.position.userScrollDirection;
      if (scrollDirection != ScrollDirection.idle) {
        double scrollEnd = super.offset +
            (scrollDirection == ScrollDirection.reverse
                ? extraScrollSpeed
                : -extraScrollSpeed);
        scrollEnd = min(super.position.maxScrollExtent,
            max(super.position.minScrollExtent, scrollEnd));
        jumpTo(scrollEnd);
      }
    });
  }
}

