function [errors_table,rates]=C_convergence_test_time(test_name)
%% [errors_table,rates]=C_convergence_test(test_name)
%==========================================================================
% Error analysis varying the mesh size h 
%==========================================================================
% Example of usage: [errors_table,rates] = C_convergence_test_time('Test1')
%
%    INPUT:
%          test_name    : (string)  test case name, see C_dati.m
%
%    OUTPUT:
%          errors_table : (struct) containing the computed errors
%          rates        : (struct) containing the computed rates


warning off;
addpath Assembly
addpath BoundaryConditions
addpath Errors
addpath MeshGeneration
addpath FESpace
addpath Postprocessing


Dati=C_dati(test_name);

refinement_vector=Dati.refinement_vector;
num_test=length(refinement_vector);
dt=[];
for k=1:4
    
    Dati=C_dati(test_name);
    dtk=Dati.dt/(2^(k-1));
    dt=[dt dtk];
    [errors,solutions,femregion,Dati]=C_main2D_errors(test_name,4,dtk);
    Error_L2(k)=errors.Error_L2;
    Error_SEMI_H1(k)=errors.Error_SEMI_H1;
    Error_H1(k)=errors.Error_H1;
    Error_inf(k)=errors.Error_inf;
    ne(k)=femregion.ne;    
   
    fprintf('==========================================\n');    
    fprintf('End test %i\n',k);
    fprintf('==========================================\n');
end
p=femregion.degree;

%ERROR TABLE
errors_table=struct('ne',ne,...
                   'dt',dt,...
                   'Error_L2', Error_L2,...
                   'Error_SEMI_H1', Error_SEMI_H1,...
                   'Error_H1', Error_H1,...
                   'Error_inf',Error_inf);


               
%TABLE
rate_L2=log10(Error_L2(2:num_test)./Error_L2(1:num_test-1))./log10(dt(2:num_test)./dt(1:num_test-1));
rate_SEMI_H1=log10( Error_SEMI_H1(2:num_test)./ Error_SEMI_H1(1:num_test-1))./log10(dt(2:num_test)./dt(1:num_test-1));
rate_H1=log10( Error_H1(2:num_test)./ Error_H1(1:num_test-1))./log10(dt(2:num_test)./dt(1:num_test-1));
rate_inf=log10( Error_inf(2:num_test)./ Error_inf(1:num_test-1))./log10(dt(2:num_test)./dt(1:num_test-1));

rates=struct('rate_L2',rate_L2,...
             'rate_SEMI_H1',rate_SEMI_H1,...
             'rate_H1',rate_H1,...
             'rate_inf',rate_inf);
         

% ERROR PLOTS
hs = subplot(2,1,1);
loglog(dt,dt,'-+b','Linewidth',2);
hold on
loglog(dt,Error_L2,'-or','Linewidth',2);
hold on
legend(sprintf('h^%i',p+1),'||.||_{L^2}');
title ('Errors');
ylabel('L^2-error')
xlabel('h');
hs.FontSize = 12;

hs = subplot(2,1,2);
loglog(dt,dt.^2,'-+b','Linewidth',2);
hold on
loglog(dt,Error_H1,'-or','Linewidth',2);
hold on
legend(sprintf('h^%i',p+1),'||.||_{H^1}');
ylabel('H^1-error')
xlabel('h');
hold off
hs.FontSize = 12;
