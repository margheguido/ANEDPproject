function [errors,solutions,femregion,Dati]=C_main2D(TestName,nRef)
%==========================================================================
% Solution of the Poisson's problem with linear finite elements
% (non homogeneous Dirichlet boundary conditions)
%==========================================================================
%
%    INPUT:
%          Dati        : (struct)  see C_dati.m
%          nRef        : (int)     refinement level
%
%    OUTPUT:
%          errors      : (struct) contains the computed errors
%          solutions   : (sparse) nodal values of the computed and exact
%                        solution
%          femregion   : (struct) infos about finite elements
%                        discretization
%          Matrices    : (struct) fe stiffness and mass matrices
%          Dati        : (struct)  see C_dati.m
%          
% Usage: 
%    [errors,solutions,femregion,Matrices,Dati] = C_main2D('Test1',3)
 


addpath Assembly
addpath BoundaryConditions
addpath Errors
addpath MeshGeneration
addpath FESpace
addpath Postprocessing


%==========================================================================
% LOAD DATA FOR TEST CASE
%==========================================================================

Dati = C_dati(TestName);
Dati.nRefinement = nRef;

%==========================================================================
% MESH GENERATION
%==========================================================================

[Region] = C_create_mesh(Dati);

%==========================================================================
% FINITE ELEMENT REGION
%==========================================================================

[femregion] = C_create_femregion(Dati,Region); 

%==========================================================================
% BUILD FINITE ELEMENT MATRICES and RIGHT-HAND SIDE
%==========================================================================

%add the Build of the mass matrix
[M_no_bc,A_no_bc,b_no_bc] = C_matrix2D(Dati,femregion);
 %M and A does not depend on time 
 
 %time integration: we need to know the initial time( suppose it eq to 0) 
 %final time 
 
 t = 0;
 T = Dati.T;
 dt = Dati.dt;
 theta = Dati.theta;
 
 %initial condition evaluated in x and y (nodal points)
 x = femregion.coord(:,1);
 y = femregion.coord(:,2);
 
 %evaluation of initial condition 
 u0 = eval(Dati.initialcond);
  
 %I plot the initial solution
 C_snapshot_sol(femregion, u0, Dati,t)
 
 %lhs matrix
 K_no_bc = M_no_bc+theta*dt*A_no_bc;
 
 %evaluation of force wrt time 
 f0 = eval(Dati.forcetime);
 
 for t = dt : dt : T 
    %evaluation of force wrt time in t(k+1)
    f1 = eval(Dati.forcetime);
 
    %rhs
    f_no_bc= (M_no_bc - (1 - theta)*dt*A_no_bc)*u0...
          + dt * (theta*b_no_bc *f1 + (1 - theta)*b_no_bc*f0);
      
     
    %======================================================================
    % COMPUTE BOUNDARY CONDITIONS -- MODIFICATION OF A an b
    %======================================================================

    [K,f,u_g] = C_bound_cond2D(K_no_bc,f_no_bc,femregion,Dati,t);

    %======================================================================
    % SOLVE THE LINEAR SYSTEM
    %======================================================================
    %you can also do the factorization of the matrix outside the time loop 
    %and use it at each step to solve the linear system (the matrix does
    %not depend on time)
    
    u1 = K\f;

    %======================================================================
    % ASSIGN DIRICHLET BOUNDARY CONDITIONS -- through the lifting ug
    %======================================================================

    u1 = u1 + u_g;
    
    %plot the current solution
    C_snapshot_sol(femregion, u1, Dati,t)
    
    %update for the next step
    f0 = f1;
    u0 = u1;
    
 %end of time integration 
 end
%==========================================================================
% POST-PROCESSING OF THE SOLUTION
%==========================================================================

[solutions] = C_postprocessing(Dati,femregion,u1,t);

%==========================================================================
% ERROR ANALYSIS
%==========================================================================
errors = [];

%we compute the error wrt the space for a fixed istant 

if (Dati.plot_errors)
    [errors] = C_compute_errors(Dati,femregion,solutions,t);
end



