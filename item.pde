
class icomp implements Comparator<word> {
  public int compare( word a, word b ) {
  return a.num < b.num ? -1 : a.num == b.num ? 0 : 1;
 }
}

class word{
String str;
long num;
word(String STR, long NUM) {
       str=STR;  num=NUM; }
}