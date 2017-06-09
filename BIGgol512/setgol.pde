void conway(){
setrow(2,1);
setrow(3,2);
}

void setgolold(int[]stay,int[]born){
  boolean alive;
  int n;
  rule= new BigInteger("0");
  for (int i=0; i<512; i++){
    n=0;
    alive=((i>>4)&1)==1;
    for (int j=0; j<9; j++){
      if (j!=4){
      n+= (i >> j)&1;
      }
    }
    for (int j=0;j<stay.length;j++){
      if ( alive && n==stay[j] ) { 
      rule = rule.setBit(i); 
      break;
    }
    }
    for (int j=0;j<born.length;j++){
      if (n==born[j] ) { 
      rule = rule.setBit(i); 
      break;
    }
    }
  }
  
  
  }