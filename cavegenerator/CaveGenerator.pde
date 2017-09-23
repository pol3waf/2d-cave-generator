public class CaveGenerator
{
  
  
  public CaveGenerator()
  {
    
  }
  
  
  public void drawCave(
      int scaleFactor, 
      int totalWidth, 
      int totalHeight, 
      int iterations,
      int fillPropability,
      int seeds,
      int turnProbability,
      int maxTunnelLength
      )
  {
    int sizeX = totalWidth / scaleFactor;
    int sizeY = totalHeight / scaleFactor;
    
    println("grid has size:\t" + sizeX + ":" + sizeY);
    
    int[][] grid = randomFill(sizeX, sizeY, fillPropability);
    delate(grid, 0, 255, iterations);
    carveTunnels(grid, seeds, turnProbability, 255, maxTunnelLength);
    drawArrayData(grid);
  }
  
  
  /**
   * create and array of certain dimensions and fill with random binary values
   * depending on a given probability
  **/
  public int[][] randomFill(int sizeX, int sizeY, int fillPropability)
  {
    int[][] grid = new int[sizeX][sizeY];
    float fillScore = 0;
    
    for (int i=0; i<sizeX; i++)
    {
      for (int j=0; j<sizeY; j++)
      {
        fillScore = random(100);
        if (fillScore < fillPropability)
        {
          grid[i][j] = 255;
        }
        else
        {
          grid[i][j] = 0;
        }
      }
    }
    
    return grid;
  }
  
  
  /**
   * draw the data of an array onto the canvas ... 
   */
  private void drawArrayData(int[][] grid)
  {
    int sizeX = grid.length;
    int sizeY = grid[1].length;
    println("sizeX = " + sizeX);
    println("sizeY = " + sizeY);
    
    float cellX = width / sizeX;
    float cellY = width / sizeY;
    println("cellX = " + cellX);
    println("cellY = " + cellY);
    
    noStroke();
    
    
    for (int i=0; i<sizeX; i++)
    {
      for (int j=0; j<sizeY; j++)
      {
        fill(grid[i][j]);
        rect(i*cellX, j*cellY, (i+1)*cellX, (j+1)*cellY);
      }
    }
  }
  
  
  /**
   * dilate ... or something like that ...
   */
  private int[][] delate(int[][] grid, int value1, int value2, int iterations)
  {
    int sizeX = grid.length;
    int sizeY = grid[1].length;
    int iter = 0;
    while (iter < iterations)
    {
      iter++;
      
      for(int i=1; i<(sizeX - 1); i++)
      {
        for (int j=1; j<(sizeY - 1); j++)
        {
          if (
              grid[i-1][j] == value1 && grid[i+1][j] == value1 || 
              grid[i][j-1] == value1 && grid[i][j+1] == value1 /*||
              grid[i-1][j] == value1 && grid[i-1][j-1] == value1 && grid[i][j-1] == value1 ||
              grid[i-1][j] == value1 && grid[i-1][j+1] == value1 && grid[i][j+1] == value1 ||
              grid[i+1][j] == value1 && grid[i+1][j+1] == value1 && grid[i][j+1] == value1 ||
              grid[i+1][j] == value1 && grid[i+1][j-1] == value1 && grid[i][j-1] == value1*/
              )
          { 
            grid[i][j] = value1;
          }
          if (
              grid[i-1][j] == value2 && grid[i+1][j] == value2 || 
              grid[i][j-1] == value2 && grid[i][j+1] == value2 /*||
              grid[i-1][j] == value2 && grid[i-1][j-1] == value2 && grid[i][j-1] == value2 ||
              grid[i-1][j] == value2 && grid[i-1][j+1] == value2 && grid[i][j+1] == value2 ||
              grid[i+1][j] == value2 && grid[i+1][j+1] == value2 && grid[i][j+1] == value2 ||
              grid[i+1][j] == value2 && grid[i+1][j-1] == value2 && grid[i][j-1] == value2*/
              )
          { 
            grid[i][j] = value2;
          }
        }
      }
    }
    
    return grid;
  }
  
  
  
  /**
   * carve tunnels by checking out several caves and digging until another cave is found.
   */
  private int[][] carveTunnels(int[][] grid, int seeds, int turnProbability, int fieldValue, int maxTunnelLength)
  {
    int sizeX = grid.length;
    int sizeY = grid[1].length;
    
    // should probably use a list of touples ... not an array ....
    ArrayList<Tunnel> tunnels = new ArrayList();
    
    // set seed locations - repeat seeds that are set on rock/ void
    int numberOfTunnels = 0;
    while (numberOfTunnels < seeds)
    {
      int locX = (int)random(1, sizeX - 1);
      int locY = (int)random(1, sizeY - 1);    
      if (grid[locX][locY] == fieldValue)
      {
//        println("adding tunnel to cave at \t" + locX + "; " + locY); 
        tunnels.add(new Tunnel(grid, locX, locY));
        numberOfTunnels++;
      }
    }
    
    // start digging from each tunnelStart to some other Cave and integrate paths into grid 
    for (Tunnel tunnel : tunnels)
    {
      // digging ...
//      println("tunnels-list contains tunnel with start position: " + tunnel.toString());
//      tunnel.createRandomPath(turnProbability, maxTunnelLength, sizeX - 1 , sizeY - 1);
      tunnel.createRandomPath_withEnd(turnProbability, maxTunnelLength);
      println("tunnels-list contains tunnel with path: " + tunnel.toString());
      
      // integrate into grid ...
      for (Coordinate c : tunnel.getPath())
      {
        grid[c.getX()][c.getY()] = fieldValue;
      }
    }
    
    

    
    return grid;
  }
  

}