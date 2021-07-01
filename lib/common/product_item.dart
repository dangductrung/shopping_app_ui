import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:shopping_app/generated/assets.gen.dart';
import 'package:shopping_app/helpers/format_helpers.dart';
import 'package:shopping_app/models/product.dart';
import 'package:shopping_app/pages/details/details_screen.dart';
import 'package:shopping_app/shared/view/network_image.dart';
import 'package:shopping_app/theme/ui_color.dart';
import 'package:shopping_app/theme/ui_text_style.dart';
import 'package:shopping_app/extensions/size_ext.dart';
import 'package:shopping_app/extensions/double_ext.dart';

class ProductItem extends StatelessWidget {
  final Product product;
  final Function() onFollowClicked;

  const ProductItem({this.product, this.onFollowClicked});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        Navigator.of(context).push(MaterialPageRoute(
          builder: (context) => DetailsScreen(
            product: product,
          ),
        ));
      },
      child: Column(
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
                      child: Text(
                        "New",
                        style: UITextStyle.white_14_400,
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
                        style: UITextStyle.mediumBlack_16_w400,
                        maxLines: 2,
                        overflow: TextOverflow.ellipsis,
                      ),
                      SizedBox(
                        height: 4.0.h,
                      ),
                      Row(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text("Giá: ", style: UITextStyle.mediumBlack_16_w400),
                          Text(
                            "${FormatHelper.moneyFormat(product?.price ?? 0)}đ",
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
                          Container(padding: EdgeInsets.symmetric(horizontal: 5.0.w), child: Text('Ngày cập nhật: ${FormatHelper.formatDateTime(product?.createdAt, pattern: "dd/MM/yyyy")}')),
                          const Spacer(),
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
