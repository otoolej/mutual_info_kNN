%-------------------------------------------------------------------------------
% mi_cont_cont: mutual information using the first method in [1]
%
% Syntax: mi = mi_cont_cont(x, y, k)
%
% Inputs: 
%     x - input vector (length-N)
%     y - input vector (length-N)
%     k - number of nearest neighbours (default 3)
%
% Outputs: 
%     mi - mutual information estimate (scalar)
%
% Example:
%     % set the number of nearest neighbours:
%     k = 3;
%     
%     % generate low-frequency random signals:
%     x = randn(1, 1000);
%     y = randn(1, 1000);
%     
%     % calculate MI between continuous x and discrete y:
%     mi = mi_cont_cont(x, y, k);
%     fprintf('MI = %g\n', mi);
%     
% 
% Requires:
%     'knnsearch' from the statistics toolbox
% 
%
%  [1] Kraskov, A., Stögbauer, H., & Grassberger, P. (2004). Estimating mutual
%  information. Physical Review E, 69(6), 16. https://doi.org/10.1103/PhysRevE.69.066138

% John M. O' Toole, University College Cork
% Started: 05-08-2020
%
% last update: Time-stamp: <2020-08-12 13:34:38 (otoolej)>
%-------------------------------------------------------------------------------
function mi = mi_cont_cont(x, y, k)
if(nargin < 3 || isempty(k)), k = 5; end
if(length(x) ~= length(y))
    error('x and y should be the same length');
end


N = length(x);
x = x(:);
y = y(:);
xy = [x y];

%---------------------------------------------------------------------
% 1. calculate the k-th nearest neighbour:
%---------------------------------------------------------------------
nn_mdlx = createns(xy, 'Distance','chebychev');
[~, dist_kth] = knnsearch(nn_mdlx, xy, 'k', k + 1);
dist_kth = dist_kth(:, k + 1);



%---------------------------------------------------------------------
%  2. find all points within distance:
%  find all the points (all classes) within the k-th distance :
%---------------------------------------------------------------------

% sort vectors first:
[xs, idx] = sort(x);
[ys, idy] = sort(y);
[~, idx] = sort(idx);
[~, idy] = sort(idy);


nx_range = rangesearch_var_radius(xs, idx, dist_kth);
ny_range = rangesearch_var_radius(ys, idy, dist_kth);


%---------------------------------------------------------------------
% 3. calcuate MI (see [1])
%---------------------------------------------------------------------
mi = psi(k) + psi(N) - mean(psi(nx_range + 1) + psi(ny_range + 1));


% correct if <0
mi(mi < 0) = 0;
