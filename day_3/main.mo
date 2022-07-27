import Custom "custom";
import Animal "animal";
import List "mo:base/List";
import CustomList "list";
import Principal "mo:base/Principal";
import HashMap "mo:base/HashMap";
import Nat "mo:base/Nat";
import Result "mo:base/Result";
import Cycles "mo:base/ExperimentalCycles";

actor {
    // Challenge 2
    public type Animal = Animal.Animal;

    let default_champion : Custom.Champion = {
        name = "yasuo";
        hp = 10000;
        damage = 1000;
        character_class = "God";
    };

    // Challenge 1
    public func fun() : async Custom.Champion {
        return default_champion;
    };


    // Challenge 4
    public func create_animal_then_takes_a_break(species : Text, energy : Nat) : async Animal {
       var animal : Animal = {
            species = species;
            energy = energy;
        };

        animal := Animal.animal_sleep(animal);

        return animal;
    };

    // Challenge 5
    var animal_list : List.List<Animal> = null;

    // Challenge 6
    public func push_animal(animal : Animal) : () {
        animal_list := List.push<Animal>(animal, animal_list);
    };

    public func get_animals() : async [Animal] {
        return List.toArray<Animal>(animal_list);
    };

    // Challenge 11
    public shared({caller}) func is_anonymous(): async Bool {
        return Principal.equal(caller, Principal.fromText("2vxsx-fae"));
    };

    // Challenge 12
    let favoriteNumber = HashMap.HashMap<Principal, Nat>(0, Principal.equal, Principal.hash);
    
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

    // Challenge 16 (test in folder re)
    public func deposit_cycles() : async Nat {
        let amount = Cycles.available();
        let acceptable = amount;
        let accepted = Cycles.accept(acceptable);
        assert (accepted == acceptable);
        return accepted;
    };

    // Challenge 17 (test in folder re)
    type CallbackService = actor{ deposit_cycles : () -> async Nat };
    public shared({caller}) func withdraw_cycles(amount : Nat) : async Nat {
        let cs : CallbackService = actor(Principal.toText(caller));
        Cycles.add(amount);
        let n = await cs.deposit_cycles();
        return n;
    };

    // Challenge 18
    stable var counter = 0;
    stable var versionNumber : Nat = 0; 
    public func increment_counter(n : Nat) : async Nat {
        counter += n;
        return counter;
    };

    public func clear_counter() : async Nat {
        counter := 0;
        return counter;
    };

    system func postupgrade() {
        versionNumber := versionNumber + 1;
    };

    public func number_of_version() : async Nat{
        return versionNumber;
    };


}