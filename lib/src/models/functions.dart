String formattedDuration(Duration duration) {
  final hours = duration.inHours.toString().padLeft(2, '0');
  final minuts = duration.inMinutes.remainder(60).toString().padLeft(2, '0');
  return '$hours:$minuts';
}

double projectedWeight(double totalWeight, Duration totalDuration) {
  if (totalDuration.inMinutes == 0) {
    return 0;
  }

  double rateOfConsumption = totalWeight / totalDuration.inMinutes;
  // calculate the projected weight in 24 hours
  return rateOfConsumption * 24 * 60;
}
