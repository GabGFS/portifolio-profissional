/// Contrato base para casos de uso (camada de aplicacao/dominio).
///
/// Cada caso de uso tem UMA responsabilidade (Single Responsibility) e depende
/// apenas de abstracoes do dominio (Dependency Inversion). O tipo generico
/// `Params` padroniza a entrada; use [NoParams] quando nao houver argumentos.
abstract class UseCase<T, Params> {
  Future<T> call(Params params);
}

/// Marcador para casos de uso sem parametros de entrada.
class NoParams {
  const NoParams();
}
