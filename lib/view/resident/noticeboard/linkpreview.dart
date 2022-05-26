import 'package:flutter/src/foundation/key.dart';
import 'package:flutter/src/widgets/container.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter/material.dart';
import 'package:any_link_preview/any_link_preview.dart';

class LinkPreview extends StatelessWidget {
  final link, date, onTap;
  const LinkPreview(
      {Key? key, required this.link, required this.date, required this.onTap})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.fromLTRB(0, 10, 0, 10),
      child: Column(crossAxisAlignment: CrossAxisAlignment.end, children: [
        AnyLinkPreview(
            link: link,
            displayDirection: UIDirection.uiDirectionHorizontal,
            backgroundColor: Colors.grey[300],
            errorWidget: Container(
              height: 50,
              color: Colors.grey[300],
              child: Center(child: Text('Not available now')),
            ),
            bodyStyle: TextStyle(color: Colors.grey, fontSize: 12),
            onTap: onTap),
        Padding(
          padding: const EdgeInsets.fromLTRB(0, 10, 0, 10),
          child: Text(
            date,
            style: TextStyle(color: Colors.grey),
          ),
        )
      ]),
    );
  }
}
