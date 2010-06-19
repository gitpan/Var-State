use inc::Module::Install;

name q(Var-State);
all_from q(lib/Var/State.pm);

requires q(PadWalker) => 1.00;
requires q(Devel::Caller) => 2.05;
requires q(Devel::LexAlias) => 0.04;

test_requires q(Test::More) => 0.94;

bugtracker q(http://rt.cpan.org/NoAuth/Bugs.html?Dist=Var-State);
homepage q(http://search.cpan.org/dist/Var-State);
repository q(git://github.com//home/repositories/var-state.git);

# install_script glob('bin/*');
auto_install;
WriteAll;
