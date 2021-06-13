import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:shopping_app/generated/assets.gen.dart';
import 'package:shopping_app/helpers/format_helpers.dart';
import 'package:shopping_app/models/product.dart';
import 'package:shopping_app/shared/view/network_image.dart';
import 'package:shopping_app/theme/ui_color.dart';
import 'package:shopping_app/theme/ui_text_style.dart';
import 'package:shopping_app/extensions/size_ext.dart';

class ProductItemWidget extends StatelessWidget {
  final Product product;

  const ProductItemWidget({this.product});

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        border: Border.all(color: UIColor.lightGrayBorder),
        borderRadius: BorderRadius.circular(5.0.h),
        color: UIColor.white,
      ),
      child: Column(
        children: [
          NetworkImageWidget(
            url: product?.image ?? "",
            boxFit: BoxFit.fill,
            width: (Get.width - 32 - 10) / 2,
            height: (Get.width - 32 - 10) / 2,
          ),
          SizedBox(
            height: 6.0.h,
          ),
          Padding(
            padding: EdgeInsets.symmetric(horizontal: 8.0.w),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                SizedBox(
                  height: 60.0.h,
                  child: Text(
                    product?.name,
                    style: UITextStyle.mediumBlack_16_w400,
                    maxLines: 2,
                    overflow: TextOverflow.ellipsis,
                  ),
                ),
                SizedBox(
                  height: 6.0.h,
                ),
                Row(
                  children: [
                    SizedBox(
                      width: 6.0.w,
                    ),
                    getIcon(),
                    SizedBox(
                      width: 6.0.w,
                    ),
                    Text(
                      "${FormatHelper.moneyFormat(product?.price ?? 0)}đ",
                      style: UITextStyle.red_18_w700,
                      textAlign: TextAlign.end,
                    ),
                    const Spacer(),
                    Icon(
                      Icons.favorite,
                      color: UIColor.red,
                      size: 24.0.h,
                    ),
                    SizedBox(
                      width: 6.0.w,
                    ),
                  ],
                ),
                SizedBox(
                  height: 12.0.h,
                ),
                Text(
                  "Ngày cập nhật: ${FormatHelper.formatDateTime(product.createdAt, pattern: "dd/MM/yyyy")}",
                  style: UITextStyle.mediumLightShadeGray_12_w400,
                  textAlign: TextAlign.start,
                ),
                SizedBox(
                  height: 12.0.h,
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget getIcon() {
    if (product.from == "shopee") {
      return Assets.icons.icShopee.image(height: 24.0.h, width: 24.0.h);
    }
    if (product.from == "tiki") {
      return Assets.icons.icTiki.image(height: 24.0.h, width: 24.0.h);
    }
    if (product.from == "lazada") {
      return Assets.icons.icLazada.image(height: 24.0.h, width: 24.0.h);
    }
    return Container();
  }
}
