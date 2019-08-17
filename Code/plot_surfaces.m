clear all
close all

%% uh
[errors,solutions,femregion,Dati,Peclet,tau]=C_main2D('Test1',5,10000000,1e-5);

% from C_pointwise_sol.m
dof=femregion.dof;
x1=femregion.domain(1,1);
x2=femregion.domain(1,2);
y1=femregion.domain(2,1);
y2=femregion.domain(2,2);

figure;
trisurf(femregion.connectivity(1:3,:)', femregion.coord(:,1),...
        femregion.coord(:,2), full(solutions.uh));
axis([x1,x2,y1,y2,-3.6,2.6]);

%% Exact solution
figure
load('8ref_solutions')
load('8ref_femregion')
trisurf(femregion.connectivity(1:3,:)',femregion.coord(:,1),...
        femregion.coord(:,2),full(solutions.u_ex),...
        'EdgeColor','none');
axis([x1,x2,y1,y2,-3.6,2.6]);

