
int box = 150;
boolean mpa;
int timestyped;
long typedword;
String[] numface = { "new","abc", "def", "ghi", "jkl", "mno", "pqrs", "tuv", "wxyz" };
void setup(){
size(450,450,P2D);
}
void draw(){
for (int i=0; i<9; i++){
  rect(i%3*box,i/3*box,box,box);
  text(numface[i],i%3*box+box/2,i/3*box+box/2);
}
if(mousePressed && !mpa){
  int temp = mouseX/box + mouseY/box*3;
  if(temp==0){
    timestyped = 0;
    typedword = 0;
  }
  if(temp>=1 && temp<=8){
    
    typedword+=pow(10,timestyped)*temp;
    println(typedword);
    timestyped++;
    
  }
  
}
mpa = mousePressed;
}