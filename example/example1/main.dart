import 'package:heimdall/heimdall.dart';
import 'package:heimdall/src/router/router.dart';

void main() {
  var app = Heimdall();

  var router = Router();

  router.get("a", ((ctx) {
    ctx.response.write("a");
    ctx.response.close();
  }));

  router.get("b", ((ctx) {
    ctx.response.write("b");
    ctx.response.close();
  }));

  app.useRouter("admin", router);

  app.listen(3000);
  print("Server started");
}
