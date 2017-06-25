import java.util.*;
//import java.util.Arrays.*;
word[] words;
String[] dictionary; 
String[] strings; 
String[] strNums; 
int dilen = 1000;
long[] nums;
String[] t9key = { "abcABC", "defDEF", "ghiGHI", "jklJKL", "mnoMNO", "pqrsPQRS", "tuvTUV", "wxyzWXYZ" };

int box = 100;
boolean mpa;
int timestyped;
long typedword;
String[] numface = { "new","abc", "def", "ghi", "jkl", "mno", "pqrs", "tuv", "wxyz" };

void setup() {
  size(300,400,P2D);
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
for (int i=0; i<9; i++){
  fill(230);
  rect(i%3*box,i/3*box,box,box);
  fill(0);
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
    println(find(typedword));
    timestyped++;
  }
}
mpa = mousePressed;
}