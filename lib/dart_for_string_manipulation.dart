/// Support for doing something awesome.
///
/// More dartdocs go here.
library;

import 'dart:async';
import 'dart:isolate';

export 'src/dart_for_string_manipulation_base.dart';

// TODO: Export any libraries intended for clients of this package.

Future<String?> manipulateStringInIsolate(String input, String command) async {
  final receivePort = ReceivePort();

  await Isolate.spawn(isolateHandler, receivePort.sendPort);
  final sendPort = await receivePort.first;
  final responsePort = ReceivePort();
  sendPort.send([command, input, responsePort.sendPort]);

  return await responsePort.first;
}

void isolateHandler(SendPort mainSendPort) {
  final port = ReceivePort();

  mainSendPort.send(port.sendPort);

  port.listen((message) {
    final command = message[0];
    final input = message[1];
    final responsePort = message[2];

    if (command == 'reverse') {
      final result = input.split('').reversed.join();
      responsePort.send(result);
    } else if (command == 'uppercase') {
      final result = input.toUpperCase();
      responsePort.send(result);
    } else {
      responsePort.send(null);
    }
    port.close();
  });
}




/*
Practice Question 1: Two-Way Communication for String Manipulation
Task:
Create a function manipulateStringInIsolate
that takes a string and sends it to an isolate
for manipulation (e.g., reversing the string). 
The isolate should send the string back to the
main isolate after manipulation. Implement two-way
communication to allow the main isolate to send additional 
commands or data if needed.
 */