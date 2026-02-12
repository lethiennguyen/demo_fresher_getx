import 'dart:async';

import 'package:demo_fresher_getx/core/base/base.src.dart';
import 'package:demo_fresher_getx/generated/locales.g.dart';
import 'package:demo_fresher_getx/lib.dart';
import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';
import 'package:pull_to_refresh/pull_to_refresh.dart';

import '../../domain/domain.src.dart';
import '../../domain/use_case/use_case.src.dart';

class DetailProductController extends BaseGetxController {
  DetailProductUseCase useCase;

  DetailProductController(this.useCase);

  TextEditingController inputNameCtrl = TextEditingController();
  TextEditingController inputCodeCtrl = TextEditingController();
  TextEditingController inputPriceCtrl = TextEditingController();
  TextEditingController inputStockCtrl = TextEditingController();
  TextEditingController inputCategoryCtrl = TextEditingController();

  Rx<FocusNode> fcsName = FocusNode().obs;
  Rx<FocusNode> fcsCode = FocusNode().obs;
  Rx<FocusNode> fcsPrice = FocusNode().obs;
  Rx<FocusNode> fcsStock = FocusNode().obs;
  Rx<FocusNode> fcsCategory = FocusNode().obs;
}
