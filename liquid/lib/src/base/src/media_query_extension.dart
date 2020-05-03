import 'package:flutter/widgets.dart';

// if (onXL != null && width >= 1200) return onXL(context);
// if (onLG != null && width >= 992) return onLG(context);
// if (onMD != null && width >= 768) return onMD(context);
// if (onSM != null && width >= 576) return onSM(context);

extension MediaQueryDataExtension on MediaQueryData {
  bool get isXS => size.width < 576.0;
  bool get isSM => size.width >= 576.0 && size.width < 768.0;
  bool get isMD => size.width >= 768.0 && size.width < 992.0;
  bool get isLG => size.width >= 992.0 && size.width < 1200.0;
  bool get isXL => size.width > 1200.0;
}
