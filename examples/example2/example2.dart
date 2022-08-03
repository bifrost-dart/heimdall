void main() {
  List<dynamic> middlewares = [];

  add(Fn f) {
    middlewares.add(f);
  }

  add((req, next) {
    if (next != null) {
      print("first");
      print(req);
      next(req);
    }
  });

  add((req, next) {
    if (next != null) {
      print("second");
      print(req);
      next(req);
    }
  });

  exec() {
    for (var i = 0; i < middlewares.length; i++) {
      var s = middlewares[i];

      if (middlewares[i + 1] != null) {
        s("hello", middlewares[i + 1]);
      } else {
        s("hello", null);
      }
    }
  }

  exec();
}

typedef Fn = void Function(String req, Function? next);
