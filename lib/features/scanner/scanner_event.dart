abstract class ScannerEvent {}

class ScannerLoadEvent extends ScannerEvent {}

class ScannerPickSourceEvent extends ScannerEvent {
  final String uri;

  ScannerPickSourceEvent(this.uri);
}

class ScannerScanEvent extends ScannerEvent {}
