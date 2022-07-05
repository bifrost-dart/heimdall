import 'package:heimdall/heimdall.dart';

import 'add_user_middleware.dart';
import 'user_router.dart';

void main() {
  var app = Heimdall();
  app.enableCors();

  // app.use(bodyParser());

  // app.use((ctx) {handler});

  // @depricated
  // app.use("/admin", adminRouter);

  // app.use((){}, () {
  // })

  app.use(addUser("Hello"));

  initializeUserRoutes(app);

  app.listen(3000);
  print("Server running on PORT 3000");
}
