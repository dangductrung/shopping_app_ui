import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:shopping_app/helpers/format_helpers.dart';
import 'package:shopping_app/models/product.dart';
import 'package:shopping_app/pages/history_prd/history_prd_view_model.dart';
import 'package:shopping_app/shared/base/base_view_state.dart';
import 'package:shopping_app/theme/ui_color.dart';
import 'package:shopping_app/theme/ui_text_style.dart';
import 'package:shopping_app/extensions/size_ext.dart';

class HistoryPrdPage extends StatefulWidget {
  final Product product;

  const HistoryPrdPage({this.product});

  @override
  _HistoryPrdPageState createState() => _HistoryPrdPageState();
}

class _HistoryPrdPageState extends BaseViewState<HistoryPrdPage, HistoryPrdViewModel> {
  @override
  void loadArguments() {
    viewModel?.product = widget?.product;
    super.loadArguments();
  }

  @override
  HistoryPrdViewModel createViewModel() => HistoryPrdViewModel();

  @override
  Widget build(BuildContext context) {
    super.build(context);

    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        flexibleSpace: Container(
          padding: EdgeInsets.fromLTRB(5.0.w, 14.0.h, 0, 0),
          decoration: const BoxDecoration(
            gradient: LinearGradient(
              begin: Alignment.topRight,
              end: Alignment.bottomLeft,
              colors: [Color(0xffF12711), Color(0xffF5AF19)],
            ),
          ),
        ),
        title: Text(
          "Lịch sử giá",
          style: UITextStyle.white_18_w400,
        ),
      ),
      body: Obx(
        () => Padding(
          padding: EdgeInsets.symmetric(horizontal: 8.0.w),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              SizedBox(
                height: 12.0.h,
              ),
              Row(
                children: [
                  Expanded(
                    flex: 3,
                    child: Row(
                      children: [
                        SizedBox(
                          width: 8.0.w,
                        ),
                        Expanded(
                          child: Text(
                            "Thời gian",
                            style: UITextStyle.mediumBlack_16_w700,
                            textAlign: TextAlign.left,
                          ),
                        ),
                      ],
                    ),
                  ),
                  Expanded(
                    flex: 4,
                    child: Row(
                      children: [
                        SizedBox(
                          width: 8.0.w,
                        ),
                        Expanded(
                          child: Text(
                            "Giá",
                            style: UITextStyle.mediumBlack_16_w700,
                            textAlign: TextAlign.left,
                          ),
                        ),
                      ],
                    ),
                  ),
                  Expanded(
                    flex: 2,
                    child: Row(
                      children: [
                        Expanded(
                          child: Text(
                            "+/- %",
                            style: UITextStyle.mediumBlack_16_w700,
                            textAlign: TextAlign.right,
                          ),
                        ),
                        SizedBox(
                          width: 8.0.w,
                        )
                      ],
                    ),
                  ),
                ],
              ),
              SizedBox(
                height: 8.0.h,
              ),
              Expanded(
                child: ListView.builder(
                  shrinkWrap: true,
                  itemCount: viewModel.history?.length ?? 0,
                  itemBuilder: (context, index) => Column(
                    children: [
                      SizedBox(
                        height: 8.0.h,
                      ),
                      Row(
                        children: [
                          Expanded(
                            flex: 3,
                            child: Row(
                              children: [
                                SizedBox(
                                  width: 8.0.w,
                                ),
                                Expanded(
                                  child: Text(
                                    FormatHelper.formatDateTime(viewModel.history[index].createdAt, pattern: "dd/MM/yyyy"),
                                    style: UITextStyle.mediumBlack_16_w400,
                                  ),
                                ),
                              ],
                            ),
                          ),
                          Expanded(
                            flex: 4,
                            child: Row(
                              children: [
                                SizedBox(
                                  width: 8.0.w,
                                ),
                                Expanded(
                                  child: Text(
                                    "${FormatHelper.moneyFormat(viewModel.history[index].price)} đ",
                                    style: UITextStyle.mediumBlack_16_w400,
                                  ),
                                ),
                              ],
                            ),
                          ),
                          Expanded(
                            flex: 2,
                            child: Row(
                              children: [
                                Expanded(
                                  child: Text(
                                    viewModel.getDelta(index),
                                    style: viewModel.getColor(index),
                                    textAlign: TextAlign.right,
                                  ),
                                ),
                                SizedBox(
                                  width: 8.0.w,
                                )
                              ],
                            ),
                          ),
                        ],
                      ),
                      SizedBox(
                        height: 8.0.h,
                      ),
                    ],
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
