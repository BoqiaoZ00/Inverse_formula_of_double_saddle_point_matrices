    % Number of iterations
    num_iterations = 10000;

    % Tolerance for comparison
    tolerance = 1e-5;

    all_correct = true;

    % test multiple times
    for i = 1:num_iterations
        % Random dimensions for n, m, p
        n = randi([2,5]); % Random n between 2 and 5
        m = randi([2, 5]); % Random m between 2 and 5
        p = randi([2, 5]); % Random p between 2 and 5
    
        [K, S1, S2, A, B, C, D, E]  = construct_K(n, m, p);
    
        P = A^(-1) - A^(-1)*B'*S1^(-1)*B*A^(-1);
        Q = A^(-1)*B'*S1^(-1);
        M = S1^(-1)*B*A^(-1);
        N = -S1^(-1);
        
        inv_11 = Q*C' * S2^(-1) *C*M+P;
        inv_12 = Q*C'*S2^(-1)*C*N+Q;
        inv_13 = -Q*C'*S2^(-1);
        inv_21 = N*C'*S2^(-1)*C*M+M;
        inv_22 = N*C'*S2^(-1)*C*N+N;
        inv_23 = -N*C'*S2^(-1);
        inv_31 =  -S2^(-1)*C*M;
        inv_32 = -S2^(-1)*C*N;
        inv_33 = S2^(-1);
        
        % inverse by the formula
        inv = [inv_11, inv_12, inv_13;
        inv_21, inv_22, inv_23;
        inv_31, inv_32, inv_33];

        % inverse by MATLAB
        true_inv = K^(-1);

        is_correct = compare_matrices(inv, true_inv, tolerance);

        if ~is_correct
            all_correct = false;
            fprintf('Iteration %d: The matrices are NOT equal within the given tolerance with n = %d, m=  %d, p = %d.\n', i, n, m, p);
            inv
            true_inv
        end
    end

    if all_correct
        fprintf('all correct\n');
    else
        fprintf('some are incorrect\n');
    end