
class Algorithm implements IAlgorithm {
   
   States state;
   int updateTime;
   int timer;
   Point startPoint;
   Point targetPoint;
   Grid grid;
   ArrayList<Point> queue;
   boolean[][] used; 
   
   Algorithm() {
      Init();
   } 
   
   void Init() {
      state = States.Stopped;
      queue = new ArrayList<Point>();
      timer = 0; 
      used = new boolean[0][0];
   }
  
   void Start() {
      if (state == States.Stopped) {
         state = States.Running;
      } 
   }
   
   void Stop() {
      if (state == States.Running) {
         state = States.Stopped; 
      }
   }
   
   void Restart() {
      state = States.Stopped;
      queue = new ArrayList<Point>();
      queue.add(startPoint);
      used = new boolean[grid.gHeight][grid.gWidth];
      timer = 0;
      grid.RefreshGrid();
      grid.gridArray[startPoint.y][startPoint.x] = 2;
      grid.gridArray[targetPoint.y][targetPoint.x] = 3;
   }
   
   void Step() {
      println("Algorithm");
   }
   
   void Draw() {
     
   }
   
}