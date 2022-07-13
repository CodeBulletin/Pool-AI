class AI {
  Phenotype[] creature;
  Phenotype best_creature;
  Genotype best_dna;
  table show;
  int genration = 0;
  Box2DProcessing[] box2d;
  Box2DProcessing useless, best_world;
  PApplet canvas;
  float maxscore, maxfit, totalfitness;
  boolean makeit, a;
  AI(PApplet _canvas) {
    gamenotcomplete = true;
    makeit = false;
    a = false;
    best_creature = null;
    canvas = _canvas;
    maxscore = 0;
    maxfit = 0;
    totalfitness = 0;
    box2d = new Box2DProcessing[w_popsize];
    creature = new Phenotype[w_popsize];
    useless = new Box2DProcessing(canvas);
    useless.createWorld();
    useless.setGravity(0, 0);
    best_dna = null;
    show = new table(new PVector(width/2, height/2), height/2+58, height-26, useless);
    for (int i = 0; i < w_popsize; i++) {
      box2d[i] = new Box2DProcessing(canvas);
      box2d[i].createWorld();
      box2d[i].setGravity(0, 0);
      creature[i] = new Phenotype(new PVector(width/2, height/2), height/2+58, height-26, box2d[i]);
    }
  }
  void run() {
    show.show();
    push();
    fill(255, 150);
    noStroke();
    if (a) {
      textSize(40);
      text("calculating the best!", width/2, height/2);
    } else if (bestmode && gamenotcomplete) {
      textSize(40);
      text("best of genration : "+str(genration), width/2, height/2);
    } else if (bestmode && !gamenotcomplete) {
      textSize(60);
      text("best found: ", width/2, height/2);
    } else {
      textSize(100);
      text(str(genration+1), width/2, height/2);
    }
    pop();
    if (bestmode) {
      if (best_creature != null) {
        best_creature.show();
        best_creature.run();
        if(best_creature.isthisdone && saveframe){
          best_creature = null;
          best_dna = null;
          makeit = false;
          a = false;
          isframe = 0;
        }
        if (!makeit) {
          makeit = true;
          a = false;
        }
      } else if (!makeit) {
        a = true;
      }
    }
    for (int i = 0; i < w_popsize; i++) {
      if (!bestmode) {
        creature[i].show();
      }
      creature[i].run();
    }
    if (alldone()) {
      evaluate();
      selection();
      genration++;
    }
  }
  void evaluate() {
    maxscore = -1;
    for (int i = 0; i < w_popsize; i++) {
      float sc = creature[i].g.score;
      if (sc > maxscore) {
        maxscore = sc;
      }
    }
    maxfit = -1;
    for (int i = 0; i < w_popsize; i++) {
      creature[i].calfitness(maxscore);
      float maxs = creature[i].fitness;
      if (maxs > maxfit) {
        maxfit = maxs;
        best_dna = creature[i].gene;
      }
    }
    totalfitness = 0;
    for (int i = 0; i < w_popsize; i++) {
      creature[i].fitness = creature[i].fitness/maxfit;
      creature[i].fitness *= 100;
      totalfitness += creature[i].fitness;
    }
    if (bestmode) {
      best_world = new Box2DProcessing(canvas);
      best_world.createWorld();
      best_world.setGravity(0, 0);
      best_creature = new Phenotype(new PVector(width/2, height/2), height/2+58, height-26, best_world, best_dna.copy());
    }
  }
  void selection() {
    Phenotype[] new_creature = new Phenotype[creature.length];
    for (int j = 0; j < w_popsize; j++) {
      float r = random(totalfitness);
      float sums = 0;
      for (int i = 0; i < w_popsize; i++) {
        sums+=creature[i].fitness;
        if (sums > r) {
          box2d[i] = new Box2DProcessing(canvas);
          box2d[i].createWorld();
          box2d[i].setGravity(0, 0);
          Genotype geno = creature[i].gene.copy();
          if ((genration+1)%updateaf == 0 && gamenotcomplete) {
            geno.addhit(best_dna.dna);
          }
          if (gamenotcomplete) {
            geno.mutate();
          }
          new_creature[j] = new Phenotype(new PVector(width/2, height/2), height/2+58, height-26, box2d[i], geno);
          break;
        }
      }
    }
    for (int j = 0; j < w_popsize; j++) {
      creature[j].g.killall();
      creature[j] = null;
    }
    creature = new_creature;
  }
  boolean alldone() {
    for (int i = 0; i < w_popsize; i++) {
      if (!creature[i].isthisdone) {
        return false;
      }
    }
    return true;
  }
}
