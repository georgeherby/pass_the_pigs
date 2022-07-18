enum Position {
  razorback('Razorback', 'assets/images/icons/razorback.gif'),
  trotter('Trotter', 'assets/images/icons/trotter.gif'),
  snouter('Snouter', 'assets/images/icons/snouter.gif'),
  leaningJowler('Leaning jowler', 'assets/images/icons/leaningjowler.gif'),
  sideNoSpot('Side (no spot)', 'assets/images/icons/no_dot.gif'),
  sideSpot('Side (spot)', 'assets/images/icons/dot.gif');

  const Position(this.displayText, this.assetPath);
  final String displayText;
  final String assetPath;
}
