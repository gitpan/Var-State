use strict;
use warnings;
use lib q(lib);
use Var::State;
use Test::More;

plan tests => 9;

for my $type (qw/scalar array hash/) {
    for my $i (1..3) {
        is(eval "static_$type()", $i, "static $type = $i");
    }
}

sub static_scalar {
    static my $x = 1;
    return $x++;
}

sub static_array {
    static my @array;
    return push @array, 1;
}

sub static_hash {
    static my %hash = (x => 1);
    return $hash{x}++;
}

