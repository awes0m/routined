import 'package:flutter/material.dart';
import 'package:percent_indicator/circular_percent_indicator.dart';

class HabbitTile extends StatelessWidget {
  final String habbitName;
  final VoidCallback ontap;
  final VoidCallback settingsOntap;
  final int timeSpent;
  final int timeGoal;
  final bool habbitStarted;

  const HabbitTile({
    super.key,
    required this.habbitName,
    required this.ontap,
    required this.settingsOntap,
    required this.timeSpent,
    required this.timeGoal,
    required this.habbitStarted,
  });

  get percentageComplete => timeSpent / timeGoal;

  String formatToMinSec(int totalSeconds) {
    String sec = (totalSeconds % 60).toString();
    String mins = (totalSeconds / 60).toStringAsFixed(1);

    if (sec.length == 1) {
      sec = '0$sec';
    }

    if (mins[1] == '.') {
      mins = '0${mins.substring(0, 1)}';
    }
    return '$mins:$sec';
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(left: 10.0, right: 10, top: 20),
      child: Container(
        padding: const EdgeInsets.all(20),
        decoration: BoxDecoration(
          color: Colors.grey[200],
          borderRadius: BorderRadius.circular(10),
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Row(
              children: [
                //Circular Progressbar

                GestureDetector(
                  onTap: ontap,
                  child: SizedBox(
                    height: 60,
                    width: 60,
                    child: Stack(
                      children: [
                        CircularPercentIndicator(
                          radius: 30,
                          lineWidth: 10,
                          percent:
                              percentageComplete < 1 ? percentageComplete : 1,
                          progressColor: percentageComplete > 0.5
                              ? Colors.green
                              : Colors.redAccent,
                        ),
                        Center(
                            child: habbitStarted
                                ? const Icon(Icons.pause)
                                : const Icon(Icons.play_arrow))
                      ],
                    ),
                  ),
                ),
                const SizedBox(width: 20),
                //Info text
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    // Habbit name

                    Text(
                      habbitName,
                      style: const TextStyle(
                        fontWeight: FontWeight.bold,
                        fontSize: 18,
                      ),
                    ),

                    const SizedBox(height: 4),
                    //progress
                    Row(
                      children: [
                        Text(
                          '${formatToMinSec(timeSpent)}/${formatToMinSec(timeGoal)}',
                          style: const TextStyle(color: Colors.grey),
                        ),
                        const SizedBox(width: 20),
                        Text(
                          '${(percentageComplete * 100).toStringAsFixed(2)}%',
                          style: TextStyle(
                              color: percentageComplete > 0.5
                                  ? Colors.green[900]
                                  : Colors.deepOrange[600]),
                        )
                      ],
                    )
                  ],
                ),
              ],
            ),
            //Habit settings
            GestureDetector(
              onTap: settingsOntap,
              child: const Icon(Icons.settings),
            ),
          ],
        ),
      ),
    );
  }
}
