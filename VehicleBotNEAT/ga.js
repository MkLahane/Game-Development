let bestBot = null;
function nextGeneration() {
    console.log("Next Generation");
    calculateFitness();
    let bestBotIndex = 0;
    let bestBotFitness = savedVehicles[0].fitness;
    for (let i = 1; i < savedVehicles.length; i++) {
      if (savedVehicles[i].fitness > bestBotFitness) {
        bestBotFitness = savedVehicles[i].fitness;
        bestBotIndex = i;
      }
    }
    if (bestBot == null) {
      bestBot = new Vehicle(savedVehicles[bestBotIndex].brain);
    } else {
      if (bestBot.fitness < bestBotFitness) {
        bestBot = new Vehicle(savedVehicles[bestBotIndex].brain);
      }
    }
  
    for (let i = 0; i < TOTAL_VEHICLES; i++) {
      // let mom = pickOne();
      // let dad = pickOne();
      // let child = mom.crossover(mom, dad);
      // let childVehicle = new Vehicle(child);
      // childVehicle.mutate(MUTATION_RATE);
      // vehicles[i] = childVehicle;
      vehicles[i] = pickOne(); 
    }
    for (let i = 0; i < TOTAL_VEHICLES; i++) {
      savedVehicles[i].dispose();
    }
    savedVehicles = [];
}
  
function calculateFitness() {
    let sum = 0;
    for (let vehicle of savedVehicles) {
      vehicle.calculateFitness();
    }
    for (let vehicle of savedVehicles) {
      sum += vehicle.fitness;
    }
    for (let vehicle of savedVehicles) {
      vehicle.fitness = vehicle.fitness / sum;
    }
    if (bestBot != null) {
      bestBot.calculateFitness();
      bestBot.fitness = bestBot.fitness / sum;
    }
    
}
// function pickOne() {
//   let r = random(1);
//   let index = 0;
//   while (r > 0) {
//     r -= savedVehicles[index].fitness;
//     index++;
//   }
//   index--;
//   let parentBrain = savedVehicles[index].brain;
//   return parentBrain;
//   //childVehicle.mutate(MUTATION_RATE);
//   //return childVehicle;
// }
  
function pickOne() {
    let r = random(1);
    let index = 0;
    while (r > 0) {
      r -= savedVehicles[index].fitness;
      index++;
    }
    index--;
    let parentBrain = savedVehicles[index].brain;
    let childVehicle = new Vehicle(parentBrain);
    // if (savedVehicles[index].finished) {
    //   return childVehicle;
    // }
    //return parentBrain;
    childVehicle.mutate(MUTATION_RATE);
    return childVehicle;
}