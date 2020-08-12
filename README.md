# Mutual Information (Matlab code)

Calculate the mutual information using a nearest-neighbours method for both the continuous
versus continuous variable ([Kraskov et al. 2004](#references)) and for the continious versus discrete (binary,
categorical) variable ([Ross 2014](#references)).

For full details, see references ([Kraskov et al. 2004, Ross 2014](#references)).

Use `knnsearch` from the statistics toolbox but replaces `rangesearch` with specific code
for variable distance. Not using `rangesearch` computes a few orders of magnitude faster.

---
[Requirements](#requires) | [Functions](#functions) | [Example](#example) |
[Licence](#licence) | [References](#references) | [Contact](#contact)


## Requires
Matlab ([Mathworks](http://www.mathworks.co.uk/products/matlab/)) version R2020a or newer
with the statistics toolbox. (Should work on older versions but not tested.)

## Functions

+ `mi_discrete_cont(x, y, k)` computes the mutual information for continuous variable `x`
and discrete (integer values only) `y`, with `k` nearest neighbours.

+ `mi_cont_cont(x1, x2, k)` computes the mutual information for continuous variables `x1`
and `x2`, with `k` nearest neighbours.

## Example

```matlab
% load an example data set with continuous and discrete variables:
data_tb = readtable('data_cont_discrete_eg.csv');

% plot the data (if needed):
figure(1); clf; hold all;
hl(1) = plot(data_tb.x1);
hl(2) = plot(data_tb.x2);
hl(3) = plot(data_tb.x3);
hl(4) = plot(data_tb.y .* 100);
legend(hl, {'x1', 'x2', 'x3', 'y'});


% set the number of nearest neighbours:
k = 5;

% mutual information between x1(2,3) and the binaray y:
mi_x_y = zeros(1, 3);
mi_x_y(1) = mi_discrete_cont(data_tb.x1, data_tb.y, k);
mi_x_y(2) = mi_discrete_cont(data_tb.x2, data_tb.y, k);
mi_x_y(3) = mi_discrete_cont(data_tb.x3, data_tb.y, k);

% mutual information between the continuous variables:
mi_x_x = zeros(1, 3);
mi_x_x(1) = mi_cont_cont(data_tb.x1, data_tb.x2, k);
mi_x_x(2) = mi_cont_cont(data_tb.x2, data_tb.x3, k);
mi_x_x(3) = mi_cont_cont(data_tb.x1, data_tb.x3, k);

% display output in table:
disp(array2table([mi_x_y; mi_x_x]', 'VariableNames', {'MI (x vs y)', 'MI (x vs x)'}));
```

## Licence

```
Copyright (c) 2020, John M. O' Toole, University College Cork
All rights reserved.

Redistribution and use in source and binary forms, with or without modification,
are permitted provided that the following conditions are met:

  Redistributions of source code must retain the above copyright notice, this
  list of conditions and the following disclaimer.

  Redistributions in binary form must reproduce the above copyright notice, this
  list of conditions and the following disclaimer in the documentation and/or
  other materials provided with the distribution.

  Neither the name of the University College Cork nor the names of its
  contributors may be used to endorse or promote products derived from
  this software without specific prior written permission.

THIS SOFTWARE IS PROVIDED BY THE COPYRIGHT HOLDERS AND CONTRIBUTORS "AS IS" AND
ANY EXPRESS OR IMPLIED WARRANTIES, INCLUDING, BUT NOT LIMITED TO, THE IMPLIED
WARRANTIES OF MERCHANTABILITY AND FITNESS FOR A PARTICULAR PURPOSE ARE
DISCLAIMED. IN NO EVENT SHALL THE COPYRIGHT HOLDER OR CONTRIBUTORS BE LIABLE FOR
ANY DIRECT, INDIRECT, INCIDENTAL, SPECIAL, EXEMPLARY, OR CONSEQUENTIAL DAMAGES
(INCLUDING, BUT NOT LIMITED TO, PROCUREMENT OF SUBSTITUTE GOODS OR SERVICES;
LOSS OF USE, DATA, OR PROFITS; OR BUSINESS INTERRUPTION) HOWEVER CAUSED AND ON
ANY THEORY OF LIABILITY, WHETHER IN CONTRACT, STRICT LIABILITY, OR TORT
(INCLUDING NEGLIGENCE OR OTHERWISE) ARISING IN ANY WAY OUT OF THE USE OF THIS
SOFTWARE, EVEN IF ADVISED OF THE POSSIBILITY OF SUCH DAMAGE.
```


## References

1. Kraskov, A., Stögbauer, H., & Grassberger, P. (2004). Estimating mutual
information. Physical Review E,
69(6), 16. [10.1103/PhysRevE.69.066138](https://doi.org/10.1103/PhysRevE.69.066138)

2. Ross, B. C. (2014). Mutual information between discrete and continuous data sets.  PLoS
ONE,
9(2). [DOI:10.1371/journal.pone.0087357](https://doi.org/10.1371/journal.pone.0087357)


## Contact

John M. O'Toole

Neonatal Brain Research Group,  
[INFANT Research Centre](https://www.infantcentre.ie/),  
Department of Paediatrics and Child Health,  
Room 2.19 UCC Academic Paediatric Unit, Cork University Hospital,  
University College Cork,  
Ireland

- email: jotoole AT ucc _dot ie 
