
interface IAlgorithm {
   void Init();
   void Start();
   void Stop();
   void Restart();
   void Step();
   void Draw();
   enum States { Running, Stopped };
}