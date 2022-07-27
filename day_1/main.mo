import Array "mo:base/Array";
import Nat "mo:base/Nat";
import Iter "mo:base/Iter";

actor {

    // Challenge 1
    public func add(x : Nat, y : Nat) : async Nat {
        return (x + y);
    };

    // Challenge 2
    public func square(n : Nat) : async Nat {
        return (n * n);
    };

    // Challenge 3
    public func days_to_second(n : Nat) : async Nat {
        return (n * 24 * 60 * 60);
    };

    // Challenge 4
    var counter = 0;
    public func increment_counter(n : Nat) : async Nat {
        counter += n;
        return counter;
    };

    public func clear_counter() : async Nat {
        counter := 0;
        return counter;
    };

    // Challenge 5
    public func divide(x : Nat, y : Nat) : async Bool {
        if(y == 0){
            return false;
        };

        return (x % y == 0);
    };

    // Challenge 6
    public func is_even(n : Nat) : async Bool {
        return (n % 2 == 0);
    };

    // Challenge 7
    public func sum_of_array(array : [Nat]) : async Nat {
        var sum = 0;
        for(val in array.vals()){
            sum += val;
        };

        return sum;
    };

    // Challenge 8
    public func maximum(array : [Nat]) : async Nat {
        if(array.size() == 0) return 0;
        var maximum = array[0];
        for(val in array.vals()){
            if(val >= maximum){
                maximum := val;
            };
        };

        return maximum;
    };

    // Challenge 9
    public func remove_from_array(array : [Nat], n : Nat) : async [Nat] {
        var new_array : [Nat] = [];
        for(vals in array.vals()){
            if(vals != n){
                new_array := Array.append<Nat>(new_array, [vals]);
            };
        };
        return new_array;
    };

    
    // Challenge 10
    private func swap(array : [var Nat], i : Nat, j : Nat) : () {
        var tmp = array[i];
        array[i] := array[j];
        array[j] := tmp;
    };

    public func selection_sort(array : [Nat]) : async [Nat] {
        var new_array = Array.thaw<Nat>(array);
        var array_size = new_array.size();

        for(i in Iter.range(0,array_size-2)){
            var min_idx = i;
            for(j in Iter.range(i+1,array_size-1)){
                if(new_array[j] < new_array[min_idx])
                    min_idx := j;
            };

            swap(new_array, min_idx, i);
        };

        return Array.tabulate<Nat>(new_array.size(),func(i:Nat) : Nat{new_array[i]});
    };
}