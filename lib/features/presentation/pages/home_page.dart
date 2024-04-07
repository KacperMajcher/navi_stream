import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:navi_stream/app/injection_container.dart';
import 'package:navi_stream/features/presentation/data/models/channel_model.dart';
import 'package:navi_stream/features/presentation/pages/channel.dart';
import 'package:navi_stream/features/presentation/pages/cubit/home_cubit.dart';

class HomePage extends StatelessWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => getIt<HomeCubit>()..getChannelModel(),
      child: BlocBuilder<HomeCubit, HomeState>(
        builder: (context, state) {
          final channelModel = state.channelModel;
          return Scaffold(
            appBar: AppBar(
              automaticallyImplyLeading: false,
              title: const Text('Channels'),
            ),
            body: Center(
              child: Column(
                children: [
                  const Text(
                    'Welcome to the application, you have logged in.\nThats your channels',
                    textAlign: TextAlign.center,
                  ),
                  Channel(
                    channelModel: ChannelModel(
                      channelName: channelModel?.channelName ?? '',
                      channelLogo: channelModel?.channelLogo ??
                          'assets/logo_test.jpg', //set logo as default
                    ),
                  ),
                ],
              ),
            ),
          );
        },
      ),
    );
  }
}
