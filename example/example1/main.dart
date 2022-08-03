import 'dart:async';
import 'dart:convert';
import 'dart:typed_data';

import 'package:heimdall/heimdall.dart';
import 'package:heimdall/src/router/router.dart';

void main() {
  var app = Heimdall();

  app.enableCors();

  var router = Router();

  router.get("a", (ctx) async {
    var content = await ctx.req
        .transform(StreamTransformer.fromHandlers(
            handleData: ((data, sink) =>
                sink.add(new String.fromCharCodes(data)))))
        .join();
    print("Content :" + content);
    var queryParams = Uri.splitQueryString(content);
    print(queryParams);
    print("admin/a");
  });

  router.get("b", ((ctx) {
    print("admin/b");
  }));

  var userRouter = Router();

  userRouter.get("a", ((ctx) {
    print("user/a");
    ctx.res.send({"Hello": "Helo"});
  }));

  var newRouter = Router();
  newRouter.get("a", ((ctx) {
    print("user/new/a");
  }));

  app.useRouter("admin", router);
  app.useRouter("user", userRouter);
  userRouter.appendRouter('new', newRouter);

  app.listen(3000);
  print("Server started");
}
