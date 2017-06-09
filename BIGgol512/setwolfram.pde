void reset(){
  fields = new boolean[2][xyz][xyz];
  for (int i=0; i<256; i++){
    button[i].stateFromRule();
 }
}
void setwolf(int w) {
  rule = new BigInteger("0"); 
  for (int i = 0; i<8; i++) {
    if (((w >> i)&1)==1) {
      for (int j =0; j<64; j++) {
        rule = rule.setBit(i+j*8);
      }
    }
  }
  reset();
}