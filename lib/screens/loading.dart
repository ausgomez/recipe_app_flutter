import 'package:flutter/material.dart';
import 'dart:math';
import 'package:flutter_spinkit/flutter_spinkit.dart';

class LoadingPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.blue[200],
      body: Container(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Text(
              randomLine(),
              style: TextStyle(
                fontSize: 40,
                color: Colors.white,
              ),
              textAlign: TextAlign.center,
            ),
            SizedBox(
              height: 40,
            ),
            /* Loding will go here */
            SpinKitDoubleBounce(
              color: Colors.white,
              size: 50.0,
            )
          ],
        ),
      ),
    );
  }
}

String randomLine() {
  var rng = new Random();
  return lines[rng.nextInt(lines.length)];
}

List<String> lines = [
  "Untap, Upkeep, Draw",
  "Traveling to Hanamura",
  "This loading is a line",
  "They see me loading, They waiting",
  "Asking the chef for recipes",
  "Skipping cutscenes",
  "Shuffling the deck",
  "Returning the slab",
  "now with scratch and sniff",
  "Looking for the power button",
  "Look behind you",
  "Locating Wumpus",
  "Loading Simulation",
  "Jumping to hyperspace",
  "Is this thing on?",
  "Initiating launch sequence",
  "If you are reading this, you can read",
  "I swear it's around here somewhere...",
  "Loading machine broke",
  "Get ready for a surprise!",
  "Do you even notice these?",
  "Opening the loading bay doors",
  "Charging spirit bomb",
  "Charging Limit Break",
  "Calibrating flux capacitors",
  "Buckle up!",
  "Are we there yet?",
  "A brawl is surely brewing!",
  "*Elevator Music Plays*",
  "Wizard needs food badly",
  "Decrypting Engrams",
  "Achieving Nirvana",
  "Calling Aus for help..."
];
