
class Grid {
 
   int[][] gridArray;
   int gWidth, gHeight;
   float cWidth, cHeight;
   Grid(int m, int n) {
      gridArray = new int[n][m];
      gWidth = m;
      gHeight = n;
      cWidth = width / (float)gWidth;
      cHeight = height / (float)gHeight;
   }
  
   void Draw() {
      for (int i = 0; i < gHeight; i++) {
         for (int j = 0; j < gWidth; j++) {
            stroke(200);
            fill(18);
            switch (gridArray[i][j]) {
               case 1:
                 fill(0, 100, 0);
               break;
               case 2:
                 fill(0, 0, 150);
               break;
               case 3:
                 fill (150, 0, 0);
               break;
            }
            rect(cWidth * j, cHeight * i, cWidth, cHeight);
         }
      }
   }
   
   void RefreshGrid() {
      gridArray = new int[gHeight][gWidth]; 
   }
}