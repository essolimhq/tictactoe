enum GameStorageKey {
  gameState('game_state_v1'),
  score('score');

  final String key;

  const GameStorageKey(this.key);
}
