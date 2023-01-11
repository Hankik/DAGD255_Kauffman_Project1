class Timer {

  // variables
  float duration;
  float timeLeft;
  boolean isDone = true;
  boolean autoRestart = false;
  boolean isPaused = false;

  Timer(float duration) {

    this.duration = duration;
    this.timeLeft = duration;
    isDone = false;
  }

  void update() {

    if (!isPaused) {

      if (timeLeft <= 0) {

        isDone = true;

        // USE EVENT PATTERN HERE

        if (autoRestart) reset();
      } else {

        if (!isDone) {

          timeLeft -= dt;
        }
      }
    }
  }

  void reset() {

    timeLeft = duration;
    isDone = false;
  }
}
