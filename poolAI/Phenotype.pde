class Phenotype {
  game g;
  float fitness, score;
  int hit;
  Genotype gene;
  boolean isthisdone;
  Phenotype(PVector _pos, float _w, float _h, Box2DProcessing _world) {
    g = new game(_pos, _w, _h, _world);
    gene = new Genotype();
    hit = 0;
    isthisdone = false;
  }
  Phenotype(PVector _pos, float _w, float _h, Box2DProcessing _world, Genotype _gene) {
    g = new game(_pos, _w, _h, _world);
    gene = new Genotype();
    hit = 0;
    isthisdone = false;
    gene = _gene.copy();
  }
  void show() {
    g.show();
  }
  void run() {
    g.update();
    if (g.done()) {
      if (hit < gene.dna.length && !g.isout) {
        g.hit(gene.dna[hit]);
        hit++;
      } else {
        isthisdone = true;
      }
    }
  }
  void calfitness(float maxscore) {
    if (maxscore != 0) {
      fitness = map(g.score, 0, maxscore, 0, 10);
    } else {
      fitness = 1;
    }
    for (int i = 0; i < g.balls.size(); i++) {
      PVector pos = g.balls.get(i).pos;
      float mindist = 100000;
      for (int j = 0; j < g.t.ho.length; j++) {
        PVector pos2 = g.t.ho[j].pos;
        if (dist(pos.x, pos.y, pos2.x, pos2.y) < mindist) {
          mindist = dist(pos.x, pos.y, pos2.x, pos2.y);
        }
      }
      if (mindist < 100) {
        fitness +=0.05;
      }
    }
    if (!g.isvalid) {
      fitness = 0;
    } else if (g.isvalid && g.is8in) {
      fitness = 15;
      if (gamenotcomplete) {
        frameRate(60);
        gamenotcomplete = false;
      }
    }
    fitness = pow(fitness, fitness);
  }
}
