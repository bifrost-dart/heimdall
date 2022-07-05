import 'package:heimdall/heimdall.dart';
import 'package:heimdall/src/router/router.dart';

void initializeUserRoutes(Heimdall app) {
  var router = Router();

  app.useRouter("user", router);
}
