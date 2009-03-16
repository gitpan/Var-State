use inc::Module::Install;

name     q(Var-State);
all_from q(lib/Var/State.pm);

requires      q(PadWalker)       => 1.00;
requires      q(Devel::Caller)   => 1.00;
requires      q(Devel::LexAlias) => 0.01;
test_requires q(Test::More)      => 0.50;

auto_install;
WriteAll;
