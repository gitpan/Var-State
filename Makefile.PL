use strict;
use warnings;
use ExtUtils::MakeMaker;

WriteMakefile(
    NAME          => 'Var::State',
    AUTHOR        => 'Jan Henning Thorsen <pm@flodhest.net>',
    VERSION_FROM  => 'lib/Var/State.pm',
    ABSTRACT_FROM => 'lib/Var/State.pm',
    PL_FILES      => {},
    PREREQ_PM     => {
                         'PadWalker'       => '0',
                         'Devel::Caller'   => '0',
                         'Devel::LexAlias' => '0',
                     },
    dist          => { COMPRESS => 'gzip -9f', SUFFIX => 'gz', },
    clean         => { FILES => 'Var-State-*' },
);
