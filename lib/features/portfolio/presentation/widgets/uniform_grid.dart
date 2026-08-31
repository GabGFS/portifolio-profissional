import 'package:flutter/widgets.dart';

/// Grade responsiva em que os itens de uma mesma linha tem sempre a mesma
/// altura — a do mais alto.
///
/// Substitui o `Wrap`, que deixava cada item se dimensionar sozinho e produzia
/// cards de alturas diferentes lado a lado. O numero de colunas vem de
/// [columnsFor], para que cada secao mantenha os seus proprios pontos de quebra.
class UniformGrid extends StatelessWidget {
  final int itemCount;

  /// Recebe o indice e o numero de colunas em uso (util para escalonar
  /// animacoes de entrada por posicao na linha).
  final Widget Function(int index, int columns) itemBuilder;

  final int Function(double maxWidth) columnsFor;
  final double gap;

  const UniformGrid({
    super.key,
    required this.itemCount,
    required this.itemBuilder,
    required this.columnsFor,
    this.gap = 20,
  });

  @override
  Widget build(BuildContext context) {
    if (itemCount == 0) return const SizedBox.shrink();
    return LayoutBuilder(
      builder: (BuildContext context, BoxConstraints constraints) {
        final int columns = columnsFor(constraints.maxWidth).clamp(1, itemCount);
        final List<Widget> rows = <Widget>[];

        for (int start = 0; start < itemCount; start += columns) {
          final List<Widget> cells = <Widget>[];
          for (int column = 0; column < columns; column++) {
            if (column > 0) cells.add(SizedBox(width: gap));
            final int index = start + column;
            cells.add(
              Expanded(
                child: index < itemCount
                    ? itemBuilder(index, columns)
                    : const SizedBox.shrink(),
              ),
            );
          }
          if (rows.isNotEmpty) rows.add(SizedBox(height: gap));
          rows.add(
            IntrinsicHeight(
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: cells,
              ),
            ),
          );
        }

        return Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: rows,
        );
      },
    );
  }
}
