function plot_sol( fig, femregion, uh )
%% plot_sol( femregion, uh, Dati )
%==========================================================================
% PLOT THE SOLUTION ON THE DOFS
%==========================================================================
%    called in C_postprocessing.m
%
%    INPUT:
%          femregion   : (struct)  see C_create_femregion.m
%          uh          : (sparse(ndof,1) real) solution vector
%



dof=femregion.dof;

x1=femregion.domain(1,1);
x2=femregion.domain(1,2);
y1=femregion.domain(2,1);
y2=femregion.domain(2,2);

M=max(uh);
m=min(uh);
if (abs(m-M) < 0.1)
    M=m+1;
end
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%% VISUALIZZAZIONE DELLE SOLUZIONI MESHATE  %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
fig;
trisurf(femregion.connectivity(1:3,:)',femregion.coord(:,1),femregion.coord(:,2),full(uh));
title('u_h(x,y)'); xlabel('x-axis'); ylabel('y-axis');
axis([x1,x2,y1,y2,m,M]); colorbar;
