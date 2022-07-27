import HashMap "mo:base/HashMap";
import Nat "mo:base/Nat";
import Result "mo:base/Result";
import Principal "mo:base/Principal";
import Iter "mo:base/Iter";

actor {
    // Challenge 12

    stable var entries : [(Principal, Nat)] = [];
    let favoriteNumber = HashMap.fromIter<Principal,Nat>(entries.vals(), 10, Principal.equal, Principal.hash);
            
    // Challenge 13
    public shared({caller}) func add_favorite_number(n : Nat) : async () {
        favoriteNumber.put(caller, n);
    };

    public shared({caller}) func show_favorite_number() : async ?Nat {
        switch(favoriteNumber.get(caller)){
            case(null) return null;
            case(n) return n;
        };
    };

    // Challenge 14
    public shared({caller}) func add_favorite_number2(n : Nat) : async Text {
        switch(favoriteNumber.get(caller)){
            case(null){
                favoriteNumber.put(caller, n);
                return "You've successfully registered your number";
            };
            case(?n) return "You've already registered your number";
        };
    };

    // Challenge 15
    public shared({caller}) func update_favorite_number(n : Nat) : async Result.Result<Text,Text> {
        switch(favoriteNumber.get(caller)){
            case(null) return #err("There is no favorite number for principal : " # Principal.toText(caller));
            case(_) {
                favoriteNumber.put(caller, n);
                return #ok("Favorite number modified for user with principal : " # Principal.toText(caller));
            };
        };
    };

    public shared({caller}) func delete_favorite_number(principal : Principal) : async Result.Result<(), Text> {
	switch(favoriteNumber.remove(principal)){
            case(null) {
                return #err("There is no favorite number for user with principal " # Principal.toText(principal));
            };
            case(?n){
                return #ok();
            };
        };
    };


    system func preupgrade() {
        entries := Iter.toArray(favoriteNumber.entries());
    };

    system func postupgrade() {
        entries := [];
    };
}