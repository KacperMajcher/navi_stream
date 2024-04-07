import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:navi_stream/features/presentation/data/data_sources/home_remote_data_source.dart';
import 'package:navi_stream/features/presentation/data/repositories/home_repository.dart';
import 'package:navi_stream/features/presentation/pages/channel.dart';
import 'package:navi_stream/features/presentation/pages/cubit/home_cubit.dart';

class HomePage extends StatelessWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) =>
          HomeCubit(HomeRepository(HomeRemoteDioDataSource()))..getChannels(),
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
                  Channel(channelModel: channelModel!)
                ],
              ),
            ),
          );
        },
      ),
    );
  }
}
