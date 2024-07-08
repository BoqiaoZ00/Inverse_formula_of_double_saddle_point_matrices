[K, S1, S2, A, B, C, D, E]  = construct_K(34,3, 1);

P = A^(-1) + A^(-1)*B'*S1^(-1)*B*A^(-1);
Q = A^(-1)*B'*S1^(-1);
M = -S1^(-1)*B*A^(-1);
N = S1^(-1);

inv_11 = -Q*C' * S2^(-1) *C*M+P;
inv_12 = -(Q*C'*S2^(-1)*C*N+Q); % -
inv_13 = -(-Q*C'*S2^(-1)); % -
inv_21 = N*C'*S2^(-1)*C*M+M;
inv_22 = N*C'*S2^(-1)*C*N+N;
inv_23 = -N*C'*S2^(-1);
inv_31 =  -S2^(-1)*C*M;
inv_32 = -S2^(-1)*C*N;
inv_33 = S2^(-1);

inv = [inv_11, inv_12, inv_13;
    inv_21, inv_22, inv_23;
    inv_31, inv_32, inv_33];

true_inv = K^(-1);

is_correct = compare_matrices(inv, true_inv, 1e-8);