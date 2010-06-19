package Var::State;

=head1 NAME

Var::State - Static variable in perl 5.8

=head1 VERSION

0.05

=head1 SYNOPSIS

 use Var::State;

 sub foo {
     static my $i = 0;
     return $i++;
 }

 print foo() for(0..10); # will print 0 to 10

=cut

use strict;
use warnings;
use Devel::Caller qw/caller_vars/;
use Devel::LexAlias qw/lexalias/;
use PadWalker qw/var_name/;

our $VERSION = '0.05';
my %state_cache;

=head1 FUNCTIONS

=head2 static(var)

Does almost the same as C<state> in 5.10, but it requires the
variable to be declared with "my". See L</SYNOPSIS> for example.

This function does support list context, something C<state> in
5.10 does not support.

=cut

sub static {
    my $var  = (caller_vars(0))[0];
    my $name = var_name(1, $var);
    my $key;

    die "static(): variable has no name!" unless(defined $name);

    $key = join(";", (caller(0))[1,2], # caller file and linenumber
                     (caller(1))[0,3], # caller package and sub-name
                     $name,            # caller variable name
           );

    if(exists $state_cache{$key}) {
        lexalias 1, $name, $state_cache{$key};
    }
    else { 
        $state_cache{$key} = $var;
    }

    return;
}

=head2 state

See L<LIMITATIONS>.

=cut

sub state {
    die "state() is not implemented!\n";
}

=head2 import

Will import C<static()> into the current namespace.

=cut

sub import {
    my $parent = caller(1);
    no strict 'refs';
    *{"${parent}::my_state"} = \&static;
    *{"${parent}::static"} = \&static;
    return;
}

=head1 LIMITATIONS

Need to add C<state> as a keyword, so you don't have to declare the variable
with C<my()> first. This exact problem breakes compatibility with 5.10's
state, and therefore C<t/11-state-5.10.t> is not included in the test-suite.

=head1 BUGS

Please report any bugs or feature requests to
C<bug-var-state at rt.cpan.org>, or through the web interface at
L<http://rt.cpan.org/NoAuth/ReportBug.html?Queue=Var-State>.
I will be notified, and then you'll automatically be notified of
progress on your bug as I make changes.

=head1 AUTHOR

Jan Henning Thorsen, C<< <pm at flodhest.net> >>

=head1 COPYRIGHT & LICENSE

This program is free software; you can redistribute it and/or modify it
under the same terms as Perl itself.

Copyright (c) 2007 Jan Henning Thorsen

=cut

1;
