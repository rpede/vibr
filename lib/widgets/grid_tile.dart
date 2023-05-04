import 'package:flutter/material.dart';

class GridTileItem extends StatelessWidget {
  const GridTileItem(
      {super.key, required this.title, this.subTitle, this.image});
  final String title;
  final String? subTitle;
  final String? image;

  @override
  Widget build(BuildContext context) {
    final textTheme = Theme.of(context).textTheme;
    return Column(
      children: [
        SizedBox(
          width: 100,
          height: 100,
          child: image != null ? Image.asset(image!, fit: BoxFit.cover) : Placeholder(),
        ),
        Container(
          width: 100,
          padding: const EdgeInsets.only(top: 6),
          child:
              Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
            Text(
              title,
              style: textTheme.titleMedium,
              overflow: TextOverflow.fade,
              maxLines: 1,
              softWrap: false,
            ),
            if (subTitle != null)
              Text(
                subTitle!,
                style: textTheme.titleSmall,
                overflow: TextOverflow.fade,
                maxLines: 1,
                softWrap: false,
              )
          ]),
        )
      ],
    );
  }
}
