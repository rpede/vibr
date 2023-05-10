import 'package:equatable/equatable.dart';

enum ScannerStatus {
  initial,
  no_source,
  in_progress,
  done,
}

class ScannerState extends Equatable {
  final ScannerStatus status;
  final int numberOfTracks;
  final String? error;

  ScannerState({
    required this.status,
    required this.numberOfTracks,
    this.error,
  });

  ScannerState.initial()
      : status = ScannerStatus.initial,
        numberOfTracks = 0,
        error = null;

  ScannerState.noSource()
      : status = ScannerStatus.no_source,
        numberOfTracks = 0,
        error = null;

  ScannerState copyWith(
      {ScannerStatus? status, int? numberOfTracks, String? error}) {
    return ScannerState(
      status: status ?? this.status,
      numberOfTracks: numberOfTracks ?? this.numberOfTracks,
      error: error ?? this.error,
    );
  }

  @override
  List<Object?> get props => [status];
}
