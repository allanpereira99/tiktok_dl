// SPDX-License-Identifier: MIT
// Copyright (c) 2022 Allan Pereira <https://github.com/allanpereira99>

import 'repositories/http_interface.dart';

class TikTok {
  final IHttpService _service = HttpService();
  Future<Map<String, dynamic>> get(String url) async {
    try {
      final String api = "https://api.snaptikvideo.com/st-tik/tiktok/dl?url=";
      final Map<String, dynamic> response =
          await _service.get(Uri.parse("$api$url"));
      return response;
    } catch (e) {
      return {"error": e};
    }
  }
}
