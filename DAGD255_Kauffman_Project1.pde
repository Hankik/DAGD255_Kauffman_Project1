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
import javax.swing.JOptionPane;
import java.util.Map;
import java.util.HashMap;

// Initialize global objects
Frog frog;
ArrayList<Bug> bugList = new ArrayList();
ArrayList<Popup> popUps = new ArrayList();
float dt;
float prevTime = 0;
boolean isPaused = false;
PImage log;
PImage swamp;

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

  frog = new Frog();
  log = loadImage("log.png");
  swamp = loadImage("swamp.jpg");
  swamp.resize(1200, 800);

  for (int i = 0; i < 10; i++) {
    Bug f = new Bug();
    bugList.add(f);
    loop();
  }
}

// Primary game loop
void draw() {

  background(BLUE);
  calcDeltaTime();

  image(swamp, 0, 0);
  image(log, width/2 - 64, height/2 - 16);

  frog.update();

  for (Bug f : bugList) {
    f.getDistanceFromFrog(frog);
    f.update();
  }

  cullBugs();
  
  for (Popup p : popUps){
    p.update();
  }
  
  
  frog.draw();
  for (Bug f : bugList) {
    f.draw();
  }
  
  for (Popup p : popUps){
    p.draw();
  }
  
  cullPopUps();
}

void cullBugs() {
  for (int i = bugList.size() - 1; i >= 0; i--) {
    if (bugList.get(i).isDead) {      
      popUps.add(new Popup(bugList.get(i).location.x, bugList.get(i).location.y, "+3", 20));
      bugList.remove(i);
      println("bugList: " + bugList.size());
    }
  }
}

void cullPopUps() {

  for (int i = popUps.size() - 1; i >= 0; i--) {
  
    if (popUps.get(i).isDead) {
    
      popUps.remove(i);
      println("popUps: " + popUps.size());
    }
  }
}

// A method to get delta time
void calcDeltaTime() {

  float currTime = millis();
  dt = (currTime - prevTime) / 1000;
  prevTime = currTime;
}

void mousePressed() {
  frog.mousePressed();
}

void mouseReleased() {
  frog.mouseReleased();
  if (frog.tongue.state == TongueState.ATTACK) {
    for (Bug fly : bugList) {
      if (fly.body.checkCollision(fly.location.x, fly.location.y, mouseX, mouseY)) {
        frog.tongue.target = fly;
        fly.mouseReleased();
        break;
      }
    }
  }
}

public void keyPressed() {
  if (key == 'p') {
    isPaused = !isPaused;

    if (isPaused) noLoop();
    else loop();
  }
}
