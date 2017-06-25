void make (){
  String tempWord;
  String tempKey;
  char tempChar;
  char keyChar;
  long num;
  int wordLen;
  int keyLen;
  for (int w = 0; w < dilen; w++) {
    num=0;
    tempWord = dictionary[w];
    wordLen = tempWord.length();
    for (int c=0; c<wordLen; c++) {
      tempChar = tempWord.charAt(c);
      keyLoop:
      for (int k=0; k<8; k++) {
        tempKey = t9key[k];
        keyLen = tempKey.length();
        for ( int t=0; t<keyLen; t++) {
          keyChar = tempKey.charAt(t);
          if(tempChar == keyChar){
            num+=(k+1)*pow(10,wordLen-c-1);
            break keyLoop;
          }
        }
      }
    }
    //diNum[w]=num;
    words[w] = new word (tempWord,num);
    //println(num + " " + tempWord);
  }
  //java.util.Arrays.sort(diNum);
  java.util.Arrays.sort(words, new icomp() );
  
  for (int i = 0; i<dilen; i++){
    strings[i]=words[i].str;
    strNums[i]=String.valueOf(words[i].num);
  }
  saveStrings("data/nums.txt",strNums);
  saveStrings("data/numSortDict.txt",strings);
}