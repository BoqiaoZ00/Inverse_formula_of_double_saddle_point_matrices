function result = compare_matrices(A, B, tolerance)
    % Check if the matrices have the same size
    if ~isequal(size(A), size(B))
        error('Matrices must have the same dimensions');
    end
    
    % Calculate the difference
    difference = abs(A - B);
    
    % Compare the difference with the tolerance
    result = all(difference(:) <= tolerance);
end