// SPDX-License-Identifier: MIT
// Copyright (c) 2022 Allan Pereira <https://github.com/allanpereira99>

import 'dart:convert';

import 'package:http/http.dart' as http;

abstract class IHttpService {
  Future get(Uri url);
  Future post({params});
}

class HttpService implements IHttpService {
  final http.Client httpCliente = http.Client();
  @override
  Future get(Uri url) async {
    final response = await httpCliente.get(url);
    return jsonDecode(response.body);
  }

  @override
  Future post({params}) async {
    final url = Uri.parse(params["url"]);
    final response = await httpCliente.post(url,
        headers: params["headers"], body: params["data"]);

    return response;
  }
}
