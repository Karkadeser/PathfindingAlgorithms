Grid grid;
int lastMillis;
ArrayList<Algorithm> algorithms;

void setup() {
   size(640, 640);
   lastMillis = millis();
   algorithms = new ArrayList<Algorithm>();
   grid = new Grid(20, 20);
   algorithms.add(new BFS(grid, new Point((int)random(0, grid.gWidth), (int)random(0, grid.gHeight)), 
                                new Point((int)random(0, grid.gWidth), (int)random(0, grid.gHeight)), 1));
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