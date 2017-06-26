String[] range(long n){
 String[] output;
 int len = nums.length-1;
 int l,r,index;
     l=r=index = binarysearch(n,nums);
 long L,C,R;
      L=C=R = nums[index];
 while(L == C || C == R){
 if( L == C ){ l = min(max(0, l-1), len); }
 if( R == C ){ r = min(max(0, r+1), len); }
 L = nums[l];
 R = nums[r];
 }
 if(l<index){l++;}
 if(r<=index){r++;}
 int delta = r-l;
 output = new String[delta];
 for (int i=0; i<delta; i++){
   output[i]=strings[i+l];
 }
 return output; 
}

int binarysearch(long n, long[] list){
 int len = list.length-1;
 int min = 0; 
 int max = len;
 int guess = (min+max)/2;
 long G = list[guess];
 while(n!=G){
   if (n>G) { min = guess+1; }
     else   { max = guess-1; }
   if(min>max){break;}
   guess = (min+max) / 2;
   G = list[min(max(0, guess), len)];
 }
 return guess;
}