import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class AddTinkCard extends StatefulWidget {
  const AddTinkCard({Key? key}) : super(key: key);

  @override
  _AddTinkCardState createState() => _AddTinkCardState();
}

class _AddTinkCardState extends State<AddTinkCard> {

  final String viewType = '<platform-view-type>';
  // Pass parameters to the platform side.
  final Map<String, dynamic> creationParams = <String, dynamic>{};

  @override
  Widget build(BuildContext context) {
    return Center(child:UiKitView(
      viewType: viewType,
      layoutDirection: TextDirection.ltr,
      creationParams: creationParams,
      creationParamsCodec: const StandardMessageCodec(),
    ));
  }
}
