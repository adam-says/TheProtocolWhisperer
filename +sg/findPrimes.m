function theprimes = findPrimes(X) % use keyword function to define a function
% rename results to theprimes
if nargin == 0 % user input of range if no argument is supplied to function
  X = input('Enter a range of numbers: ');
end
m = 1;
theprimes = []; % initialize return value
for i = X(1):X(end) % :1: is the default, not necessary, and ; is not needed here
  %k=mod(i,1:i);
  %zero=find(k==0);
  %n_zero=length(zero);
  %if n_zero==2  % no ; needed here
    % instead of the above 4 lines, you could also use the nnz function and no extra variables
    if nnz(mod(i,1:i) == 0) == 2
      theprimes(m)=i; % use function return value theprimes here
      m=m+1;
    end
    % i=i+1; % that's wrong, i is incremented in the for loop already
  end
c=numel(theprimes);
% if c == 0 % NOT theprimes==0; if isempty(theprimes) would also work
%   fprintf('There are no prime numbers\n')
% else
%   fprintf('There are %0.d prime numbers and they are ', c);
%   fprintf(' %d',theprimes) % use theprimes, not c
% end