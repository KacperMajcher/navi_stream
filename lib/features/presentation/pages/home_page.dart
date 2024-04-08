import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:navi_stream/app/injection_container.dart';
import 'package:navi_stream/features/presentation/pages/channel.dart';
import 'package:navi_stream/features/presentation/pages/cubit/home_cubit.dart';
import 'package:navi_stream/features/presentation/pages/cubit/home_state.dart';

class HomePage extends StatelessWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => getIt<HomeCubit>()..init(),
      child: BlocBuilder<HomeCubit, HomeState>(
        builder: (context, state) {
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
                  Expanded(
                    child: ListView(
                      children: [
                        for (final channelModel in state.channelModel)
                          Channel(channelModel: channelModel)
                      ],
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
