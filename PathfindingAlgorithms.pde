Grid grid;
int lastMillis;
ArrayList<Algorithm> algorithms;

void setup() {
   size(640, 640);
   lastMillis = millis();
   algorithms = new ArrayList<Algorithm>();
   grid = new Grid(20, 20);
   Point sPoint = new Point((int)random(0, grid.gWidth), (int)random(0, grid.gHeight));
   Point tPoint = new Point((int)random(0, grid.gWidth), (int)random(0, grid.gHeight));
   algorithms.add(new BFS(grid, sPoint, tPoint, 1));
   algorithms.add(new BFSEurisitc(grid, sPoint, tPoint, 1));
   AddObstacles((int)random(0, grid.gWidth * grid.gHeight / 2));
}  

void draw() {
   background(18);
   grid.Draw();
   for (Algorithm a : algorithms) {
      a.Draw(); 
   }
   if (millis() > lastMillis) {
      lastMillis = millis();
      Tick();
   }
}

void Tick() {
  for (Algorithm a : algorithms) {
     if (a.state == IAlgorithm.States.Stopped) {
        continue; 
     }
     a.timer += 1;
     if (a.timer >= a.updateTime) {
        a.timer = 0;
        a.Step();
     }
  }
}

void keyPressed() {
   switch (key) {
      case ' ': 
        for (Algorithm a : algorithms) {
           if (a.state == IAlgorithm.States.Stopped)
              a.Start(); 
           else if (a.state == IAlgorithm.States.Running)
              a.Stop(); 
        }
      break;
      case 'r':
        for (Algorithm a : algorithms) {
           a.Restart(); 
        }
      break;
      case 'g':
        grid = new Grid(grid.gWidth, grid.gHeight);
        Point sPoint = new Point((int)random(0, grid.gWidth), (int)random(0, grid.gHeight));
        Point tPoint = new Point((int)random(0, grid.gWidth), (int)random(0, grid.gHeight));
        while (sPoint == tPoint) {
           tPoint = new Point((int)random(0, grid.gWidth), (int)random(0, grid.gHeight)); 
        }
        for (Algorithm a : algorithms) {
           a.startPoint = sPoint;
           a.targetPoint = tPoint;
           a.grid = grid;
           a.Restart();
           AddObstacles((int)random(0, grid.gWidth * grid.gHeight / 2));
        }
      break;
      case 's':
        if (algorithms.isEmpty() == false) {
           algorithms.get(0).state = IAlgorithm.States.Stopped;
           algorithms.get(0).Step();
        }
      break;
   }
}

void AddObstacles(int amount) {
   int counter = 0;
   while (counter < amount) {
      Point point = new Point((int)random(0, grid.gWidth), (int)random(0, grid.gHeight));
      while (grid.gridArray[point.y][point.x] == 2 || grid.gridArray[point.y][point.x] == 3) {
         point = new Point((int)random(0, grid.gWidth), (int)random(0, grid.gHeight));   
      }
      grid.gridArray[point.y][point.x] = -1;
      counter += 1;
   }
}