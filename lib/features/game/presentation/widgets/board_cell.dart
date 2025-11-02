import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:tictactoe/core/design_system/tokens/app_colors.dart';
import 'package:tictactoe/features/game/domain/entities/position.dart';
import 'package:tictactoe/features/game/presentation/widgets/cell_symbol.dart';
import 'package:tictactoe/features/game/providers/game_controller_provider.dart';

class BoardCell extends StatelessWidget {
  final int index;

  const BoardCell({
    super.key,
    required this.index,
  });

  @override
  Widget build(BuildContext context) {
    return Consumer(builder: (context, ref, _) {
      final state = ref.watch(gameControllerProvider);
      final gameController = ref.read(gameControllerProvider.notifier);

      final player = gameController.getPlayer(Position.fromIndex(index));

      final isEnabled = state.status.isPlaying && player.isEmpty;
      final isWinningCell = false;

      return GestureDetector(
        onTap: isEnabled
            ? () {
                final position = Position.fromIndex(index);
                gameController.play(position);
              }
            : null,
        child: AnimatedContainer(
          duration: const Duration(milliseconds: 300),
          decoration: BoxDecoration(
            color: isWinningCell ? AppColors.success : AppColors.gray,
            borderRadius: BorderRadius.circular(12),
            border: Border.all(
              color: isWinningCell ? AppColors.success : AppColors.gray,
              width: isWinningCell ? 3 : 1,
            ),
          ),
          child: Center(
            child: CellSymbol(player: player, isWinningCell: isWinningCell),
          ),
        ),
      );
    });
  }
}
