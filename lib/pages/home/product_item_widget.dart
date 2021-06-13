import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:shimmer/shimmer.dart';
import 'package:shopping_app/generated/assets.gen.dart';
import 'package:shopping_app/helpers/format_helpers.dart';
import 'package:shopping_app/models/product.dart';
import 'package:shopping_app/shared/view/network_image.dart';
import 'package:shopping_app/theme/ui_color.dart';
import 'package:shopping_app/theme/ui_text_style.dart';
import 'package:shopping_app/extensions/double_ext.dart';

class ProductItemWidget extends StatelessWidget {
  final Product product;

  const ProductItemWidget({this.product});

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        border: Border.all(color: UIColor.lightGrayBorder),
        borderRadius: BorderRadius.circular(5.0),
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
            height: 6.0,
          ),
          Padding(
            padding: EdgeInsets.symmetric(horizontal: 8.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                Container(
                  height: 50,
                  child: Text(
                    product?.name,
                    style: UITextStyle.mediumBlack_16_w400,
                    maxLines: 2,
                    overflow: TextOverflow.ellipsis,
                  ),
                ),
                SizedBox(
                  height: 6.0,
                ),
                Row(
                  children: [
                    SizedBox(
                      width: 6.0,
                    ),
                    getIcon(),
                    SizedBox(
                      width: 6.0,
                    ),
                    Text(
                      "${FormatHelper.moneyFormat(product?.price ?? 0)}đ",
                      style: UITextStyle.red_18_w700,
                      textAlign: TextAlign.end,
                    ),
                    Spacer(),
                    Icon(
                      Icons.favorite,
                      color: UIColor.red,
                    ),
                    SizedBox(
                      width: 6.0,
                    ),
                  ],
                ),
                SizedBox(
                  height: 12.0,
                ),
                Text(
                  "Ngày cập nhật: ${FormatHelper.formatDateTime(product.createdAt, pattern: "dd/MM/yyyy")}",
                  style: UITextStyle.mediumLightShadeGray_12_w400,
                  textAlign: TextAlign.start,
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
      return Assets.icons.icShopee.image(height: 24, width: 24);
    }
    if (product.from == "tiki") {
      return Assets.icons.icTiki.image(height: 24, width: 24);
    }
    if (product.from == "lazada") {
      return Assets.icons.icLazada.image(height: 24, width: 24);
    }
    return Container();
  }
}
