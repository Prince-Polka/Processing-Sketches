String find(long n){
 return strings[range(n,nums)]; 
}

int range(long n, long[] list) {
  int len = list.length;
  int pivot = len/2;
  int step = pivot/2;
  long A = list[pivot];
  long B = nums[min(len, pivot+1)];
  while ( n < A || n > B ) {
    if (n<A) { pivot-=step; }
    if (n>B) { pivot+=step; }
    step = max(1, step/2);
    A = list[min(max(0, pivot), len)];
    B = list[min(max(0, pivot+1), len)];
  }
  return pivot;
}