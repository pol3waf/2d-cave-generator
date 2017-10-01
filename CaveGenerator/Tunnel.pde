public class Tunnel
{
  
  private ArrayList<Coordinate> path = new ArrayList();
  final private int[][] grid; 
  final int stone = 0;
  
  
  // construct with 
  public Tunnel(int[][] grid, int startX, int startY)
  {
    this.path.add(new Coordinate(startX, startY));
    this.grid = grid;
  }
  
  
  
  /**
   * random path .... rally random ....
   */
  public void createRandomPath(int turnProbability, int maxPathLength, int maxX, int maxY)
  {
    int pathLength = 0;
    PVector carveV = new PVector(1,0);
    
    // set the initial random direction
    carveV.rotate( HALF_PI * ((int)random(3) ) );
    
    // carve a path/ tunnel tile by tile
    while (pathLength < maxPathLength)
    {
      pathLength++;
      
      // choosing the current direction
      float turnScore = random(100);
      if (turnScore < turnProbability)
      {
        carveV = rotateRotateVector(carveV);
      }
      
      // create the path while taking the direction into account
      Coordinate lastCoordinate = getLastCoordinate(this.path);
      PVector newPos = carveV.copy();
      newPos.add(lastCoordinate.getX(), lastCoordinate.getY());
      if ( (newPos.x > 0) && (newPos.y > 0) && (newPos.x < maxX) && (newPos.y < maxY) )
      {
        // add new coordinte to the path if the new coordinate is not out of bounds
        this.path.add( new Coordinate( (int)(newPos.x), (int)(newPos.y) ) );
      }
    }
  }
  
  
  
  
  
  /**
   * random path that takes the environment into consideration ...
   */
  public void createRandomPath_withEnd(int turnProbability, int maxPathLength)
  {
    int pathLength = 0;
    PVector carveV = new PVector(1,0);
    Coordinate nextCoordinate;
    boolean hitWall = false;
    
    // set the initial random direction
    carveV.rotate( HALF_PI * ((int)random(3) ) );
    
    // move until hitting a wall
    while (hitWall == false)
    {
      nextCoordinate = moveInDirection(carveV);
      if ( checkCoordinateInBounds(nextCoordinate) )
      {
        if (grid[nextCoordinate.x][nextCoordinate.y] == this.stone)
        {
          hitWall = true;
        }
        else
        {
          this.path.add(nextCoordinate);
        }
      }
      else
      {
        carveV.rotate( HALF_PI * ((int)random(3) ) );
      }
    }
    
    // carve a tunel through wall
    while (pathLength < maxPathLength && hitWall == true)
    {
      
      pathLength++;
      
      // choosing the current direction
      float turnScore = random(100);
      if (turnScore < turnProbability)
      {
        carveV = rotateRotateVector(carveV);
      }
      
      
      // create the path while taking the environment and direction into account
      nextCoordinate = moveInDirection(carveV);
      if ( checkCoordinateInBounds(nextCoordinate) )
      {
        if (grid[nextCoordinate.x][nextCoordinate.y] != this.stone)
        {
          hitWall = false;
        }
        else
        {
          this.path.add(nextCoordinate);
        }
      }
    }
  }
  
  
  
  
  
  
  
  
  public ArrayList<Coordinate> getPath()
  {
    return this.path;
  }
  
  
  
  public String toString()
  {
    String values = "";
    
    for (Coordinate c : this.path)
    {
      values += c.getX() + ":" + c.getY() + " ; ";
    }
    
    return values;
  }
  
  
  
  // random rotate vector by 90 degree
  private PVector rotateRotateVector(PVector vector)
  {
    PVector v = vector.copy();
    float directionHint = random(-1, 1);
    if (directionHint >= 0)
    {
      v.rotate(HALF_PI);
    }
    else
    {
      v.rotate(-HALF_PI);
    }
    return v;
  }
  
  
  
  // get last Coordinate in path
  private Coordinate getLastCoordinate(ArrayList<Coordinate> path)
  {
    int lastX = this.path.get( this.path.size() - 1 ).getX();
    int lastY = this.path.get( this.path.size() - 1 ).getY();
    Coordinate lastCoordinate = new Coordinate (lastX, lastY);
    return lastCoordinate;
  }
  
  
  // check coordinate whether coordinates are in bounds
  private boolean checkCoordinateInBounds(Coordinate coordinate)
  {
    return ( 
             (coordinate.x > 0) && 
             (coordinate.y > 0) && 
             (coordinate.x < grid.length) && 
             (coordinate.y < grid[1].length) 
           ); 
  }
  
  
  private Coordinate moveInDirection(PVector direction)
  {
    Coordinate lastCoordinate = getLastCoordinate(this.path);
    PVector nextPos = direction.copy();
    nextPos.add(lastCoordinate.getX(), lastCoordinate.getY());
    Coordinate nextCoordinate = new Coordinate( (int)nextPos.x, (int)nextPos.y );
    
    return nextCoordinate;
  }

  
  
}