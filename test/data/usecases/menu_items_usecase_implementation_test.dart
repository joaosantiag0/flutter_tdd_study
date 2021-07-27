import 'package:faker/faker.dart';
import 'package:mocktail/mocktail.dart';
import 'package:test/test.dart';

import 'package:dev_tools/domain/usecases/usecases.dart';

import 'package:dev_tools/data/http/http.dart';
import 'package:dev_tools/data/usecases/usecases.dart';

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
  });

  test("Should call httpclient with correct values", () async {
    when(() => httpClient.request(
        url: any(named: "url"),
        method: any(named: "method"))).thenAnswer((_) async => {"test": "a"});

    await usecase.getListMenuItems();

    verify(() => httpClient.request(url: url, method: "GET")).called(1);
  });
}

class MockHttpClientImplementation extends Mock implements HttpClient {}
