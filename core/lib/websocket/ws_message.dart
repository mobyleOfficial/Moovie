enum WsMessageType {
  scrapeStarted('scrape_started'),
  scrapeFinished('scrape_finished'),
  scrapeFailed('scrape_failed'),
  unknown('unknown');

  final String value;

  const WsMessageType(this.value);

  static WsMessageType fromString(String? type) => switch (type) {
        'scrape_started' => scrapeStarted,
        'scrape_finished' => scrapeFinished,
        'scrape_failed' => scrapeFailed,
        _ => unknown,
      };
}

class WsMessage {
  final WsMessageType type;
  final Map<String, dynamic>? data;

  const WsMessage({required this.type, this.data});

  factory WsMessage.fromJson(Map<String, dynamic> json) => WsMessage(
        type: WsMessageType.fromString(json['type'] as String?),
        data: json['payload'] as Map<String, dynamic>?,
      );
}
