class golbutton{
  int posx;
  int posy;
  int i;
  int keepbit; // which bit in rule this button actives, at the index where middle bit is set
  int bornbit; // which bit in rule this button actives, at the index where middle bit is NOT set
  int setbits;
  int margin=box/2;
  int size=box*4;
  int state; // dead alive born
  boolean alive;
  boolean mob;
  boolean borner;
  color statecolor[] = {#ff0000,#ffff00,#00ff00,#0000ff};
  
  int stateFromRule(){
    int a = (rule.testBit(keepbit)?1:0) + (rule.testBit(bornbit)?2:0);
    if(a==2){a++;}
    else if(a==3){a--;}
    return a;
  }
  golbutton(int I){
    i=I;
    bornbit=sortedrules[I];
    keepbit=sortedrules[I+256];
    setbits=ones(keepbit);
    state = stateFromRule();
    alive=rule.testBit(keepbit);
    posx=500+box/2+(i%16)*size;
    posy=box/2+(i/16)*size;
  }
void toggle(){
  state++;
  state%=4;
  if (state == 0){
    rule = rule.clearBit(keepbit);
    rule = rule.clearBit(bornbit);
  }
  if (state == 1){
    rule = rule.setBit(keepbit);
    rule = rule.clearBit(bornbit);
  }
  if (state == 2){
    rule = rule.setBit(keepbit);
    rule = rule.setBit(bornbit);
  }
  if (state == 3){
    rule = rule.clearBit(keepbit);
    rule = rule.setBit(bornbit);
  }
}
  void show(){
    mob = (mouseX>posx && mouseX<posx+size && mouseY>posy && mouseY<posy+size);
    if(mob && click){toggle();}
    fillcolor=statecolor[state];
    //if(mob){fillcolor=#ffff00;}
    if(setbits%2==0 && state==0){fillcolor=#ffaaaa;}
    fill(fillcolor);
    rect(posx,posy,box*4,box*4);
 
 for (int j=0; j<9; j++){
   fillcolor = ((bornbit>>j)&1) == 1 ? #000000 : #ffffff;
   fill(fillcolor);
   rect(posx+margin+(j%3)*box,posy+margin+j/3*box,box,box);
 }
  }
}