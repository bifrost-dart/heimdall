import "dart:io";

Future<HttpServer> createHtpServer(int port) async {
  return HttpServer.bind("localhost", port);
}
