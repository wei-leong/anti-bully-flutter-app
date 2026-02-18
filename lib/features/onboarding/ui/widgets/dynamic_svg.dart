import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';

class DynamicSvg extends StatelessWidget {
  const DynamicSvg({
    super.key,
    required this.path,
    required this.replaceColorHex,
  });

  final String path;
  final String replaceColorHex;

  @override
  Widget build(BuildContext context) {
    final primaryColor = Theme.of(context).colorScheme.primary;
    final newHex = '#${primaryColor.value.toRadixString(16).substring(2)}';

    return FutureBuilder(
      future: DefaultAssetBundle.of(context).loadString(path),
      builder: (context, snapshot) {
        if (!snapshot.hasData) return const SizedBox();

        final svgString = snapshot.data!.replaceAll(
          RegExp(replaceColorHex, caseSensitive: false),
          newHex,
        );

        return SvgPicture.string(svgString);
      },
    );
  }
}
