class Item {
  float x; 
  float y;
  float r;
  float w;
  float h;
  int number;
  //boolean obstruct = false;
  float ySpeed = 4;
  String tag = "";
  
  Item(float _x, float _y, String _tag, float _r) {
    x = _x;
    y = _y;
    tag = _tag;
    r = _r;
  }
   Item(float _x, float _y, String _tag, float _w, float _h, int _number) {
    x = _x;
    y = _y;
    tag = _tag;
    w = _w;
    h = _h;
    number = _number;
  } 
  void show() {
    
  } 
  void update() {
    //if (!obstruct) {
      y += ySpeed;
    //}
  } 
} 