/*
 Project 1 - Game
 Hank Kauffman - DAGD 255
 1/9/2023
 
 Copyright 2023 Henry Kauffman
 
 Licensed under the Apache License, Version 2.0 (the "License");
 you may not use this file except in compliance with the License.
 You may obtain a copy of the License at
 
 http://www.apache.org/licenses/LICENSE-2.0
 
 Unless required by applicable law or agreed to in writing, software
 distributed under the License is distributed on an "AS IS" BASIS,
 WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
 See the License for the specific language governing permissions and
 limitations under the License.
 */

// Grab libraries
import java.util.Map;
import java.util.HashMap;
import processing.sound.*;

// Initialize global objects
Data data = Data.getInstance();

final int LEVEL_AMOUNT = 2;
Level[] levels = new Level[2];

int currentLevel = 0; // 0 - 1 levels
int waspsEaten;

float dt;
float prevTime = 0;
PImage swamp;
SoundFile crunch;
SoundFile bgMusic;
SoundFile select;

boolean isPaused = false;
boolean leftPressed = false;

// Color constants
final color RED = #bf616a;
final color ORANGE = #d08770;
final color YELLOW = #ebcb8b;
final color GREEN = #a3be8c;
final color PURPLE = #b48ead;
final color BLUE = #5e81ac;
final color WHITE = #eceff4;
final color BLACK = #3b4252;
final color BROWN = #9e6257;
final color LIGHTGREEN = #d9e68f;
final color PINK = #db96ad;
final color LIGHTBLUE = #92cade;
final color LIGHTRED = #FF8C8C;
final color TONGUE = #c0003f;

// Setup project
void setup() {
  size(1200, 800);

  for (int i = 0; i < LEVEL_AMOUNT; i++) {
    levels[i] = new Level(i);
  }
  
  crunch = new SoundFile(this, "handleCoins2.wav");
  bgMusic = new SoundFile(this, "swampRock.wav");
  select = new SoundFile(this, "bookFlip3.wav");
  select.amp(.03);
  bgMusic.amp(.03);
  crunch.amp(.05);

  frameRate(120);
  swamp = loadImage("swamp.jpg");
  swamp.resize(width, height);
}

// Primary game loop
void draw() {
  
  if (!bgMusic.isPlaying()) bgMusic.play();

  background(BLUE);
  calcDeltaTime();

  image(swamp, 0, 0);

  if (!isPaused) {

    levels[currentLevel].update();
  }

  levels[currentLevel].draw();
  if (isPaused){
    levels[currentLevel].updateMenu(); // update and draw level menu seperately
  }
}

// A method to get delta time
void calcDeltaTime() {

  float currTime = millis();
  dt = (currTime - prevTime) / 1000;
  prevTime = currTime;
}

void keyPressed() {
  if (!isPaused) {

    if (key == '>') {
      currentLevel++;
      if (currentLevel >= levels.length) currentLevel = 0;
      levels[currentLevel].popups.add(new Popup(width*.25, height*.25, "Level: " + Integer.toString(currentLevel), 40.0));
    }
  }
  if (key == TAB || key == ESC || key == 'p') {
    isPaused = !isPaused;
  }
}

void mousePressed() {
  if (!isPaused) {
    levels[currentLevel].mousePressed();
    
    
  }
  if (mouseButton == LEFT) leftPressed = true;
}

void mouseReleased() {
  if (!isPaused) {
    levels[currentLevel].mouseReleased();
    
    
  }
  if (mouseButton == LEFT) leftPressed = false;
}
