function [A,f,Peclet]=C_matrix2D(Dati,femregion)
%% [A,f] = C_matrix2D(Dati,femregion)
%==========================================================================
% Assembly of the stiffness matrix A and rhs f
%==========================================================================
%    called in C_main2D.m
%
%    INPUT:
%          Dati        : (struct)  see C_dati.m
%          femregion   : (struct)  see C_create_femregion.m
%
%    OUTPUT:
%          A           : (sparse(ndof,ndof) real) stiffnes matrix
%          f           : (sparse(ndof,1) real) rhs vector


addpath FESpace
addpath Assembly

fprintf('============================================================\n')
fprintf('Assembling matrices and right hand side ... \n');
fprintf('============================================================\n')


% connectivity infos
ndof         = femregion.ndof; % degrees of freedom
nln          = femregion.nln;  % local degrees of freedom
ne           = femregion.ne;   % number of elements
connectivity = femregion.connectivity; % connectivity matrix


% shape functions
[basis] = C_shape_basis(Dati);

% quadrature nodes and weights for integrals
[nodes_2D, w_2D] = C_quadrature(Dati);

% evaluation of shape bases 
[dphiq,Grad] = C_evalshape(basis,nodes_2D);


% Assembly begin ...
A = sparse(ndof,ndof);  % Global Stiffness matrix
f = sparse(ndof,1);     % Global Load vector

for ie = 1 : ne
    
    % Local to global map --> To be used in the assembly phase
    iglo = connectivity(1:nln,ie);
  
    % BJ        = Jacobian of the elemental map 
    % pphys_2D = vertex coordinates in the physical domain   
    [BJ, pphys_2D] = C_get_Jacobian(femregion.coord(iglo,:), nodes_2D, Dati.MeshType);
   
    %=============================================================%
    % STIFFNESS MATRIX
    %=============================================================%
    % SUPG stabilization parameter
    tau_SUPG = calculate_tau_SUPG( femregion, pphys_2D, Dati );
    Peclet(ie) = calculate_Peclet( femregion, Dati, pphys_2D );
    
    
    % Local stiffness matrix 
    [ A_diff ] = C_A_diff_2D( BJ, w_2D, Grad, nln );
    [ A_reac ] = C_A_reac_2D( BJ, w_2D, dphiq, nln );
    [ A_adv ] = C_A_adv_2D( BJ, w_2D, pphys_2D, Grad, dphiq, nln, Dati );
    [ A_SUPG ] = C_A_SUPG_2D( BJ, w_2D, pphys_2D, Grad, nln, Dati ,Peclet(ie));

    % Assembly phase for stiffness matrix
    A( iglo, iglo ) = A( iglo, iglo ) + Dati.mu * A_diff + ...
                                        A_adv + ...
                                        Dati.sigma * A_reac + ...
                                        Dati.stab * tau_SUPG * A_SUPG;
    
    %==============================================
    % FORCING TERM --RHS
    %==============================================

    % Local load vector
    [ load ] = C_load( BJ, w_2D, pphys_2D, dphiq, nln, Dati );    
    [ load_SUPG ] = C_load_SUPG( BJ, w_2D, pphys_2D, nln, Grad, Dati );
    
    % Assembly phase for the load vector
    f( iglo ) = f( iglo ) + load + Dati.stab * tau_SUPG * load_SUPG;

end
