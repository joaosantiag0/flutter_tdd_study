import 'package:dev_tools/domain/entities/entities.dart';

class ApiContentResponseMock {
  static String listContentJsonResponseMock = """[
    {
        "name": ".gitignore",
        "path": ".gitignore",
        "sha": "d956ab0a1250bbdf42287842a713622ce934cdaf",
        "size": 125,
        "url": "https://api.github.com/repos/jonhbala/learning-closure-bank/contents/.gitignore?ref=main",
        "html_url": "https://github.com/jonhbala/learning-closure-bank/blob/main/.gitignore",
        "git_url": "https://api.github.com/repos/jonhbala/learning-closure-bank/git/blobs/d956ab0a1250bbdf42287842a713622ce934cdaf",
        "download_url": "https://raw.githubusercontent.com/jonhbala/learning-closure-bank/main/.gitignore",
        "type": "file",
        "_links": {
            "self": "https://api.github.com/repos/jonhbala/learning-closure-bank/contents/.gitignore?ref=main",
            "git": "https://api.github.com/repos/jonhbala/learning-closure-bank/git/blobs/d956ab0a1250bbdf42287842a713622ce934cdaf",
            "html": "https://github.com/jonhbala/learning-closure-bank/blob/main/.gitignore"
        }
    },
    {
        "name": "CHANGELOG.md",
        "path": "CHANGELOG.md",
        "sha": "b703ee27e12973089a4bf71cfc161bb3e53ecf47",
        "size": 788,
        "url": "https://api.github.com/repos/jonhbala/learning-closure-bank/contents/CHANGELOG.md?ref=main",
        "html_url": "https://github.com/jonhbala/learning-closure-bank/blob/main/CHANGELOG.md",
        "git_url": "https://api.github.com/repos/jonhbala/learning-closure-bank/git/blobs/b703ee27e12973089a4bf71cfc161bb3e53ecf47",
        "download_url": "https://raw.githubusercontent.com/jonhbala/learning-closure-bank/main/CHANGELOG.md",
        "type": "file",
        "_links": {
            "self": "https://api.github.com/repos/jonhbala/learning-closure-bank/contents/CHANGELOG.md?ref=main",
            "git": "https://api.github.com/repos/jonhbala/learning-closure-bank/git/blobs/b703ee27e12973089a4bf71cfc161bb3e53ecf47",
            "html": "https://github.com/jonhbala/learning-closure-bank/blob/main/CHANGELOG.md"
        }
    }]""";

  static List<RepoItemEntity> responseConvertedToEntityMock() {
    return [
      RepoItemEntity(id: ".gitignore", name: ".gitignore"),
      RepoItemEntity(id: "CHANGELOG.md", name: "CHANGELOG.md")
    ];
  }
}
