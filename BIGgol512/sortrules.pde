int ones(int input){
  int output=0;
  for (int i=0; i<9; i++){
    if(i!=4){
    output+=(input >> i)&1;
    }
  }
  if((input&16)==0){output-=9;}
  return output;
}
int leaveroom (int input){
  return leaveroom (input,1,4);
}
int leaveroom (int input,int bits, int spot){
  int output = input;
  output>>=spot;
  output<<=bits+spot;
  input&=((1<<spot)-1);
  output|=input;
  return output;
}
void sortrules(){
  for (int i=0; i<512; i++){
    sortedrules[i]=ones(i)<<9|i;
  }
  sortedrules=sort(sortedrules);
  for (int i=0; i<512; i++){
    sortedrules[i]=sortedrules[i]&511;
  }
  //println(sortedrules);
}