class Genotype {
  PVector[] dna;
  int hit;
  Genotype() {
    dna = new PVector[1];
    dna[0] = PVector.random2D();
    hit = dna.length;
  }
  Genotype(PVector[] _dna) {
    dna = _dna;
    hit = dna.length;
  }
  void addhit(PVector[] best_dna) {
    hit++;
    PVector[] ndna = new PVector[dna.length+1];
    for (int i = 0; i<dna.length; i++) {
      ndna[i] = best_dna[i];
    }
    ndna[hit-1] = PVector.random2D();
    dna = ndna;
  }
  Genotype copy() {
    PVector[] ndna = new PVector[dna.length];
    for (int i = 0; i<dna.length; i++) {
      ndna[i] = dna[i];
    }
    return new Genotype(ndna);
  }
  void mutate() {
    float r = random(1);
    if (r < w_mutate_rate) {
      dna[hit-1] = PVector.random2D();
    }
  }
}
