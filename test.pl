# Before `make install' is performed this script should be runnable with
# `make test'. After `make install' it should work as `perl test.pl'

######################### We start with some black magic to print on failure.

# Change 1..1 below to 1..last_test_to_print .
# (It may become useful if the test is moved to ./t subdirectory.)

BEGIN { $| = 1; print "1..1\n"; }
END {print "not ok 1\n" unless $loaded;}
use Crypt::xDBM_File;
$loaded = 1;
print "ok 1\n";

######################### End of black magic.

# Insert your test code below (better if it prints "ok 13"
# (correspondingly "not ok 13") depending on the success of chunk 13
# of the test code):

use Crypt::IDEA;
use Crypt::DES;
use Crypt::Blowfish;

use GDBM_File;
use NDBM_File;
use SDBM_File;
use Fcntl;

tie %hash, 'Crypt::xDBM_File', 'IDEA', '01234567', 'GDBM_File', "/tmp/bob.idea", &GDBM_WRCREAT, 0640;

$hash{'bob'} = "bob rules!";
$hash{'of'} = "yes";
$hash{'cult'} = "bob totally rules :)";

foreach $key (keys(%hash)) {
	print "$key = $hash{$key}\n";
}

each %hash; #start it out, if we don't get three values bad news;

foreach $key (values(%hash)) {
	print "value = $key\n";
}

%hash = (); # do a clear
$size = scalar(keys(%hash));
print "after clear: size = $size\n";

$hash{'bob'} = "bob rules!";
$hash{'of'} = "yes";
$hash{'cult'} = "bob totally rules :)";

print "key bob = $hash{'bob'}\n";
print "key cult = $hash{'cult'}\n";
untie %hash;

tie %hash, 'Crypt::xDBM_File', 'DES', '01234567', 'SDBM_File', "/tmp/bob.blf", O_RDWR|O_CREAT, 0640;

$hash{'bob'} = "bob rules!";
$hash{'of'} = "yes";
$hash{'cult'} = "bob totally rules :)";

print "key bob = $hash{'bob'}\n";
print "key cult = $hash{'cult'}\n";
untie %hash;

tie %hash, 'Crypt::xDBM_File', 'Crypt::Blowfish', '01234567', 'NDBM_File', "/tmp/bob.blf", O_RDWR|O_CREAT, 0640;

$hash{'bob'} = "bob rules!";
$hash{'of'} = "yes";
$hash{'cult'} = "bob totally rules :)";

print "key bob = $hash{'bob'}\n";
print "key cult = $hash{'cult'}\n";
untie %hash;

print "You should have three bob.xxx files in your tmp directory (gdbm encrypted with idea, sdbm encrypted with des, and ndbm encrypted with blowfish\n";
