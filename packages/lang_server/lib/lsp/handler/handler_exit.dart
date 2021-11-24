// Copyright (c) 2018, the Dart project authors. Please see the AUTHORS file
// for details. All rights reserved. Use of this source code is governed by a
// BSD-style license that can be found in the LICENSE file.

// @dart = 2.9

import 'dart:io';

import '../../protocol/protocol_generated.dart';
import '../../protocol/protocol_special.dart';
import '../lsp_analysis_server.dart';
import 'handlers.dart';

class ExitMessageHandler extends MessageHandler<void, void> {
  final bool clientDidCallShutdown;

  ExitMessageHandler(
    LspAnalysisServer server, {
    this.clientDidCallShutdown = false,
  }) : super(server);

  @override
  Method get handlesMessage => Method.exit;

  @override
  LspJsonHandler<void> get jsonHandler => NullJsonHandler;

  @override
  Future<ErrorOr<void>> handle(void _, CancellationToken token) async {
    // Set a flag that the server shutdown is being controlled here to ensure
    // that the normal code that shuts down the server when the channel closes
    // does not fire.
    server.willExit = true;

    await server.shutdown();
    await Future(() {
      exit(clientDidCallShutdown ? 0 : 1);
    });
    return success();
  }
}
