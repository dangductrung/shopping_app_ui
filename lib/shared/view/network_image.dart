import 'package:flutter/material.dart';
import 'package:shimmer/shimmer.dart';
import 'package:shopping_app/theme/ui_color.dart';

class NetworkImageWidget extends StatelessWidget {
  final String url;
  final double width;
  final double height;
  final BoxFit boxFit;

  const NetworkImageWidget({@required this.url, this.width, this.height, this.boxFit});

  @override
  Widget build(BuildContext context) {
    return Image.network(
      url,
      width: width ?? 100,
      height: height ?? 100,
      fit: boxFit ?? BoxFit.contain,
      filterQuality: FilterQuality.high,
      loadingBuilder: (context, widget, event) {
        return event == null
            ? widget
            : Shimmer.fromColors(
                baseColor: Colors.grey[300],
                highlightColor: Colors.grey[100],
                child: Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Container(
                    width: width ?? 100,
                    height: height ?? 100,
                    color: Colors.white,
                  ),
                ),
              );
      },
      errorBuilder: (context, error, data) => Padding(
        padding: const EdgeInsets.all(8.0),
        child: Container(
          color: Colors.grey[300],
        ),
      ),
    );
  }
}
