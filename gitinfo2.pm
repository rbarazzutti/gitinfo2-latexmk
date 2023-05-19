#!/usr/bin/env perl
# Copyright 2018 Raphaël P. Barazzutti
# 
# GitInfo2LatexMk - v0.2.1
# Inspired by Brent Longborough's update-git.sh (part of gitinfo2 LaTeX package)
# 
# The original update-git.sh is supposed to be "hooked" to some git events (such that
# Post-{commit,checkout,merge}).
# Although this approach is elegant, I find a bit too intrusive and complicated
# to maintain.
#
# This Perl variant makes sense for latexmk users. The only requirement is to add
# the following line into the .latexmkrc file that lays in the root of your 
# LaTeX project (create it, if absent).
# 
# do './gitinfo2.pm'
# 
# That's it! Now it'd work!
use Getopt::Long;
use Pod::Usage;
use strict;
use warnings FATAL => 'all';
my $man = 0;
my $help = 0;
my $force = 0;
GetOptions(
    force    => \$force,
    'help|?' => \$help,
    man      => \$man
);
sub git_info_2 {

    # get file content as a string
    my $get_file_content = sub {
        my ($f) = @_;

        # do not separate the reads per line
        local $/ = undef;

        open FILE, $f or return "";
        my $string = <FILE>;

        close FILE;
        return $string;
    };

    # compare two files`
    my $cmp = sub {
        my ($file1, $file2) = @_;

        return $get_file_content->($file1) ne $get_file_content->($file2);
    };

    my $RELEASE_MATCHER = "[0-9]*.*";

    if (my %GI2TM_OPTIONS) {
        if (exists $GI2TM_OPTIONS{"RELEASE_MATCHER"}) {
            $RELEASE_MATCHER = $GI2TM_OPTIONS{"RELEASE_MATCHER"};
        }
    }

    # When running in a sub-directories of the repo
    my $REPOBASE = `git rev-parse --show-toplevel`;
    $REPOBASE =~ s/\s+$//;

    my $GITDIR = "$REPOBASE/.git";

    my $GIN = "$GITDIR/gitHeadInfo.gin";
    my $NGIN = "$GIN.new";

    if (length(`git status --porcelain`) == 0 || $force == 1) {
        # Get the first tag found in the history from the current HEAD
        my $FIRSTTAG = `git describe --tags --always --dirty='-*'`;
        chop($FIRSTTAG);

        # Get the first tag in history that looks like a Release
        my $RELTAG = `git describe --tags --long --always --dirty='-*' --match '$RELEASE_MATCHER'`;
        chop($RELTAG);

        # Hoover up the metadata
        my $metadata =`git --no-pager log -1 --date=short --decorate=short --pretty=format:"shash={%h}, lhash={%H}, authname={%an}, authemail={%ae}, authsdate={%ad}, authidate={%ai}, authudate={%at}, commname={%an}, commemail={%ae}, commsdate={%ad}, commidate={%ai}, commudate={%at}, refnames={%d}, firsttagdescribe={$FIRSTTAG}, reltag={$RELTAG} " HEAD`;

        # When running in a sub-directories of the repo
        my $dir = ".git";
        if (!(-e $dir) and !(-d $dir)) {
            mkdir($dir);
        }

        open(my $fh, '>', $NGIN);
        print $fh "\\usepackage[" . $metadata . "]{gitexinfo}\n";
        close $fh;
    }
    else {
        print "GIT UNCLEAN\n";
    }

    $cmp->($GIN, $NGIN);

    if ((-e $GIN || -e $NGIN) && $cmp->($GIN, $NGIN)) {
        print "Status changed, request recompilation\n";
        unlink($GIN);
        rename($NGIN, $GIN);
    }
    else {
        unlink($NGIN);
    }
}

pod2usage(1) if $help == 1;
pod2usage(-exitval => 0, -verbose => 2) if $man == 1;
git_info_2();

__END__

=head1 NAME

gitinfo2 - Generate gitinfo file for usage of gitinfo2

=head1 SYNOPSIS

gitinfo2 [-help] [-man] [-force]

 Options:
   -help            brief help message
   -man             full documentation
   -force           force generation of gitinfo, even if the repository is dirty

=head1 OPTIONS

=over 8

=item B<-help>

Print a brief help message and exits.

=item B<-man>

Prints the manual page and exits.

=item B<-force>

Force generation of gitinfo, even if the repository is dirty


=back

=head1 DESCRIPTION

B<gitinfo2> can be used together with gitnfo2 to generate the gitinfo file

=cut