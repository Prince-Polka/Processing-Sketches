void setrow(int n, int state) {
  int keep;
  int born;
  for (int i=indexes[n]; i<indexes[n+1]; i++) {
    keep = sortedrules[i+256];
    born = sortedrules[i];
    
    if (state == 0) {
      rule = rule.clearBit(keep);
      rule = rule.clearBit(born);
    }
    if (state == 1) {
      rule = rule.setBit(keep);
      rule = rule.clearBit(born);
    }
    if (state == 2) {
      rule = rule.setBit(keep);
      rule = rule.setBit(born);
    }
    if (state == 3) {
      rule = rule.clearBit(keep);
      rule = rule.setBit(born);
    }
    button[i].stateFromRule();
  }
}