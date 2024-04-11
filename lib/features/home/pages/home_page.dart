import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:navi_stream/app/injection_container.dart';
import 'package:navi_stream/features/home/pages/widgets/bottom_navigation_bar.dart';
import 'package:navi_stream/features/home/pages/widgets/channel.dart';
import 'package:navi_stream/features/home/pages/cubit/home_cubit.dart';
import 'package:navi_stream/features/home/pages/cubit/home_state.dart';
import 'package:navi_stream/features/home/pages/widgets/channel_player.dart';
import 'package:navi_stream/features/home/pages/widgets/header.dart';
import 'package:navi_stream/features/home/pages/widgets/search_bar.dart';
import 'package:navi_stream/utils/text_suffix.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  final TextEditingController _filterController = TextEditingController();
  final FocusNode _focusNode = FocusNode();
  bool _isSearchBarFocused = false;

  @override
  void initState() {
    super.initState();
    _focusNode.addListener(() {
      setState(() {
        _isSearchBarFocused = _focusNode.hasFocus;
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    final double dw = MediaQuery.of(context).size.width;
    final double dh = MediaQuery.of(context).size.height;

    return BlocProvider(
      create: (context) => getIt<HomeCubit>()..init(),
      child: BlocBuilder<HomeCubit, HomeState>(
        builder: (context, state) {
          return Scaffold(
            body: Stack(
              children: [
                Padding(
                  padding: EdgeInsets.only(
                    left: dw * .05,
                    right: dw * .05,
                    bottom: dh * .03,
                  ),
                  child: ListView(
                    children: [
                      const Header(),
                      SizedBox(height: dh * .02),
                      CustomSearchBar(
                        controller: _filterController,
                        focusNode: _focusNode,
                        onSearchChanged: (value) {
                          context.read<HomeCubit>().filterChannels(value);
                        },
                      ),
                      SizedBox(height: dh * .02),
                      if (!_isSearchBarFocused) ...[
                        Text(
                          'Recommended',
                          style: suffix(
                            dh * .025,
                            Colors.black,
                            FontWeight.w800,
                          ),
                        ),
                        GestureDetector(
                          child: Image.asset(
                            'assets/trending.png',
                          ),
                          onTap: () => Navigator.of(context).push(
                            MaterialPageRoute(
                              builder: (_) => const ChannelPlayer(),
                            ),
                          ),
                        ),
                        SizedBox(height: dh * .025),
                      ],
                      Text(
                        'Live Channels',
                        style: suffix(
                          dh * .025,
                          Colors.black,
                          FontWeight.w800,
                        ),
                      ),
                      ListView.builder(
                        shrinkWrap: true,
                        physics: const NeverScrollableScrollPhysics(),
                        itemCount: state.channelModel.length,
                        itemBuilder: (context, index) {
                          final channelModel = state.channelModel[index];
                          return Channel(
                            channelModel: channelModel,
                          );
                        },
                      ),
                      const Divider(
                        color: Color(0xFFC9CACF),
                        thickness: 1,
                      ),
                    ],
                  ),
                ),
                Positioned(
                  bottom: 0,
                  left: 0,
                  right: 0,
                  child: IgnorePointer(
                    child: Container(
                      height: dh * .05,
                      decoration: BoxDecoration(
                        gradient: LinearGradient(
                          begin: Alignment.topCenter,
                          end: Alignment.bottomCenter,
                          colors: [
                            Colors.white.withOpacity(0.3),
                            Colors.grey.withOpacity(0.3),
                          ],
                        ),
                      ),
                    ),
                  ),
                ),
              ],
            ),
            bottomNavigationBar: const CustomBottomNavigationBar(),
          );
        },
      ),
    );
  }

  @override
  void dispose() {
    _filterController.dispose();
    _focusNode.dispose();
    super.dispose();
  }
}
