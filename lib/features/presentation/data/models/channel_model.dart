class ChannelModel {
  ChannelModel({
    required this.channelName,
    required this.channelLogo,
  });

  final String channelName;
  final String? channelLogo;

  // converter JSON to model
  factory ChannelModel.fromJson(Map<String, dynamic> json) {
    return ChannelModel(
      channelName: json['name'],
      channelLogo:
          json['logo'] ?? 'assets/logo_test.jpg', //TODO come back here later
    );
  }
}