class Graph {
  ArrayList<Node> nodes;

  Graph() {
    nodes = new ArrayList<Node>();
  } 
  void addNode(PVector position) {
    nodes.add(new Node(position));
  } 
  void show() {
    for (Node node : nodes) {
      node.show();
    }
  } 
  void addEdge(Node a, Node b) {
    a.edges.add(b);
    b.edges.add(a);
  }
} 
