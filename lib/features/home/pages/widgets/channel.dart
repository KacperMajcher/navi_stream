import 'package:flutter/material.dart';
import 'package:navi_stream/features/home/data/models/channel_model.dart';
import 'package:navi_stream/features/home/pages/widgets/channel_player.dart';
import 'package:navi_stream/utils/text_suffix.dart';

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

    return Column(
      children: [
        const Divider(
          color: Color(0xFFC9CACF),
          thickness: 1,
        ),
        GestureDetector(
          onTap: () => Navigator.of(context).push(
            MaterialPageRoute(
              builder: (_) => const ChannelPlayer(),
            ),
          ),
          child: Row(children: [
            SizedBox(
              width: dw * .25,
              child: Image.network(
                channelModel.channelLogo,
                height: dh * 0.04,
                width: dw * 0.1,
                fit: BoxFit.contain,
                errorBuilder: (context, exception, stackTrace) {
                  return Image.asset(
                    'assets/channel_logo_test.jpg',
                    height: dh * 0.055,
                    width: dw * 0.1,
                    fit: BoxFit.contain,
                  );
                },
              ),
            ),
            SizedBox(width: dw * .015),
            Text(
              channelModel.channelName,
              style: suffix(
                16.0,
                Colors.black,
                FontWeight.w500,
              ),
            ),
            const Spacer(),
            Icon(
              Icons.arrow_forward_ios_rounded,
              size: dh * .02,
              color: const Color(0xFF515257),
            )
          ]),
        ),
      ],
    );
  }
}
