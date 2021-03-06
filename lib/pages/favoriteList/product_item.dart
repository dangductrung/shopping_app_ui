import 'package:auto_size_text/auto_size_text.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:shopping_app/generated/assets.gen.dart';
import 'package:shopping_app/helpers/format_helpers.dart';
import 'package:shopping_app/models/product.dart';
import 'package:shopping_app/shared/view/network_image.dart';
import 'package:shopping_app/theme/ui_color.dart';
import 'package:shopping_app/theme/ui_text_style.dart';
import 'package:shopping_app/extensions/size_ext.dart';
import 'package:shopping_app/extensions/date_time_ext.dart';

class ProductItem extends StatelessWidget {
  final Product product;
  final Function() onFollowClicked;
  final double delta;

  const ProductItem({this.product, this.onFollowClicked, this.delta});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Row(
          children: [
            Stack(
              children: [
                NetworkImageWidget(
                  url: product?.image ?? "",
                  height: 90.0.h,
                  width: 90.0.h,
                ),
                if (product?.isNew ?? false)
                  Container(
                    color: UIColor.red,
                    padding: EdgeInsets.only(right: 4.0.w),
                    child: Text(
                      "New",
                      style: UITextStyle.white_14_400,
                    ),
                  ),
                if (delta != null)
                  Container(
                    height: 28.0.h,
                    width: 50.0.w,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.only(topRight: Radius.circular(14.0.h), bottomRight: Radius.circular(14.0.h)),
                      color: UIColor.red,
                    ),
                    padding: EdgeInsets.only(right: 4.0.w),
                    child: Center(
                      child: AutoSizeText(
                        "$delta%",
                        style: UITextStyle.white_14_400,
                      ),
                    ),
                  ),
              ],
            ),
            Expanded(
              child: Container(
                padding: EdgeInsets.symmetric(horizontal: 8.0.w, vertical: 8.0.h),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      product?.name ?? "",
                      style: UITextStyle.mediumBlack_14_w400,
                      maxLines: 2,
                      overflow: TextOverflow.ellipsis,
                    ),
                    SizedBox(
                      height: 4.0.h,
                    ),
                    Row(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text("Gi??: ", style: UITextStyle.mediumBlack_14_w400),
                        Text(
                          "${FormatHelper.moneyFormat(product?.price ?? 0)}??",
                          style: UITextStyle.red_16_w700,
                        ),
                      ],
                    ),
                    SizedBox(
                      height: 4.0.h,
                    ),
                    Row(
                      children: [
                        getIcon(),
                        Expanded(
                          child: Container(
                            padding: EdgeInsets.symmetric(horizontal: 5.0.w),
                            child: Text(
                              'Ng??y c???p nh???t: ${FormatHelper.formatDateTime(product?.createdAt, pattern: "dd/MM/yyyy")}',
                              style: UITextStyle.mediumBlack_14_w400,
                            ),
                          ),
                        ),
                        GestureDetector(
                          behavior: HitTestBehavior.translucent,
                          onTap: () {
                            if (onFollowClicked != null) {
                              onFollowClicked();
                            }
                          },
                          child: Icon(
                            Icons.favorite,
                            color: product?.isFollow ?? false ? Colors.red : Colors.grey,
                            size: 24.0.h,
                          ),
                        ),
                      ],
                    )
                  ],
                ),
              ),
            ),
          ],
        ),
        SizedBox(
          height: 4.0.h,
        ),
        Container(
          height: 1.0.h,
          width: double.infinity,
          color: UIColor.lightBlueBg,
        )
      ],
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
