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
  late RepoItemsUsecase usecase;
  late HttpClient httpClient;

  late String url;

  setUp(() {
    url = faker.internet.httpsUrl();
    httpClient = MockHttpClient();
    usecase = RepoItemsUsecaseImplementation(httpClient: httpClient, url: url);
    mockSuccessfulResponse(httpClient);
  });

  test("Should call httpclient with correct values", () async {
    await usecase.getListRepoItems();

    verify(() => httpClient.request(url: url, method: "GET")).called(1);
  });

  test("Should throw UnexpectedError if HttpClient returns 404", () async {
    mockHttpClientRequestWhen(httpClient).thenThrow(HttpError.notFound);

    final future = usecase.getListRepoItems();

    expect(future, throwsA(DomainError.unexpectedError));
  });

  test("Should throw UnexpectedError if HttpClient returns 403", () async {
    mockHttpClientRequestWhen(httpClient).thenThrow(HttpError.forbiden);

    final future = usecase.getListRepoItems();

    expect(future, throwsA(DomainError.unexpectedError));
  });

  test("Should return a list of RepoItemsUsecase if request is successful",
      () async {
    final result = await usecase.getListRepoItems();

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

class MockHttpClient extends Mock implements HttpClient {}
