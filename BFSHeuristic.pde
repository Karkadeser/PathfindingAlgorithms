
class BFSHeurisitc extends Algorithm { 
    
   int[][] bfsArray;
   BFSHeurisitc(Grid _grid, Point sPoint, Point tPoint, int _updateTime) {
      Init();
      grid = _grid;
      startPoint = sPoint;
      targetPoint = tPoint;
      updateTime = _updateTime;
      used = new boolean[grid.gHeight][grid.gWidth];
      bfsArray = new int[grid.gHeight][grid.gWidth];
      queue.add(startPoint);
      for (int i = 0; i < grid.gHeight; i++) {
         for (int j = 0; j < grid.gWidth; j++) {
            bfsArray[i][j] = grid.gWidth * grid.gHeight; 
         }
      }
      bfsArray[startPoint.y][startPoint.x] = 0;
      grid.gridArray[startPoint.y][startPoint.x] = 2;
      grid.gridArray[targetPoint.y][targetPoint.x] = 3;
   }
   
   void Restart() {
      super.Restart();
      for (int i = 0; i < grid.gHeight; i++) {
         for (int j = 0; j < grid.gWidth; j++) {
            bfsArray[i][j] = grid.gWidth * grid.gHeight; 
         }
      }
      bfsArray[startPoint.y][startPoint.x] = 0;
   }
   
   void Draw() {
      for (Point p : queue) {
         fill(140, 100, 100, 100);
         rect(grid.cWidth * p.x, grid.cHeight * p.y, grid.cWidth, grid.cHeight); 
      }
      if (state == States.Running) {
         for (int i = 0; i < grid.gHeight; i++) {
            for (int j = 0; j < grid.gWidth; j++) {
               if (used[i][j] == true) {
                  fill(90, 40, 40, 100);
                  rect(grid.cWidth * j, grid.cHeight * i, grid.cWidth, grid.cHeight); 
               }
            }
         }
      }
   }
   
   float Distance(Point a, Point b) {
      return sqrt(pow(a.x - b.x, 2) + pow (a.y - b.y, 2)); 
   }
   
   void Step() {
      if (queue.isEmpty() == false) {
         Point point = queue.get(0);
         queue.remove(0);
         used[point.y][point.x] = true;
         boolean found = false;
         for (int i = 0; i < 4; i++) {
            int x = -1, y = 0;
            switch (i) {
               case 0: x = -1; y = 0; break;
               case 1: x = 1;  y = 0; break;
               case 2: x = 0;  y = -1; break;
               case 3: x = 0;  y = 1; break;
            }
            if (targetPoint.x == point.x + x && targetPoint.y == point.y + y) {
               found = true;
               break;
            }
            if (point.x + x >= 0 && point.x + x < grid.gWidth) {
               if (point.y + y >= 0 && point.y + y < grid.gHeight) {
                  Point p = new Point(point.x + x, point.y + y);
                  float distance1 = Distance(p, targetPoint);
                  if (used[p.y][p.x] == false) {
                     if (grid.gridArray[p.y][p.x] != -1) {
                        if (CheckQueue(p) == false) {
                           boolean added = false;
                           for (int t = 0; t < queue.size(); t++) {
                              float distance2 = Distance(queue.get(t), targetPoint);
                              if (distance2 > distance1) {
                                 queue.add(t, p);   
                                 added = true;
                                 break;
                              }
                           }
                           if (added == false) {
                              queue.add(p); 
                           }
                           if (bfsArray[point.y + y][point.x + x] > bfsArray[point.y][point.x] + 1) {
                              bfsArray[point.y + y][point.x + x] = bfsArray[point.y][point.x] + 1;
                           }
                        }
                     }
                  }
               }
            }  
         }
         if (found == true) {
            queue.clear();
            queue.add(targetPoint);
            while (queue.isEmpty() == false) {
               point = queue.get(0);
               queue.remove(0);
               int minX = 0, minY = 0;
               for (int i = 0; i < 4; i++) {
                  int x = -1, y = 0;
                  switch (i) {
                     case 0: x = -1; y = 0; break;
                     case 1: x = 1;  y = 0; break;
                     case 2: x = 0;  y = -1; break;
                     case 3: x = 0;  y = 1; break;
                  }
                  if (point.x + x >= 0 && point.x + x < grid.gWidth) {
                     if (point.y + y >= 0 && point.y + y < grid.gHeight) {
                        if ((minX == 0 && minY == 0) || bfsArray[point.y + y][point.x + x] < bfsArray[point.y + minY][point.x + minX]) {
                           minX = x;
                           minY = y;
                        }
                     }
                  }
               }
               if (point.x + minX == startPoint.x && point.y + minY == startPoint.y) {
                  Stop();
                  break; 
               }
               grid.gridArray[point.y + minY][point.x + minX] = 1;
               queue.add(new Point(point.x + minX, point.y + minY));
            }
         }
      }
   }
   
   boolean CheckQueue(Point point) {
      for (Point p : queue) {
         if (p.x == point.x && p.y == point.y) {
            return true; 
         }
      }
      return false;
   }
}