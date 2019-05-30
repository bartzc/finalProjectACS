import static java.lang.System.*;
import java.util.LinkedList;

import java.io.File;
import java.io.IOException;
import java.util.Map;
import java.util.TreeMap;
import static java.lang.System.*;

private TreeMap<Integer, String> northmenMap = new TreeMap<Integer, String>();
private TreeMap<Integer, String> unsulliedMap = new TreeMap<Integer, String>();


PImage chart, unsullied, northmen, ironThrone;
boolean choice = true;
boolean unsulliedOpt = false;
boolean northmenOpt = false;
boolean finalStage = false;
boolean optRight = false, optLeft = false, alive = false, dead = false, chartshow = false;
int x = 0, y=0, tracker = 1;
String finalMessage = "";

void setup() {
  background(0);
  size(720, 1080);
  unsullied = loadImage("greyworm.jpg");
  northmen = loadImage("jonSnow1.jpg");
  chart = loadImage("chart.jpg");
  chart.resize(720,544);
  ironThrone = loadImage("Iron_throne.jpg");
  ironThrone.resize(720, 1080);
  northmen.resize(235, 400);
  unsullied.resize(235, 400);




  //creating trees
  northmenMap.put(1, "flee to Castle or stay in courtyard?-flee-stay-alive");
  northmenMap.put(2, "Sneak past wrights in library or attack them?-sneak-attack-alive");
  northmenMap.put(3, "The northmen were slaughtered in the courtyard-dead");
  northmenMap.put(4, "The northmen sneak past and survive the battle-alive");
  northmenMap.put(5, "The northmen are greatly outnumbered and the attack fails-dead");



  unsulliedMap.put(1, "Retreat to saftey or stay and defend the castle-retreat-stay-alive");
  unsulliedMap.put(2, "Stop in the courtyard with northmen or retreat to the crypts?-stay-retreat-alive");
  unsulliedMap.put(3, "Die defending the courtyard-dead");
  unsulliedMap.put(4, "Survive inside the crypts-alive");
  unsulliedMap.put(5, "Die defending the walls-dead");
}


void draw() {
  image(ironThrone, 0, 0);
  if (choice) {
    drawing();
  } else if(choice==false&&chartshow==false) {
    if (optLeft) {
      tracker+=1;
      optLeft = false;
    }
    if (optRight) {
      tracker+=2;
      optRight= false;
    }
    drawing(tracker);
  }
  else{
   image(chart, 0,300); 
  }
  println(mouseX+" "+mouseY);
}



void mousePressed() {
  boolean bol = true;
  if (choice) {
    String option = checker(bol);

    if (parseInt(option)<360) {
      unsulliedOpt = true;
    } else if (parseInt(option)>360) {
      northmenOpt = true;
    }
    choice = false;
  } else {
    String option = checker(bol);
    if (parseInt(option)>360) {
      optRight = true;
      optLeft = false;
    } else if (parseInt(option)<360) {
      optRight = false;
      optLeft = true;
    }
  }
  if(choice == false && finalStage == true){
    String option = checker(bol);
    if(parseInt(option)<360){
     choice = true;
     finalStage = false;
     alive = false;
     dead = false;
     unsulliedOpt = false;
     northmenOpt = false;
    }else{
     chartshow=true;
      
    }
    
    
  }
}
void drawing(int stage) {
  if (finalStage==false) {
    if (unsulliedOpt) {
      String[] lines = unsulliedMap.get(stage).split("-");
      textSize(50);
      text("Status: ", 100, 100);
      if (lines[lines.length-1].equals("dead")) {
        fill(224, 32, 11);
        finalStage=true;
        dead = true;
        finalMessage = lines[0];
      } else if (lines[lines.length-1].equals("alive") && lines.length ==4 ) {
        fill(10, 219, 73);
        text(lines[lines.length-1], 300, 100);
        fill(0);
        textSize(25);
        text(lines[0], 20, 200);
        text(lines[1], 50, 250);
        text(lines[2], 400, 250);
      } else if (lines[lines.length-1].equals("alive") && lines.length ==2 ) {
        //fill(10, 219, 73);
        //text(lines[lines.length-1], 300, 100);
        //text(lines[0], 20, 200);
        finalMessage = lines[0];
        finalStage = true;
        alive = true;
      }
    }





    if (northmenOpt) {
      String[] lines = northmenMap.get(stage).split("-");
      textSize(50);
      text("Status: ", 100, 100);
      if (lines[lines.length-1].equals("dead")) {
        fill(224, 32, 11);
        finalStage=true;
        dead = true;
        finalMessage = lines[0];
      } else if (lines[lines.length-1].equals("alive") && lines.length ==4 ) {
        fill(10, 219, 73);
        text(lines[lines.length-1], 300, 100);
        fill(0);
        textSize(25);
        text(lines[0], 20, 200);
        text(lines[1], 50, 250);
        text(lines[2], 400, 250);
      } else if (lines[lines.length-1].equals("alive") && lines.length ==2 ) {
        //fill(10, 219, 73);
        //text(lines[lines.length-1], 300, 100);
        //text(lines[0], 20, 200);
        finalMessage = lines[0];
        finalStage = true;
        alive = true;
      }
    }
  } else {
    if (alive) {
      fill(10, 219, 73);
      text("alive", 300, 100);
      text(finalMessage, 20, 200);
    }else{
      fill(224, 32, 11);
      text("dead", 300, 100);
      text(finalMessage, 20, 200);
    }
    fill(0);
    text("play again?", 80, 800);
    text("See chart", 460, 800);
  }
}

void drawing() {
  fill(0);
  rect(115, 225, 235, 400);
  rect(370, 225, 235, 400);
  image(unsullied, 115, 225);
  image(northmen, 370, 225, 235, 400);
}



String checker(boolean bol) {
  while (bol) {
    x = mouseX;
    bol = false;
  }
  return x+"";
}
