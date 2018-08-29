import java.util.*;

ArrayList<Node> dfs() {
  Stack<Node> stack = new Stack<Node>();
  stack.push(graph.nodes.get(startNodeIndex));
  while (!stack.isEmpty()) {
    Node current =  stack.pop();
    if (current == graph.nodes.get(endNodeIndex)) {
      ArrayList<Node> pathDfs = new ArrayList<Node>();
      current = graph.nodes.get(endNodeIndex);
      while (current.parent != null) {
        pathDfs.add(current);
        current = current.parent;
      } 
      pathDfs.add(graph.nodes.get(startNodeIndex));
      return pathDfs;
    } 
    //if (!current.visited) {
    current.visited = true;
    //}
    for (Node neighbor : current.edges) {
      if (!neighbor.visited) {
        neighbor.parent = current;
        stack.push(neighbor);
      }
    }
  }
  return null;
} 

class DijkstraComparator implements Comparator<Node> {

  // Overriding compare()method of Comparator 
  // for descending order of cgpa
  public int compare(Node s1, Node s2) {
    if (s1.dijDist > s2.dijDist)
      return 1;
    else if (s1.dijDist  < s2.dijDist)
      return -1;
    return 0;
  }
}

ArrayList<Node> dijkstra() {
  graph.nodes.get(startNodeIndex).dijDist = 0;
  PriorityQueue<Node> pq = new PriorityQueue<Node>(new DijkstraComparator());
  pq.add(graph.nodes.get(startNodeIndex));
  while (!pq.isEmpty()) {
    Node current = pq.remove();
    if (current == graph.nodes.get(endNodeIndex)) {
      ArrayList<Node> dijkstraPath = new ArrayList<Node>();
      current = graph.nodes.get(endNodeIndex);
      while (current.parent != null) {
        dijkstraPath.add(current);
        current = current.parent;
      } 
      dijkstraPath.add(graph.nodes.get(startNodeIndex));
      return dijkstraPath;
    } 
    current.visited = true;
    for (Node neighbor : current.edges) {
      if (!neighbor.visited) {
        float newNeighborDist = current.dijDist + PVector.dist(neighbor.pos, current.pos);
        if (neighbor.dijDist > newNeighborDist) {
          neighbor.dijDist = newNeighborDist;
          neighbor.parent = current;
        }
        pq.add(neighbor);
      }
    }
  }
  return null;
} 

float heuristic(Node node1, Node node2) {
  return PVector.dist(node1.pos, node2.pos);
} 

class AstarComparator implements Comparator<Node> {

  // Overriding compare()method of Comparator 
  // for descending order of cgpa
  public int compare(Node s1, Node s2) {
    if (s1.fCost > s2.fCost)
      return 1;
    else if (s1.fCost  < s2.fCost)
      return -1;
    return 0;
  }
}

ArrayList<Node> astar() {
  graph.nodes.get(startNodeIndex).gCost = 0;
  graph.nodes.get(startNodeIndex).fCost = heuristic(graph.nodes.get(startNodeIndex), graph.nodes.get(endNodeIndex));
  PriorityQueue<Node> pq = new PriorityQueue<Node>(new AstarComparator());
  pq.add(graph.nodes.get(startNodeIndex));
  while(!pq.isEmpty()) {
    Node current = pq.remove();
    if (current == graph.nodes.get(endNodeIndex)) {
      ArrayList<Node> astarPath = new ArrayList<Node>();
      current = graph.nodes.get(endNodeIndex);
      while (current.parent != null) {
        astarPath.add(current);
        current = current.parent;
      } 
      astarPath.add(graph.nodes.get(startNodeIndex));
      return astarPath;
    } 
    current.visited = true;
    for (Node neighbor : current.edges) {
      if (neighbor.visited) {
        continue;
      } 
      float tempGCost = current.gCost + heuristic(current, neighbor);
      if (!pq.contains(neighbor)) {
        pq.add(neighbor);
      } else if (tempGCost >= neighbor.gCost) {
        continue;
      } 
      //this is much more short path to the neighbor
      neighbor.parent = current;
      neighbor.gCost = tempGCost;
      neighbor.fCost = neighbor.gCost + heuristic(neighbor, graph.nodes.get(endNodeIndex));
      
    } 
  } 
  return null;
} 


ArrayList<Node> hillClimb() {
  Stack<Node> stack = new Stack<Node>();
  stack.push(graph.nodes.get(startNodeIndex));
  while (!stack.isEmpty()) {
    Node current = stack.pop();
    if (current == graph.nodes.get(endNodeIndex)) {
      ArrayList<Node> pathHillClimb = new ArrayList<Node>();
      current = graph.nodes.get(endNodeIndex);
      while (current.parent != null) {
        pathHillClimb.add(current);
        current = current.parent;
      } 
      pathHillClimb.add(graph.nodes.get(startNodeIndex));
      return pathHillClimb;
    } 
    current.visited = true;
    ArrayList<Node> neighbors = current.getNeighbors();
    for (Node neighbor : neighbors) {
      if (!neighbor.visited) {
        neighbor.parent = current;
        stack.push(neighbor);
      }
    }
  }
  return null;
} 


ArrayList<Node> beam() {
  Queue<Node> queue = new LinkedList<Node>();
  Node current = graph.nodes.get(startNodeIndex);
  current.visited = true;
  queue.add(current);
  while (!queue.isEmpty()) {
    current = queue.peek();
    queue.remove();
    if (current == graph.nodes.get(endNodeIndex)) {
      ArrayList<Node> pathBeam = new ArrayList<Node>();
      current = graph.nodes.get(endNodeIndex);
      while (current.parent != null) {
        pathBeam.add(current);
        current = current.parent;
      } 
      pathBeam.add(graph.nodes.get(startNodeIndex));
      return pathBeam;
    }
    ArrayList<Node> neighbors = current.getNeighbors();
    Collections.reverse(neighbors);
    for (Node neighbor : neighbors) {
      if (!neighbor.visited) {
        neighbor.parent = current;
        neighbor.visited = true;
        queue.add(neighbor);
      }
    }
    
  } 
  return null;
} 


ArrayList<Node> bfs() {
  Queue<Node> queue = new LinkedList<Node>();
  Node current = graph.nodes.get(startNodeIndex);
  current.visited = true;
  queue.add(current);
  while (!queue.isEmpty()) {
    current = queue.peek();
    queue.remove();
    if (current == graph.nodes.get(endNodeIndex)) {
      ArrayList<Node> pathBfs = new ArrayList<Node>();
      current = graph.nodes.get(endNodeIndex);
      while (current.parent != null) {
        pathBfs.add(current);
        current = current.parent;
      } 
      pathBfs.add(graph.nodes.get(startNodeIndex));
      return pathBfs;
    }
    for (Node neighbor : current.edges) {
      if (!neighbor.visited) {
        neighbor.parent = current;
        neighbor.visited = true;
        queue.add(neighbor);
      }
    }
  } 
  return null;
} 
