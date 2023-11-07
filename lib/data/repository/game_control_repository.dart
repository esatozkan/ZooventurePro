class GameControlRepository {
  int incrementIndex(int val) {
    val += 1;
    return val;
  }

  int decrementIndex(int val) {
    val -= 1;
    return val;
  }

  int resetIndex(int val) {
    val = 0;
    return val;
  }

  int setIndex(int val) {
    val = val;
    return val;
  }

  bool isGameOver(bool val) {
    val = !val;
    return val;
  }

  bool trueOption(bool val) {
    val = true;

    return val;
  }

  bool falseOption(bool val) {
    val = false;

    return val;
  }
}
