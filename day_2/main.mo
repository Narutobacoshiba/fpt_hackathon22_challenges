import Text "mo:base/Text";
import Array "mo:base/Array";
import Char "mo:base/Char";
import Nat8 "mo:base/Nat8";
import Iter "mo:base/Iter";
import Blob "mo:base/Blob";
import Option "mo:base/Option";

actor {

    // Challenge 1
    public func nat_to_nat8(n : Nat) : async Nat8 {
        if( n > 255){
            return 0;
        } else{
            return Nat8.fromNat(n);
        };
    };

    // Challenge 2
    public func max_number_with_n_bits(n : Nat) : async Nat {
        return (2 ** (n) - 1);
    };

    // Challenge 3
    public func decimals_to_bits(n : Nat) : async Text {
        var m = n;
        var bits = "";
        while(m > 0){
            let remainder = m % 2;
            m := m / 2;
            if(remainder == 1){
                bits := "1" # bits;
            } else {
                bits := "0" # bits;
            };
        };
        return bits
    };

    //  Challenge 4 
    public func capitalize_character(char : Char) : async Char {
        let unicode_value = Char.toNat32(char);
        if(unicode_value >= 97 and unicode_value <= 122){
            return (Char.fromNat32(unicode_value - 32))
        } else {
            return (Char.fromNat32(unicode_value));
        };
    };

    //  Challenge 5
    private func _capitalize_character(char : Char) : Char {
        let unicode_value = Char.toNat32(char);
        if(unicode_value >= 97 and unicode_value <= 122){
            return(Char.fromNat32(unicode_value - 32))
        } else {
            return (Char.fromNat32(unicode_value));
        };
    };

    public func capitalize_text(word : Text) : async Text {
        var new_word : Text = "";
        for(char in word.chars()){
            new_word #= Char.toText(_capitalize_character(char));
        };
        return new_word;
    };

    //  Challenge 6 
    public func is_inside(t : Text, l : Text) : async Bool {
        let p = #text(l);
        return (Text.contains(t, p));
    };


    //  Challenge 7 
    public func trim_whitespace(t : Text) : async Text {
        let pattern = #text(" ");
        return(Text.trim(t, pattern));
    };

    //  Challenge 8 
    public func duplicate_character(t : Text) : async Text {
        var characters : [Char] = [];

        for (character in Text.toIter(t)){
            let filter : [Char] = Array.filter(characters, func(x : Char) : Bool{x == character});
            if(filter.size() == 0){
                characters := Array.append<Char>(characters, [character]);
            }else{
                return Char.toText(filter[0]);
            }
        };
        return (t);
    };


    //  Challenge 9 
    public func size_in_bytes (t : Text) : async Nat {
        let utf_blob = Text.encodeUtf8(t);
        let array_bytes = Blob.toArray(utf_blob);
        return(array_bytes.size()); 
    };


    // Challenge 10 
    private func _swap(array : [var Nat], i : Nat, j : Nat) : () {
        var tmp = array[i];
        array[i] := array[j];
        array[j] := tmp;
    };

    public func bubble_sort(array : [Nat]) : async [Nat] {
        var sorted = Array.thaw<Nat>(array);
        let size = sorted.size();
        for (i in Iter.range(0, size - 2)){
            for (j in Iter.range(0, size - 2 - i)){
                if(sorted[j] > sorted[j + 1]){
                    _swap(sorted, j , j+1);
                };
            };
        };
        return Array.tabulate<Nat>(sorted.size(),func(i:Nat) : Nat{sorted[i]});
    };

    // Challenge 11 
    public func nat_opt_to_nat(n : ?Nat, m : Nat) : async Nat {
        switch(n){
            case(null) return m;
            case(?n) return n; 
        };
    };

    // Challenge 12
    public func day_of_the_week(day : Nat) : async ?Text {  
        switch(day){
        case(1) return ?"Monday";
        case(2) return ?"Thursday";
        case(3) return ?"Wednesday";
        case(4) return ?"Tuesday";
        case(5) return ?"Friday";
        case(6) return ?"Saturday";
        case(7) return ?"Sunday";
        case(_) return null;
        };
    };


    // Challenge 13
    public func populate_array(array : [?Nat]) : async [Nat] {
        Array.map<?Nat,Nat>(array, func(x) {
            switch(x){
                case(null) return 0;
                case(?x) return x;
            };
        });
    };

    // Challenge 14
    public func sum_of_array(array : [Nat]) : async Nat {
        let sum = Array.foldLeft<Nat, Nat>(array, 0, func(a , b) {a + b});
        return(sum);
    };

    // Challenge 15
    public func squared_array(array : [Nat]) : async [Nat] {
        return(Array.map<Nat,Nat>(array, func(x) { x*x }));
    };

    // Challenge 16
    public func increase_by_index(array : [Nat]) : async [Nat] {
        return(Array.mapEntries<Nat,Nat>(array, func(a, index) {a + index}));
    };

    // Challenge 17
    let contains = func<A>(arr : [A], a : A, f : (A,A) -> Bool) : Bool {
                        Option.isSome(Array.find<A>(arr, func(x) { f(x, a) }))
                    }

}