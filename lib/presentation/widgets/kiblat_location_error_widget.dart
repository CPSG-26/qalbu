import 'package:flutter/material.dart';

class KiblatLocationErrorWidget extends StatelessWidget {
  final String? error;
  final Function? callback;

  const KiblatLocationErrorWidget({Key? key, this.error, this.callback}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: <Widget>[
          Text(
            error!,
            style: const TextStyle(
              color: Colors.grey,
            ),
            textAlign: TextAlign.center,
          ),
          const SizedBox(height: 10),
          ElevatedButton(
            child: const Text("Refresh"),
            onPressed: () {
              if (callback != null) callback!();
            },
          ),
        ],
      ),
    );
  }
}
