import 'package:flutter/material.dart';

class Channel extends StatelessWidget {
  const Channel({
    Key? key,
    required this.channelName,
    required this.channelLogo,
  }) : super(key: key);

  final String channelName;
  final String channelLogo;

  @override
  Widget build(BuildContext context) {
    final double dh = MediaQuery.of(context).size.height;
    final double dw = MediaQuery.of(context).size.width;
    return Padding(
      padding: EdgeInsets.all(dh * .03),
      child: Card(
        color: Colors.white,
        child: Row(
          children: [
            Padding(
              padding: EdgeInsets.all(dh * 0.01),
              child: Image.asset(
                channelLogo,
                height: dh * 0.055,
                width: dw * 0.11,
                fit: BoxFit.cover,
              ),
            ),
            Expanded(
              child: Text(
                channelName,
                style: const TextStyle(
                  fontSize: 16,
                  fontWeight: FontWeight.w500,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
