use inc::Module::Install;
name 'Acme-JapaneseCedar';
all_from 'lib/Acme/JapaneseCedar.pm';

requires 'Mouse' => 0.72;
requires 'Class::Method::Modifiers';
requires 'DateTime';
requires 'Time::HiRes';
requires 'POSIX';


tests 't/*.t';
author_tests 'xt';

test_requires 'Test::More';
auto_set_repository;
auto_include;
WriteAll;
