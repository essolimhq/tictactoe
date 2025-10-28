enum GameStorageKey {
  gameState('game_state_v1'),
  xScore('player_x_score'),
  oScore('player_o_score');

  final String key;

  const GameStorageKey(this.key);
}
