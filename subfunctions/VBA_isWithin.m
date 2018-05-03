function [flag] = VBA_isWithin (X, bounds)
% // VBA toolbox //////////////////////////////////////////////////////////
%
% [flag] = VBA_isWithin (X, bounds)
% check if all elements of X are within bounds
%
% IN:
%   - X: matrix, cell array of matrices, or structure to be checked
%   - bounds: a 2x1 vector that defines an interval on the real line
% OUT:
%   - flag: - true if all element and fields of X are within the bounds
%           - false if at least one element is outside the bounds 
%           - NaN if any element or field is not numeric or weird
%
% /////////////////////////////////////////////////////////////////////////

if VBA_isWeird (X)
    flag = NaN;
    return;
end

switch class (X)
    case 'double'
        flag = ~ any (X(:) < min (bounds) | X(:) > max(bounds));
                
    case 'cell'
        flag = all (cellfun (@ (Y) VBA_isWithin (Y, bounds), X));
        
    case 'struct'
        flag = all (structfun (@ (Y) VBA_isWithin (Y, bounds), X));
    
    otherwise
        flag = NaN;
end