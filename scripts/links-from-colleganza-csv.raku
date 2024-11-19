#!/usr/bin/env raku

use Text::CSV;
use JSON::Fast;

my @rows = csv( in=> "data-raw/venice_colleganza.csv", :encoding("latin1"),
        :headers("auto") );

my @all-families;
my @all-pairs;
my %stans;
my %tractors;
my $gc-families = Set.new();
my %years-contracts;
my %contracts-persons-year;
my %italian-to-std;
my @self-loops;
@self-loops.push: ["Families", "Year"];
for @rows[0..*] -> %row {
    my @families = [];
    my $tractor-families = Set();
    my $stan-families = Set();
    next if %row<repeat_note> ne "";
    if %row<stans_familyname_italian> eq '' {
        say %row;
        %row<stans_familyname_italian> = %row<stans_firstname_italian>
    }

    for <tractor_familyname tractor_2_familyname stans_familyname stans_2_familyname> -> $key {
        my Str $std-name = "";

        if (%row{$key ~ "_std"}) {
            $std-name = %row{$key ~ "_std"};
            %italian-to-std{%row{$key ~ "_italian"}} = $std-name;
        } elsif (%row{$key ~ "_italian"}) {
            $std-name = %row{$key ~ "_italian"}
        }

        if (%row{$key ~ "_std_gc"}) {
            $gc-families ∪= %row{$key ~ "_std_gc"};
        }

        if ($std-name ne "" and $std-name ne "unknown") {
            @families.push: $std-name;

            if $key ~~ /tractor/ {
                my Str $first-name = $key ~~ /2/ ??
                %row<tractor_2_firstname_italian> !!
                %row<tractor_firstname_italian>;

                my $complete-name = "$first-name $std-name";
                $tractor-families ∪= $std-name;
                if ( %tractors{$std-name} < %row<year> ) {
                    %tractors{$std-name} = %row<year>;
                }

                if ( ! %years-contracts{$std-name} ) {
                    %years-contracts{$std-name} = [];
                }
                %years-contracts{$std-name}.push: ["tractor", %row<year>];
                if %contracts-persons-year{$complete-name}:!exists {
                    %contracts-persons-year{$complete-name} = [];
                }
                %contracts-persons-year{$complete-name}.push: [%row<year>,
                                                               "tractor"];
            }

            if $key ~~ /stans/ {
                my Str $first-name = $key ~~ /2/ ??
                %row<stans_2_firstname_italian> !!
                        %row<stans_firstname_italian>;

                my $complete-name = "$first-name $std-name";
                $stan-families ∪= $std-name;
                if ( %stans{$std-name} < %row<year> ) {
                    %stans{$std-name} = %row<year>;
                }

                if ( !%years-contracts{$std-name} ) {
                    %years-contracts{$std-name} = [];
                }
                %years-contracts{$std-name}.push: ["stan", %row<year>];

                if %contracts-persons-year{$complete-name}:!exists {
                    %contracts-persons-year{$complete-name} = [];
                }
                %contracts-persons-year{$complete-name}.push: [%row<year>,
                                                               "stans"];
            }
        }
    }
    if $tractor-families ∩ $stan-families != ∅ {
        @self-loops.push: [ $tractor-families ∩ $stan-families, %row<year> ];
    }
    @families = @families.grep: * ne "unknown";
    @all-families.push: @families;
    if (@families.elems >  1) {
        for @families.combinations(2) -> @pair {
            @all-pairs.push: [|@pair, %row<year>];
        }
    }
}

spurt( "data-raw/colleganza-families.json", to-json @all-families );
spurt( "data-raw/great-council-families.json", to-json $gc-families.keys());
spurt( "data-raw/colleganza-tractors.json", to-json %tractors);
spurt( "data-raw/colleganza-stans.json", to-json %stans);
spurt( "data-raw/colleganza-type-contract.json", to-json %years-contracts);
spurt( "data-raw/italian-to-std.json", to-json %italian-to-std);
csv( out=> "data-raw/colleganza-pairs-date.csv", in => @all-pairs);
csv( out=> "data-raw/self-loop-families-colleganza.csv", in => @self-loops);

my @contracts-family-year = [];
@contracts-family-year.push: ["Family","Contract Type", "Year"];
my @contracts-changes = [];
@contracts-changes.push: ["Family","First","Last","Flips","Percentage"];
my @contracts-changes-pre = [];
@contracts-changes-pre.push: ["Family","First","Last","Flips","Percentage"];
my @contracts-changes-post = [];
@contracts-changes-post.push: ["Family","First","Last","Flips","Percentage"];
my %total-flips-per-type = ( "stan → tractor" => 0, "tractor → stan" => 0 );

for %years-contracts.keys -> $family {
    my @contracts = %years-contracts{$family}.sort: *[1];
    for @contracts -> @contract {
        @contracts-family-year.push: [ $family, |@contract ];
    }

    @contracts-changes.push: flips( $family, @contracts );
    for flips-per-type( $family, @contracts ).kv -> $type, $flips {
        %total-flips-per-type{$type} += $flips;
    }
    if @contracts.grep: *[1] < 1300 {
        @contracts-changes-pre.push:
                flips($family, @contracts.grep: *[1] < 1300);
    }
    if @contracts.grep: *[1] > 1300 {
        @contracts-changes-post.push:
                flips($family, @contracts.grep: *[1] > 1300);
    }
}

csv( out => "data-raw/contract-family-year.csv", in=> @contracts-family-year);
csv( out => "data-raw/contract-family-flips.csv", in=> @contracts-changes);
csv( out => "data-raw/contract-family-flips-pre.csv",
        in=> @contracts-changes-pre);
csv( out => "data-raw/contract-family-flips-post.csv",
        in=> @contracts-changes-post);

my @total-flips-per-type = [];
@total-flips-per-type.push: [["Type of change", "Number"]];
for %total-flips-per-type.kv -> $type, $flips {
    @total-flips-per-type.push: [$type, $flips];
}
csv( out => "data-raw/contract-flips-per-type.csv", in=> @total-flips-per-type );

my @persons-year-type;
@persons-year-type.push: ["Name","Year","Type"];
my @person-contracts-type;
@person-contracts-type.push: ["Name","Contracts","Type"];
for %contracts-persons-year.keys().sort() -> $person {
    my @contracts =
            %contracts-persons-year{$person}.sort: { $^a[0]  <=>  $^b[0] };

    my $types = Set();
    for @contracts -> @contract {
        $types ∪= @contract[1];
        @persons-year-type.push: [$person, |@contract];
    }
    @person-contracts-type.push:
            [ $person,
              @contracts.elems(),
              $types.elems() == 1
                ?? $types.keys()[0]
                !! @contracts[0][1] ~ "→" ~ @contracts[*-1][1] ];
}


csv( out=> "data-raw/person-type-year.csv", in=>  @persons-year-type );
csv( out=> "data-raw/person-contracts-type.csv", in=> @person-contracts-type);

sub flips( $family, @contracts ) returns Array {
    my $flips = 0;
    if (@contracts.elems > 1) {
        for 1 .. @contracts.elems-1 -> $i {
            $flips++ if @contracts[$i][0] ne @contracts[$i - 1][0];
        }
    }
    return [$family, @contracts[0][0], @contracts[*-1][0],
                              $flips, $flips/@contracts.elems ];
}

sub flips-per-type( $family, @contracts ) returns Hash {
    my %flips-per-type = ( "stan → tractor" => 0, "tractor → stan" => 0 );
    if (@contracts.elems > 1) {
        for 1 .. @contracts.elems-1 -> $i {
            if @contracts[$i][0] ne @contracts[$i - 1][0] {
                %flips-per-type{@contracts[$i - 1][0] ~ " → " ~
                                @contracts[$i][0]}++;
            }
        }
    }
    return %flips-per-type;
}