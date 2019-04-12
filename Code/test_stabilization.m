close all
clear all

%% Test 1
nRef = 4;
for mu = [ 1e-3, 1e-9 ]
    % Test1
    Stab = 0;
    [~,solutions_nostab,femregion_nostab,~,Peclet_nostab] = C_main2D('Test1',nRef,Stab,mu);
    fig = figure;
    plot_sol( fig, femregion_nostab, solutions_nostab.uh )
    title( [ 'Test1, mu = ', num2str(mu) ] )

    % Test1 stabilized
    Stab = 1;
    [~,solutions_stab,femregion_stab,~,Peclet_stab] = C_main2D('Test1',nRef,Stab,mu);
    fig = figure;
    plot_sol( fig, femregion_stab, solutions_stab.uh )
    title( [ 'Test1 stabilized, mu = ', num2str(mu) ] )
end

%% Test 2
nRef = 4;
for mu = [ 1e-3, 1e-9 ]
    % Test2
    Stab = 0;
    [~,solutions_nostab,femregion_nostab,~,Peclet_nostab] = C_main2D('Test2',nRef,Stab,mu);
    fig = figure;
    plot_sol( fig, femregion_nostab, solutions_nostab.uh )
    title( [ 'Test2, mu = ', num2str(mu) ] )
    view( [ 1, 2, 2 ] ) 

    % Test2 stabilized
    Stab = 1;
    [~,solutions_stab,femregion_stab,~,Peclet_stab] = C_main2D('Test2',nRef,Stab,mu);
    fig = figure;
    plot_sol( fig, femregion_stab, solutions_stab.uh )
    title( [ 'Test2 stabilized, mu = ', num2str(mu) ] )
    view( [ 1, 2, 2 ] )
end

