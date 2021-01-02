enum Gym { GymA, GymB }

extension GymDesc on Gym {
  String get title {
    switch (this) {
      case Gym.GymA:
        return "Gym A";
      case Gym.GymB:
        return "Gym B";
    }
    return "Unknown";
  }
}
