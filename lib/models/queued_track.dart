import 'package:equatable/equatable.dart';
import 'package:uuid/uuid.dart';

import 'track.dart';

const uuid = Uuid();

class QueuedTrack extends Equatable {
  final String queueId;
  final Track track;

  const QueuedTrack({required this.queueId, required this.track});

  QueuedTrack.fromTrack(this.track) : queueId = uuid.v4();

  @override
  List<Object?> get props => [queueId, track];
}
