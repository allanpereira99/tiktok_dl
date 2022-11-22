import 'package:tiktok_dl/tiktok_dl.dart';

void main(List<String> args) async {
  final TikTok tikTok = TikTok();
  final result = await tikTok.get(
      "https://www.tiktok.com/@jooj/video/7168489924587654406?is_copy_url=1&is_from_webapp=v1");
  print(result);
}
