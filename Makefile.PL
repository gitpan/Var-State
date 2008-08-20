use inc::Module::Install;

name     q(Var-State);
all_from q(lib/Var/State.pm);

requires      q(PadWalker)       => 0;
requires      q(Devel::Caller)   => 0;
requires      q(Devel::LexAlias) => 0;
test_requires q(Test::More)      => 0;

WriteAll;
