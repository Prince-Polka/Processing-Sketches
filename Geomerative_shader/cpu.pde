// If there are any points
  /*if(points != null){
    noFill();
    stroke(0,200,0);
    RPoint jump = points[0];
    int ju=0;
    int len = points.length;
    boolean jum =false;
    for(int i=0; i<len; i++){
      RPoint A = points[i];
      RPoint B = points[(i+1)%len];
      RPoint C = points[(i+2)%len];
      jum = A.x == jump.x && A.y == jump.y;
      if(jum && i!=ju){
        jump=C;
        ju=i+2;
        if(frameCount%30<15){i++; continue;}
        else{fill(#ff0000);
        ellipse(A.x,A.y,3,3);}
    }
      line(A.x,A.y,B.x,B.y);
    }
    
    fill(0);
    stroke(0);
  }*/