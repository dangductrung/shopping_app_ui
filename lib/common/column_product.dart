import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:shopping_app/common/product_thumb.dart';

class TwoProducts extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final height = MediaQuery.of(context).size.height / 100;
    final width = MediaQuery.of(context).size.width / 100;
    var a = [
      ProductThumbInfo('Máy xay đa năng PHILIPS HL1643 (Hàng Nhập Khẩu)', '1.685.000', '53%', 'assets/imgs/1.jpeg'),
      ProductThumbInfo('Máy Xay Sinh Tố USB Lock&Lock EJM221 (70W - 500ml) - Hàng Chính Hãng', '829.000', '10%', 'assets/imgs/2.jpeg'),
      ProductThumbInfo('Bàn là hơi Sunhouse SHD2065 - Hàng chính hãng', '259.000', '10%', 'assets/imgs/3.png'),
      ProductThumbInfo('Bàn ủi hơi nước - Bàn là hơi nước cầm tay TLK - BL02 công suất 1500w dung tích 280ml (Hàng Chính Hãng)', '688.888', '10%',
          'assets/imgs/4.jpeg'),
      ProductThumbInfo('Bàn ủi hơi nước cầm tay - Bàn là hơi nước cầm tay TiLoKi TBL03 công suất 1200W dung tích 200ml cao cấp (Hàng Chính Hãng)',
          '588.000', '87%', 'assets/imgs/5.jpeg'),
      ProductThumbInfo('Máy xay đa năng PHILIPS HL1643 (Hàng Nhập Khẩu)', '1.685.000', '53%', 'assets/imgs/1.jpeg'),
      ProductThumbInfo('Máy Xay Sinh Tố USB Lock&Lock EJM221 (70W - 500ml) - Hàng Chính Hãng', '829.000', '10%', 'assets/imgs/2.jpeg'),
      ProductThumbInfo('Bàn là hơi Sunhouse SHD2065 - Hàng chính hãng', '259.000', '10%', 'assets/imgs/3.png'),
      ProductThumbInfo('Bàn ủi hơi nước - Bàn là hơi nước cầm tay TLK - BL02 công suất 1500w dung tích 280ml (Hàng Chính Hãng)', '688.888', '10%',
          'assets/imgs/4.jpeg'),
      ProductThumbInfo('Bàn ủi hơi nước cầm tay - Bàn là hơi nước cầm tay TiLoKi TBL03 công suất 1200W dung tích 200ml cao cấp (Hàng Chính Hãng)',
          '588.000', '87%', 'assets/imgs/5.jpeg')
    ];
    return Container(
        padding: EdgeInsets.symmetric(horizontal: width * 2),
        color: Colors.white,
        width: width * 100,
        height: width * 55,
        child: Row(mainAxisAlignment: MainAxisAlignment.spaceBetween, crossAxisAlignment: CrossAxisAlignment.start, children: [
          ProductThumb(a[0]),
          ProductThumb(a[1]),
        ]));
  }
}
