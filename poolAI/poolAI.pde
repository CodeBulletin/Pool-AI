import shiffman.box2d.*;
import org.jbox2d.collision.shapes.*;
import org.jbox2d.common.*;
import org.jbox2d.dynamics.*;


static final int w_popsize = 200;
static final float w_mutate_rate = 0.4;
static final float updateaf = 5;
static final boolean saveframe = false;
boolean bestmode = true;
boolean fastmode = true;
int isframe = 0;
boolean gamenotcomplete;
int frameStep = 1;
AI ai;


float divFactor = 2.0;


void setup() {
  fullScreen(P2D);
  textAlign(CENTER);
  ai = new AI(this);
  setFrame();
}

void draw() {
  background(0);
  for(int i = 0; i < frameStep; i++) {
    ai.run();
  }
  if ((saveframe && ai.best_dna != null) && isframe == 1) {
    saveFrame("\\data\\MyFrame_#########.tga");
  } else if(saveframe && ai.best_dna != null && isframe < 1){
    isframe++;
  }
}

void keyPressed(){
  if(key == ' '){
    bestmode =! bestmode;
    setBest();
  }
  if(key == 'f'){
    fastmode =! fastmode;
    setFrame();
  }
}

void setFrame(){
  if(fastmode){
    frameStep = 20;
    //frameRate(1000);
  } else {
    frameStep = 1;
    //frameRate(60);
  }
}

void setBest(){
  if(bestmode){
    ai.best_creature = null;
    ai.makeit = false;
  }
}
