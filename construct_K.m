function [K, S1, S2, A, B, C, D, E] = construct_K(n0, m0, p0)
    % Set the sizes of the submatrices
    n = n0; % Size of A
    m = m0; % Size of D
    p = p0; % Size of E

    % Generate invertible matrix A
    A = randn(n);
    while det(A) == 0
        A = randn(n);
    end

    % Generate random matrices B, C, D, E
    B = randn(m, n);
    C = randn(p, m);
    D = randn(m);
    E = randn(p);
    
    % Ensure D + BA^(-1)B^T is invertible
    S1 = D + B / A * B'; % positive-definite version
    while det(S1) == 0
        D = randn(m);
        S1 = D + B / A * B';
    end

    % Ensure -E + CS1^(-1)C^T is invertible
    S2 = E + C / S1 * C';
    while det(S2) == 0
        E = randn(p);
        S2 = E + C / S1 * C';
    end

    % Construct the zero matrices
    Z1 = zeros(n,p);
    Z2 = zeros(p, n);

    % Construct the block matrix K
    K = [A, B', Z1;
         B, -D, C';
         Z2, C, E];
end