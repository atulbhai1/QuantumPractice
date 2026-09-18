import Std.Diagnostics.*;
import Std.Math.*;
import Std.Convert.*;

@EntryPoint()
operation Sep_17_4(): Int {
    use qubits = Qubit[3];
    let otherQubit1 = qubits[0];
    let otherQubit2 = qubits[1];
    let otherQubit3 = qubits[2];
    let P1 = 0.9;
    let P2 = 0.9;
    let P3 = 0.9;
    Ry(2.0 * ArcCos(Sqrt(P1)), otherQubit1);
    Ry(2.0 * ArcCos(Sqrt(P2)), otherQubit2);
    Ry(2.0 * ArcCos(Sqrt(P3)), otherQubit3);
    Message("The qubit register is in a skewed superposition: ");
    DumpMachine();
    mutable results = [];
    for q in qubits {
        Message(" ");
        results += [M(q)];
        DumpMachine();
    }
    ResetAll(qubits);
    Message("Your random number is: ");
    return ResultArrayAsInt(results);
}

operation Sep17_4() : Int {
    use qubits = Qubit[3];
    ApplyToEach(H, qubits);
    Message("The qubit register is in a uniform superposition: ");
    DumpMachine();
    mutable results = [];
    for q in qubits {
        Message(" ");
        results += [M(q)];
        DumpMachine();
    }
    ResetAll(qubits);
    Message("Your random number is: ");
    return ResultArrayAsInt(results);
}
operation Sep17_3() : Int{
    use qubits = Qubit[3];
    ApplyToEach(H, qubits);
    Message("The qubit register in a uniform superposition: ");
    DumpMachine();
    let result = MeasureEachZ(qubits);
    Message("Measuring the qubits collapses the superposition to a basis state.");
    DumpMachine();
    ResetAll(qubits);
    return ResultArrayAsInt(result);
}

operation Sep17_2() : Result{
    use q = Qubit();
    let P = 0.3333333;//P of getting 0 is 1/3
    Ry(2.0 * ArcCos(Sqrt(P)), q);
    Message("Qubit in desired state");
    DumpMachine();
    let skewedrandomBit = M(q);
    Reset(q);
    return skewedrandomBit;

}

operation Sep17_1() : Result {
    use q = Qubit();
    Message("Initialized qubit:");
    DumpMachine(); // First dump
    Message(" ");
    H(q);
    Message("Qubit after applying H:");
    DumpMachine(); // Second dump
    Message(" ");
    let randomBit = M(q);
    Message("Qubit after the measurement:");
    DumpMachine(); // Third dump
    Message(" ");
    Reset(q);
    Message("Qubit after re
    setting:");
    DumpMachine(); // Fourth dump
    Message(" ");
    return randomBit;
}