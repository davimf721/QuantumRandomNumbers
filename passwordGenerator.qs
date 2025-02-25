namespace Quantum.PasswordGenerator {
    open Microsoft.Quantum.Intrinsic;
    open Microsoft.Quantum.Diagnostics;
    open Microsoft.Quantum.Measurement;

   @EntryPoint()
    operation passwordGenerator() : String {
        mutable password = "";
        let passwordLength = 16; // Define the length of the password
        let characters = ["A", "B", "C", "D", "E", "F", "G", "H", "I", "J", "K", "L", "M", "N", "O", "P", "Q", "R", "S", "T", "U", "V", "W", "X", "Y", "Z", "a", "b", "c", "d", "e", "f", "g", "h", "i", "j", "k", "l", "m", "n", "o", "p", "q", "r", "s", "t", "u", "v", "w", "x", "y", "z", "0", "1", "2", "3", "4", "5", "6", "7", "8", "9", "!", "@", "#", "$", "%", "^", "&", "*", "(", ")"];

        for _ in 1..passwordLength {
            use qubits = Qubit[6]; // 6 qubits to generate a number between 0 and 63
            for qubit in qubits {
                H(qubit);
            }
            let result = MeasureEachZ(qubits);
            let index = ResultArrayAsInt(result);
            set password += characters[index % 64];
            ResetAll(qubits);
        }

        Message($"Generated password: {password}");
        return password;
    }

    function ResultArrayAsInt(results : Result[]) : Int {
        mutable value = 0;
        for idx in 0..Length(results) - 1 {
            if results[idx] == One {
                set value += 1 <<< idx;
            }
        }
        return value;
    }
}
