import Cycles "mo:base/ExperimentalCycles";
import Principal "mo:base/Principal";
import Nat "mo:base/Nat";

actor refunded{
    type CallbackService = actor{ deposit : () -> async Nat; withdraw_cycles : (amount : Nat) -> async Nat };

    public func wallet_balance() : async Nat {
        return Cycles.balance();
    };

    public func deposit_cycles() : async Nat {
        let available = Cycles.available();
        let accepted = Cycles.accept(available);
        assert (accepted == available);
        return accepted;
    };

    // Test for Challenge 16
    public func sendCycles(amount : Nat) : async Nat {
        let cs : CallbackService = actor("r7inp-6aaaa-aaaaa-aaabq-cai"); // you must use your own canister_id;
        Cycles.add(amount);
        let n = await cs.deposit();
        return n;
    };

    // Test for Challenge 17
    public func withdrawCycles(amount : Nat) : async Nat {
        let cs : CallbackService = actor("r7inp-6aaaa-aaaaa-aaabq-cai"); // you must use your own canister_id;
        let n = await cs.withdraw_cycles(amount);
        return n;
    };
};