%-------------------------------------------------------------------------------
% rangesearch_var_radius: 'rangesearch' for varying distances (radii)
%
% Syntax: nx_range = rangesearch_var_radius(x, idx, d)
%
% Inputs: 
%     x    - vector of data points (length-N array)
%     idx  - sequence of indices of the data points from x (length-N array)
%     d    - vector of distances (length-N array)
%
% Outputs: 
%     nx_range - number of samples within distance d(n) for x(idx(n)), 
%                for n=1,2,...,N (length-N array)
%
% Example:
%     % define dummy variables:
%     N = 1000;
%     x = randn(1, N);
%     d = abs(randn(1, N)) + 0.1;
%     
%     % return the number of samples within the radius d:
%     nx_range = rangesearch_var_radius(x, 1:N, d);
%     
%

% John M. O' Toole, University College Cork
% Started: 09-08-2020
%
% last update: Time-stamp: <2020-08-12 15:33:42 (otoolej)>
%-------------------------------------------------------------------------------
function nx_range = rangesearch_var_radius(x, idx, d)

N = length(x);
    
nx_range = zeros(1, N);
for n = 1:N
    nx_range(n) = rangesearch_1point(x, idx(n), d(n), N);
end
    


function p = rangesearch_1point(x, ix0, d, N)
%---------------------------------------------------------------------
% how many points within (less than) the distance d for point x(ix0)
%---------------------------------------------------------------------
x0 = x(ix0);

p = 0;
for n = (ix0 + 1):N
    if(abs(x(n) - x0) >= d)
        break;
    else
        p = p + 1;
    end
end
for n = (ix0 - 1):-1:1
    if(abs(x(n) - x0) >= d)
        break;
    else
        p = p + 1;
    end
end

