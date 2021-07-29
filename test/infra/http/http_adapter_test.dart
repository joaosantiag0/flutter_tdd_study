import 'dart:convert';

import 'package:faker/faker.dart';
import 'package:http/http.dart';
import 'package:mocktail/mocktail.dart';
import 'package:test/test.dart';

import 'package:dev_tools/data/http/http.dart';

void main() {
  late Client client;
  late HttpClient httpClient;

  late String url;

  void mockValidResponse() {
    when(() => client.get(Uri.parse(url))).thenAnswer(
        (_) async => Response("{ \"test_key\": \"test_value\" }", 200));
  }

  setUp(() {
    client = ClientMock();
    httpClient = HttpClientImplementation(client);
    url = faker.internet.httpUrl();
    mockValidResponse();
  });

  test("Should HttpClient call URL with verb Get without headers", () async {
    httpClient.request(url: url, method: "GET");

    verify(() => client.get(Uri.parse(url))).called(1);
  });

  test("Should throws NotFoundHttpError if code 404", () async {
    when(() => client.get(Uri.parse(url)))
        .thenAnswer((_) async => Response("", 404));

    final result = httpClient.request(url: url, method: "GET");
    expect(() => result, throwsA(HttpError.notFound));
  });

  test("Should throws NotFoundHttpError if code 403", () async {
    when(() => client.get(Uri.parse(url)))
        .thenAnswer((_) async => Response("", 403));

    final result = httpClient.request(url: url, method: "GET");
    expect(() => result, throwsA(HttpError.forbiden));
  });

  test("Should throws ServerErrorHttpError if code 500", () async {
    when(() => client.get(Uri.parse(url)))
        .thenAnswer((_) async => Response("", 500));

    final result = httpClient.request(url: url, method: "GET");
    expect(() => result, throwsA(HttpError.serverError));
  });
}

class ClientMock extends Mock implements Client {}

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
