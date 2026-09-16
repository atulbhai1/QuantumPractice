import Std.Intrinsic.*;
import Std.Convert.*;
import Std.Math.*;


@EntryPoint()//Makes Sep16 the entrypoint
operation Sep16() : Result{
    use qubit = Qubit();
    H(qubit);
    let result = M(qubit);
    Reset(qubit);
    Message("I love Quantum");
    use q5 = Qubit[5];

    for (q) in (q5){
        H(q);
        Message($"Result: {M(q)}");
        Reset(q);
    }
    Message($"Random: {GenRandomInRange(15, 5)}");
    //M(q) is the same as Measure([PauliZ], qubit)
    return result;
}

operation GenRandomInRange(max: Int, min:Int): Int{
    mutable bits = [];
    let nBits = BitSizeI(max);
    for idxBit in 1..nBits {
        set bits += [GenerateRandomBit()];
    }
    let sample = ResultArrayAsInt(bits);

    return (sample > max or sample < min)? GenRandomInRange(max, min) | sample;
}

operation GenerateRandomBit(): Result{

    use q = Qubit();
    H(q);
    let result = M(q);
    Reset(q);

    return result;

}