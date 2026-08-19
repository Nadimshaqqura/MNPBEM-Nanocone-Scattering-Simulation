addpath( genpath( pwd ) );
clear all;
%very new%%  initialization
%  table of dielectric functions
epstab = { epsconst( 1 ), epstable( 'gold.dat' ),epstable( 'ito3.dat' ), epsconst(2.25)   };
%  location of interface of substrate and ito (50nm ito layer)
ztab = [50,0];

%  default options for layer structure
op = layerstructure.options; 
%  set up layer structure
layer = layerstructure( epstab, [ 1,3,4 ], ztab, op );
%  options for BEM simulations
op = bemoptions( 'sim', 'ret',  'interp', 'curv' , 'layer', layer );

%cone parameter
p=gen_cone(20,50,100,5,0.1);
figure(1)

plot( p, 'EdgeColor', 'k', 'nvec', 1 );

%  set up COMPARTICLE object
p = comparticle( epstab, { p }, [ 2, 1 ], 1, op )
%  shift nanosphere above substrate
p = shift( p, [ 0, 0, - min( p.pos( :, 3 ) )+ 1 + ztab(1) ] ); 





%  light propagation angles
theta = pi / 180 *89
%  , excitation from above
dir = [ sin( theta ), 0 * theta, - cos( theta ) ];
pol = [ cos( theta ), 0 * theta,   sin( theta ) ];
%  photon wavelengths
 enei = linspace( 500, 800, 30);

%%  tabulated Green functions
%  For the retarded simulation we first have to set up a table for the
%  calculation of the reflected Green function.  This part is usually slow
%  and we thus compute GREENTAB only if it has not been computed before.
if ~exist( 'greentab', 'var' ) || ~greentab.ismember( layer, enei, p )
  %  automatic grid for tabulation
  tab = tabspace( layer, p );
  %  Green function table
  greentab = compgreentablayer( layer, tab );
  %  precompute Green function table
  %    for a more accurate simulation of the layer the number of
  %    wavelenghts should be increased
  greentab = set( greentab, linspace( 400, 800, 5 ), op );
end
op.greentab = greentab;
%% bem solver

bem = bemsolver( p, op );
%  initialize plane wave excitation
exc = planewave( pol, dir, op );
%  scattering cross section
sca = zeros( numel( enei ), size( dir, 1 ) );

multiWaitbar( 'BEM solver', 0, 'Color', 'g', 'CanCancel', 'on' );
%  loop over wavelengths
for ien = 1 : length( enei )
  %  surface charges
  sig = bem \ exc( p, enei( ien ) );
  %  scattering cross section
  sca( ien, : ) = exc.sca( sig );
  
  multiWaitbar( 'BEM solver', ien / numel( enei ) );
end
%  close waitbar
multiWaitbar( 'CloseAll' );

%%  final plot
figure(2)
plot( enei, sca, 'o-' );  hold on;

xlabel( 'Wavelength (nm)' );
ylabel( 'Scattering cross section (nm^2)' );



title( 'TM polarization, excitation from above' );



writematrix(enei,'enei100')
writematrix(sca,'sca100')