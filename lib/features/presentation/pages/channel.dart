import 'package:flutter/material.dart';
import 'package:navi_stream/features/presentation/data/models/channel_model.dart';

class Channel extends StatelessWidget {
  const Channel({
    Key? key,
    required this.channelModel,
  }) : super(key: key);

  final ChannelModel channelModel;

  @override
  Widget build(BuildContext context) {
    final double dh = MediaQuery.of(context).size.height;
    final double dw = MediaQuery.of(context).size.width;
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: dw * .03),
      child: Card(
        child: Row(
          children: [
            Padding(
              padding: EdgeInsets.all(dh * 0.01),
              child: Image.network(
                channelModel.channelLogo,
                height: dh * 0.055,
                width: dw * 0.11,
                fit: BoxFit.contain,

                // default image in case of an error loading the network image
                errorBuilder: (context, exception, stackTrace) {
                  return Image.asset(
                    'assets/channel_logo_test.jpg',
                    height: dh * 0.055,
                    width: dw * 0.11,
                    fit: BoxFit.contain,
                  );
                },
              ),
            ),
            Expanded(
              child: Text(
                channelModel.channelName,
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
