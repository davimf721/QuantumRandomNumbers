namespace Quantum.Demo {
open Microsoft.Quantum.Intrinsic;
open Microsoft.Quantum.Diagnostics;
open Microsoft.Quantum.Measurement;
@EntryPoint()
operation GenerateNumbers() : Unit {
    use register = Qubit[4];

    // Prepare the qubits in a superposition state
    for qubit in register {
        H(qubit);
    }
    // Measure each qubit and reset them
    let results = MResetEachZ(register);
    // Convert binary results to decimal
    let decimalValue = ResultArrayAsInt(results);
    Message($"Decimal value: {decimalValue}");
}
function ResultArrayAsInt(results : Result[]) : Int {
    mutable value = 0;
    for idx in 0..Length(results) - 1 {
        if results[idx] == One {
        set value += 2^(Length(results) - 1 - idx);
        }
    }
    return value;
    }
}