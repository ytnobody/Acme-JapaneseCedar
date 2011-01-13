use inc::Module::Install;
name 'Acme-JapaneseCedar';
all_from 'lib/Acme/JapaneseCedar.pm';

# requires '';

tests 't/*.t';
author_tests 'xt';

test_requires 'Test::More';
auto_set_repository;
auto_include;
WriteAll;
