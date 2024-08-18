import 'package:equatable/equatable.dart';
import 'package:pass_the_pigs/common/common.dart';

class Player extends Equatable {
  const Player({required this.id, required this.name, required this.throws});

  final int id;
  final String name;
  final List<Throw> throws;

  @override
  List<Object> get props => [id, name, throws];

  Player addThrowsToPlayer(List<Throw> newThrows) {
    return copyWith(throws: [...throws, ...newThrows]);
  }

  Player resetAllThrows() {
    return copyWith(throws: []);
  }

  int get score =>
      throws.fold(0, (acc, throwItem) => acc + (throwItem.getScore() ?? 0));

  bool get isWinner => score > 100;

  Player copyWith({
    int? id,
    String? playerName,
    List<Throw>? throws,
  }) {
    return Player(
      id: id ?? this.id,
      name: playerName ?? name,
      throws: throws ?? this.throws,
    );
  }
}
