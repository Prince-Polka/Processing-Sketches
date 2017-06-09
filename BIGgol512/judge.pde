boolean judge(int d,int midx,int midy) {
  if ( closerThan(10,midx,midy,mouseX/cellsize,mouseY/cellsize) ){
    return true;
  }
    int up=(midy+xyz-1)%xyz;  
    int down=(midy+xyz+1)%xyz; 
    int left=(midx+xyz-1)%xyz; 
    int right=(midx+1)%xyz; 
    boolean[][]f = fields[swap];
    codeArray[0]=f[left][up];
    codeArray[1]=f[midx][up];
    codeArray[2]=f[right][up];
    codeArray[3]=f[left][midy];
    codeArray[4]=f[midx][midy];
    codeArray[5]=f[right][midy];
    codeArray[6]=f[left][down];
    codeArray[7]=f[midx][down];
    codeArray[8]=f[right][down];
    int state = 0;
    for (int i=0; i<9; i++){
      state+= codeArray[i]?(int(pow(2,i))):0;
    }
    //store = color(255-state/2);
    store = rule.testBit(state)?#000000:#ffffff;
    return rule.testBit(state);
}