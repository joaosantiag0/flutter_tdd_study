import 'dart:convert';

import 'package:faker/faker.dart';
import 'package:mocktail/mocktail.dart';
import 'package:test/test.dart';

import 'package:dev_tools/domain/helpers/helpers.dart';
import 'package:dev_tools/domain/usecases/usecases.dart';

import 'package:dev_tools/data/http/http.dart';
import 'package:dev_tools/data/usecases/usecases.dart';

import '../../mocks/api_content_response_mock.dart';

void main() {
  late Faker faker;

  late MenuItemsUsecase usecase;
  late HttpClient httpClient;

  late String url;

  setUp(() {
    faker = Faker();
    url = faker.internet.httpsUrl();
    httpClient = MockHttpClientImplementation();
    usecase = MenuItemsUsecaseImplementation(httpClient: httpClient, url: url);
    mockSuccessfulResponse(httpClient);
  });

  test("Should call httpclient with correct values", () async {
    await usecase.getListMenuItems();

    verify(() => httpClient.request(url: url, method: "GET")).called(1);
  });

  test("Should throw UnexpectedError if HttpClient returns 404", () async {
    mockHttpClientRequestWhen(httpClient).thenThrow(HttpError.notFound);

    final future = usecase.getListMenuItems();

    expect(future, throwsA(DomainError.unexpectedError));
  });

  test("Should throw UnexpectedError if HttpClient returns 403", () async {
    mockHttpClientRequestWhen(httpClient).thenThrow(HttpError.forbiden);

    final future = usecase.getListMenuItems();

    expect(future, throwsA(DomainError.unexpectedError));
  });

  test("Should return a list of MenuItemsUsecase if request is successful",
      () async {
    final result = await usecase.getListMenuItems();

    expect(result, ApiContentResponseMock.responseConvertedToEntityMock());
  });
}

When<Future<dynamic>> mockHttpClientRequestWhen(HttpClient httpClient) {
  return when(() =>
      httpClient.request(url: any(named: "url"), method: any(named: "method")));
}

void mockSuccessfulResponse(HttpClient httpClient) {
  mockHttpClientRequestWhen(httpClient).thenAnswer((_) async =>
      jsonDecode(ApiContentResponseMock.listContentJsonResponseMock));
}

class MockHttpClientImplementation extends Mock implements HttpClient {}
