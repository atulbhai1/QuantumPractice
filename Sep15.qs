operation Main() : Result{
    use qubit = Qubit();
    H(qubit);
    let result = M(qubit);
    Reset(qubit);
    return result;
}

