# Copyright 2018 Raphaël P. Barazzutti
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

sub git_info_2 {
    my $GIN = ".git/gitHeadInfo.gin";
    my $NGIN = "$GIN.new";

    if(length(`git status --porcelain`) == 0){
        # Get the first tag found in the history from the current HEAD
        $FIRSTTAG = `git describe --tags --always --dirty='-*' 2>/dev/null`;
        chop($FIRSTTAG);

        # Get the first tag in history that looks like a Release
        $RELTAG = `git describe --tags --long --always --dirty='-*' --match '[0-9]*.*' 2>/dev/null`;
        chop($RELTAG);

        # Hoover up the metadata
        system "git --no-pager log -1 --date=short --decorate=short \\
            --pretty=format:\"\\usepackage[%
                shash={%h},
                lhash={%H},
                authname={%an},
                authemail={%ae},
                authsdate={%ad},
                authidate={%ai},
                authudate={%at},
                commname={%an},
                commemail={%ae},
                commsdate={%ad},
                commidate={%ai},
                commudate={%at},
                refnames={%d},
                firsttagdescribe={$FIRSTTAG},
                reltag={$RELTAG}
            ]{gitexinfo}\" HEAD > $NGIN";
    }else{
        print "GIT UNCLEAN\n";   
    }

    if((-e $GIN || -e $NGIN) && (system("cmp -s $GIN $NGIN") != 0)){
            print "Status changed, request recompilation\n";
            $go_mode = 1;
            unlink($GIN);
            rename($NGIN, $GIN);
    } else {
        unlink($NGIN);
    }
}

git_info_2();