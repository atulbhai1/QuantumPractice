import Std.Diagnostics.*;
import Std.Intrinsic.*;
import Std.Measurement.*;

@EntryPoint()
operation Sep18_2(): Result[]{
    use (message, bob) = (Qubit(), Qubit());

    let stateInitializerBasisTuples = [
        ("|0〉", I, PauliZ),
        ("|1〉", X, PauliZ),
        ("|+〉", SetToPlus, PauliX),
        ("|-〉", SetToMinus, PauliX)
    ];

    mutable results = [];
    for (state, initializer, basis) in stateInitializerBasisTuples {
        initializer(message);
        Message($"Teleporting state {state}");
        DumpMachine();

        Teleport(message, bob);
        Message($"Got state {state}");
        DumpMachine();

        let result = Measure([basis], [bob]);
        set results += [result];
        ResetAll([message, bob]);
    }
    return results;
}

operation Teleport(message: Qubit, bob: Qubit): Unit{
    use alice = Qubit();
    H(alice);
    CNOT(alice, bob);
    CNOT(message, alice);
    H(message);
    if M(message) == One {
        Z(bob);
    }
    if M(alice) == One{
        X(bob);
    }
    Reset(alice);

}

operation SetToPlus(q: Qubit): Unit is Adj + Ctl{
    H(q);
}
operation SetToMinus(q: Qubit): Unit is Adj + Ctl{
    X(q);
    H(q);
}
operation Sep18_1(): (Result, Result){

    use (q1, q2) = (Qubit(), Qubit());

    H(q1);
    CNOT(q1, q2);
    
    DumpMachine();
    let m1 = M(q1);
    DumpMachine();
    let m2 = M(q2);
    ResetAll([q1, q2]);
    return (m1, m2);

}

operation QuantumINFOFASTER(): Result[]{//Proof that once superposition collapses, the entanglement goes away :(
    use (q1, q2) = (Qubit(), Qubit());

    H(q1);
    CNOT(q1, q2);
    
    DumpMachine();
    let m1 = M(q1);//measure q1, forcing q2 into definite state
    let m2 = M(q2);//measure q2(check origninal value)
    if (m1 == One){//Force q1 into 0
        X(q1);
    }
    let m2_new = M(q2);//measure q2 again(check if anything changed)
    DumpMachine();
    ResetAll([q1, q2]);
    return [m2, m2_new];
}