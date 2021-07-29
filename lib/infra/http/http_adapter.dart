import 'dart:convert';

import 'package:http/http.dart';

import '../../data/http/http.dart';

class HttpClientImplementation implements HttpClient {
  Client client;

  HttpClientImplementation(this.client);

  @override
  Future<Map> request(
      {required String url,
      required String method,
      Map? body,
      Map? headers}) async {
    final headersEncoded =
        headers == null ? null : headers as Map<String, String>;

    var response = Response("", 500);
    switch (method.toLowerCase()) {
      case "get":
        response = await client.get(Uri.parse(url), headers: headersEncoded);
        break;
    }

    return _hanlderResponse(response);
  }

  Map _hanlderResponse(Response response) {
    switch (response.statusCode) {
      case 200:
        return jsonDecode(response.body);
      case 404:
        throw HttpError.notFound;
      case 403:
        throw HttpError.forbiden;
      default:
        throw HttpError.serverError;
    }
  }
}
