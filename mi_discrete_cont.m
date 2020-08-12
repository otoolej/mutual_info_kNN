%-------------------------------------------------------------------------------
% mi_discrete_cont: mutual information estimate from a continious variable and a 
%                   discrete variable [1,2]
%
% Syntax: mi = mi_discrete_cont(x, anno, k)
%
% Inputs: 
%     x    - input vector (length-N), with continuous values
%     anno - input vector (length-N), with discrete values 
%     k    - number of nearest neighbours (default 3)
%
% Outputs: 
%     mi - mutual information estimate (scalar)
%
% 
% Example:
%     % set the number of nearest neighbours:
%     k = 3;
%     
%     % generate low-frequency random signals:
%     x = detrend(cumsum(randn(1, 1000)));
%     
%     % generate binary mask from x:
%     y = x;
%     y(y > 0) = 1;
%     y(y ~= 1) = 0;
%     
%     % calculate MI between continuous x and discrete y:
%     mi = mi_discrete_cont(x, y, k);
%     fprintf('MI = %g\n', mi);
%     
% 
% Requires:
%     'knnsearch' from the statistics toolbox
% 
%  [1] Ross, B. C. (2014). Mutual information between discrete and continuous data
%  sets. PLoS ONE, 9(2). https://doi.org/10.1371/journal.pone.0087357 
%  [2] Kraskov, A., Stögbauer, H., & Grassberger, P. (2004). Estimating mutual
%  information. Physical Review E, 69(6), 16. https://doi.org/10.1103/PhysRevE.69.066138


% John M. O' Toole, University College Cork
% Started: 06-08-2020
%
% last update: Time-stamp: <2020-08-12 13:26:38 (otoolej)>
%-------------------------------------------------------------------------------
function mi = mi_discrete_cont(x, anno, k)
if(nargin < 3 || isempty(k)), k = 3; end
if(length(x) ~= length(anno))
    error('x and anno should be the same length');
end


x = x(:);
anno = anno(:);


classes = unique(anno);
N_class = length(classes);
N = length(x);
if(N_class == N)
    warning('is 2nd input argument a discrete variable??');
end


%---------------------------------------------------------------------
% 1. number of points in each class:
%---------------------------------------------------------------------
n_x = zeros(1, N_class);
for c = 1:N_class
    n_x(c) = length(anno(anno == classes(c)));
end


%---------------------------------------------------------------------
% 2. find the k-th distance for each class separately:
%---------------------------------------------------------------------
dist_kth = zeros(1, N);
for c = 1:N_class
    ic = find(anno == classes(c));
    
    nn_mdlx = createns(x(ic));
    [~, d] = knnsearch(nn_mdlx, x(ic), 'K', k + 1, 'distance', 'chebychev');
    
    dist_kth(ic) = d(:, k + 1);
end


%---------------------------------------------------------------------
% 3. find all the points (all classes) within the k-th distance :
%---------------------------------------------------------------------
% sort vectors first:
[xs, idx] = sort(x);
[~, idx] = sort(idx);

nx_range = rangesearch_var_radius(xs, idx, dist_kth);

% for this definition include the point itself:
nx_range = nx_range + 1;


%---------------------------------------------------------------------
% 4. calcuate MI (see [1])
%---------------------------------------------------------------------
mi = psi(N) + psi(k) - sum((n_x ./ N) .* psi(n_x)) - mean(psi(nx_range));
