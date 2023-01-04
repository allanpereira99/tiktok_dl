// SPDX-License-Identifier: MIT
// Copyright (c) 2022 Allan Pereira <https://github.com/allanpereira99>

import 'repositories/http_interface.dart';
import 'package:html/parser.dart' as parser;
import 'package:html/dom.dart';

final IHttpService _service = HttpService();

class TikTok {
// GET INFO VIDEO
  Future _getInfo(String urlMedia) async {
    final response = await _service
        .get(Uri.parse("https://www.tiktok.com/oembed?url=$urlMedia"));

    final Map<String, dynamic> result = {
      "title": response["title"],
      "author_url": response["author_url"],
      "author_name": response["author_name"],
      "download": []
    };
    return result;
  }

// GET URL DOWNLOAD VIDEO
  Future getDownload(String urlMedia) async {
    var result = await _getInfo(urlMedia);

// REQUEST CONFIG
    final Map<Object, Object> configs = {
      "method": 'post',
      "url": 'https://tiktokdownload.online/abc?url=dl',
      "headers": {
        "origin": 'https://tiktokdownload.online',
        "referer": 'https://tiktokdownload.online/pt',
        "sec-fetch-des": 'empty',
        "sec-fetch-mode": 'cors',
        "sec-fetch-site": 'same-origin',
        "user-agent":
            'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/107.0.0.0 Safari/537.36 Edg/107.0.1418.52',
        "Content-Type": 'application/x-www-form-urlencoded; charset=UTF-8',
      },
      "data": {
        "id": urlMedia,
        "locale": 'pt',
      }
    };

// REQUEST
    final res = await _service.post(params: configs);
    Document document = parser.parse(res.body);

// WITHDRAW DOWNLOAD LINK
    final List<String> domains = ['tiktokcdn', 'ssstik.top'];
    for (String domain in domains) {
      document.getElementsByTagName('a').forEach((Element element) {
        if (element.attributes['href']!.contains(domain)) {
          result["download"].add(element.attributes['href']);
        }
      });
    }
    return result;
  }
}
