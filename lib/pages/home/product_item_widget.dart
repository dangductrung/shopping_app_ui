import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:shopping_app/generated/assets.gen.dart';
import 'package:shopping_app/helpers/format_helpers.dart';
import 'package:shopping_app/models/product.dart';
import 'package:shopping_app/pages/details/details_screen.dart';
import 'package:shopping_app/shared/view/network_image.dart';
import 'package:shopping_app/theme/ui_color.dart';
import 'package:shopping_app/theme/ui_text_style.dart';
import 'package:shopping_app/extensions/size_ext.dart';
import 'package:shopping_app/extensions/date_time_ext.dart';

class ProductItemWidget extends StatelessWidget {
  final Product product;
  final Function() onFollowClicked;

  const ProductItemWidget({this.product, this.onFollowClicked});

  @override
  Widget build(BuildContext context) {
    final double height = 280.0.h;
    return GestureDetector(
      behavior: HitTestBehavior.translucent,
      onTap: () {
        Get.to(
          DetailsScreen(
            product: product,
          ),
          preventDuplicates: false,
        );
      },
      child: Container(
        height: height,
        decoration: BoxDecoration(
          border: Border.all(color: UIColor.lightGrayBorder),
          borderRadius: BorderRadius.circular(5.0.h),
          color: UIColor.white,
        ),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            SizedBox(
              height: 150.0.h,
              child: NetworkImageWidget(
                url: product?.image ?? "",
                boxFit: BoxFit.fill,
                width: (Get.width - 32 - 10) / 2,
                height: 150.0.h,
              ),
            ),
            SizedBox(
              height: 6.0.h,
            ),
            Expanded(
              child: Padding(
                padding: EdgeInsets.symmetric(horizontal: 8.0.w),
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      product?.name,
                      style: UITextStyle.mediumBlack_14_w400,
                      maxLines: 2,
                      overflow: TextOverflow.ellipsis,
                      textAlign: TextAlign.start,
                    ),
                    SizedBox(
                      height: 3.0.h,
                    ),
                    Row(
                      crossAxisAlignment: CrossAxisAlignment.end,
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        getIcon(),
                        Expanded(
                          child: Text(
                            "${FormatHelper.moneyFormat(product?.price ?? 0)}đ",
                            style: UITextStyle.red_18_w700,
                            textAlign: TextAlign.end,
                          ),
                        ),
                      ],
                    ),
                    SizedBox(
                      height: 4.0.h,
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.end,
                      children: [
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
                    ),
                    SizedBox(
                      height: 4.0.h,
                    ),
                    Expanded(
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.end,
                        children: [
                          Text(
                            product.createdAt.timeAgo(),
                            style: UITextStyle.mediumLightShadeGray_12_w400,
                            textAlign: TextAlign.start,
                          ),
                        ],
                      ),
                    ),
                    SizedBox(
                      height: 6.0.h,
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
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
