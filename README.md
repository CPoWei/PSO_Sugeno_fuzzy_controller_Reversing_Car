# PSO in reversing car with sugeno(TSK) type fuzzy controller
Train fuzzy controller with Particle Swarm Optimization for reversing car

Overview : 
1. Here is sugeno type fuzzy control model.
2. The file called “SUGENOwithPSO.m” is the main code.
3. Following the main code guide, the GA will start to evolve our fuzzy controller to reach our goal!

Our goal :
1. The goal is reversing the car(represented as a triangle, the sharp angle is the head of the car) to the location around  
   (50,100) with the angle "phi"(calculated from the x-axis to the axis that crosses the head and the tail of the car) around 
   90 degrees.
2. Minimizing "docking_error", which is defined as below: ![alt tag](https://user-images.githubusercontent.com/34533532/34327542-6aa61a3c-e902-11e7-9d0c-e9cd5ab02fac.png)

   X_f is equals to 50, Y_f is equals to 100 and Phi_f is equals to 90 degrees.
3. You can find there are a "trajectory_error" in the code, which is only used for seeing how efficiency of the car reversing.![alt tag](https://user-images.githubusercontent.com/34533532/34327543-6acdebd4-e902-11e7-9ac2-8074a83912bf.png)

Parameter : 
1. X is ranges from 0 to 100
2. Y is ranges from 0 to 100
3. Phi is ranges from -90 to 270 degrees
4. Theta(represented as the angle of the tire can rotate) is ranges from -30 to 30 degrees

Insight : 
1. The "global outstanding" term in the particle velocity formula has a parameter "C2", which should be greater than "C1"(in "local outstanding term")
2. "C1" and "C2" should be range from 0 to 5.

Learning Curve : 
![alt tag](https://user-images.githubusercontent.com/34533532/34327541-6a731682-e902-11e7-9a6f-7a65b94a709a.png)
