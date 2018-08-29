class Node {
  char station;
  PVector pos;
  ArrayList<Node> edges;
  color col = 0;
  boolean visited = false;
  float dijDist = 100000000;
  Node parent = null;
  float gCost = 100000000;
  float fCost = 100000000;
  Node(PVector _pos) {
    pos = _pos.get();
    edges = new ArrayList<Node>();
  } 
  void show() {
    noFill();
    stroke(col);
    strokeWeight(12);
    point(pos.x, pos.y);
    fill(0);
    textSize(20);
    //text(station, pos.x, pos.y - 10);
    strokeWeight(2);
    stroke(0);
    for (Node neighbor : edges) {
      float midX = (pos.x + neighbor.pos.x) / 2;
      float midY = (pos.y + neighbor.pos.y) / 2;
      int d = int(PVector.dist(pos, neighbor.pos));
      textSize(20);
      fill(0);
      text(d, midX, midY - 10);
      line(pos.x, pos.y, neighbor.pos.x, neighbor.pos.y);
    }
  } 
  //for beam
  ArrayList<Node> get2Best() {
    ArrayList<Node> sortedNeighbors = getNeighbors();
    ArrayList<Node> best2 = new ArrayList<Node>();
    best2.add(sortedNeighbors.get(0));
    return best2;
  } 
  
  //for hillclimbing
  ArrayList<Node> getNeighbors() {
    PriorityQueue<Node> pq = new
      PriorityQueue<Node>(5, new NodeComparator());

    for (Node node : edges) {
      pq.add(node);
    } 
    ArrayList<Node> sortedNeighbors = new ArrayList<Node>();
    while (!pq.isEmpty()) {
      sortedNeighbors.add(pq.poll());
    }
    return sortedNeighbors;
  }
}

class NodeComparator implements Comparator<Node> {

  // Overriding compare()method of Comparator 
  // for descending order of cgpa
  public int compare(Node s1, Node s2) {
    float d1 = PVector.dist(s1.pos, graph.nodes.get(endNodeIndex).pos);
    float d2 = PVector.dist(s2.pos, graph.nodes.get(endNodeIndex).pos);
    if (d1 < d2)
      return 1;
    else if (d1 > d2)
      return -1;
    return 0;
  }
}
