/* 
  Project 1 - Mouse-based Arcade Game
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

// Initialize global objects
Frog frog;

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
void setup(){
  size(1200,800);
  
  frog = new Frog();
  
}

// Primary game loop
void draw(){
  background(0);
  
  frog.update();
}
