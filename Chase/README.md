This is a program that implements steering behaviours.
The ellipse constantly follows the mouse due to seeking force.
First i create a vector for the ellipse and another for the mouse.
Than i use the seeking logic,that is i subtract the mouse vector by the ellipse vector,which gives 
me the vector that points from the ellipse to the mouse.This new vector is the desired vector.And then i 
subtract the velocity vector from the desired vector.This gives you a force for steering it toward the mouse.Eventually,
it reaches the mouse,but does not stop moving because i haven't added the arriving code which i shall add in a later project.
