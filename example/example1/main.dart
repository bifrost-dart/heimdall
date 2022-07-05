import 'package:heimdall/heimdall.dart';
import 'package:heimdall/src/router/router.dart';

void main() {
  var app = Heimdall();

  app.enableCors();

  var router = Router();

  router.get("a", ((ctx) {
    print("admin/a");
  }));

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
