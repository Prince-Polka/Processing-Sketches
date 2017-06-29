import java.util.*;
//import java.util.Arrays.*;
word[] words;
String[] dictionary; 
String[] strings; 
String[] strNums; 
int dilen = 1000;
long[] nums;
String[] t9key = { "abcABC", "defDEF", "ghiGHI", "jklJKL", "mnoMNO", "pqrsPQRS", "tuvTUV", "wxyzWXYZ" };

String []lastTypedWord={""};

int box = 100;
boolean mpa;
int timestyped;
long typedword;
String all;
String[] numface = { "new","abc", "def", "ghi", "jkl", "mno", "pqrs", "tuv", "wxyz" };

void setup() {
  size(300,400,P2D);
  textSize(20);
  dictionary = loadStrings("dictionary.txt");
  dilen = dictionary.length;
  //diNum = new long[dilen];
  nums = new long[dilen];
  strings = new String[dilen];
  strNums = new String[dilen];
  words = new word[dilen];
  //make();
  loadwords();
  //noLoop();
}

void loadwords(){
  strings = loadStrings("numSortDict.txt");
  strNums = loadStrings("nums.txt");
  for (int w = 0; w<dilen; w++){
    //words[w] = new word (strings[w],Long.parseLong(nums[w]));
    nums[w] = Long.parseLong(strNums[w]);
  }
}

void draw(){
  background(0);
  
for (int i=0; i<9; i++){
  fill(230);
  rect(i%3*box,i/3*box,box,box);
  fill(0);
  text(numface[i],i%3*box+box/3,i/3*box+box/2);
}
fill(#00ff00);
all="";
for(int i=0; i<lastTypedWord.length;i++){
  all+=" "+lastTypedWord[i];
}
text(all,20,350);
if(mousePressed && !mpa){
  int temp = mouseX/box + mouseY/box*3;
  if(temp==0){
    timestyped = 0;
    typedword = 0;
  }
  if(temp>=1 && temp<=8){
    typedword*=10;
    typedword+=temp;
    lastTypedWord = range(typedword);
    timestyped++;
  }
}
mpa = mousePressed;
}