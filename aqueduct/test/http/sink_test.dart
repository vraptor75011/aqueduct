import 'dart:async';
import 'package:aqueduct/src/runtime/app/app.dart';
import 'package:aqueduct/src/runtime/runtime.dart';
import 'package:test/test.dart';
import 'package:aqueduct/aqueduct.dart';

void main() {
  test("Find default ApplicationChannel", () {
    expect(Runtime.current.runtimes.iterable.whereType<ChannelRuntime>().length, equals(1));
    expect(Runtime.current.runtimes.iterable.whereType<ChannelRuntime>().first.channelType, equals(TestChannel));
  });
}

class TestChannel extends ApplicationChannel {
  @override
  Controller get entryPoint {
    final router = Router();
    router.route("/controller/[:id]").link(() => FailingController());
    return router;
  }
}

class FailingController extends ResourceController {
  @Operation.get()
  Future<Response> get() async {
    return Response.ok(null);
  }
}
