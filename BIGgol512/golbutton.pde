class golbutton{
  int posx;
  int posy;
  int i;
  int margin=box/2;
  int size=box*4;
  boolean alive;
  boolean mob;
  golbutton(int I){
  i=I;
  alive=rule.testBit(i);
  posx=500+box/2+(i%32)*size;
  posy=box/2+(i/32)*size;
}
void toggle(){
  alive=!alive;
  if(alive){ rule = rule.setBit(i);}
  else     { rule = rule.clearBit(i);}
}
  void show(){
    mob = (mouseX>posx && mouseX<posx+size && mouseY>posy && mouseY<posy+size);
    if(mob && click){toggle();}
    fillcolor=alive? #00ff00 : #ff0000;
    if(mob){fillcolor=#ffff00;}
    fill(fillcolor);
    rect(posx,posy,box*4,box*4);
 
 for (int j=0; j<9; j++){
   fillcolor = ((i>>j)&1) == 1 ? #000000 : #ffffff;
   fill(fillcolor);
   rect(posx+margin+(j%3)*box,posy+margin+j/3*box,box,box);
 }
  }
}