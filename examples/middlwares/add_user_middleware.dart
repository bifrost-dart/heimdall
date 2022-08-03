import 'package:heimdall/src/context.dart';

addUser(String name) {
  return (Context ctx) {
    ctx.req.body = name;
  };
}
