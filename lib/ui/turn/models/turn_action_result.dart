import 'package:pass_the_pigs/common/common.dart';

/// Outcome of a turn action so the UI does not re-implement rules.
sealed class TurnActionResult {
  const TurnActionResult();
}

class TurnContinue extends TurnActionResult {
  const TurnContinue();
}

class TurnPigOut extends TurnActionResult {
  const TurnPigOut();
}

class TurnBanked extends TurnActionResult {
  const TurnBanked(this.throws);

  final List<Throw> throws;
}

class TurnIncomplete extends TurnActionResult {
  const TurnIncomplete();
}

class TurnNothingToBank extends TurnActionResult {
  const TurnNothingToBank();
}

class TurnOinker extends TurnActionResult {
  const TurnOinker();
}
