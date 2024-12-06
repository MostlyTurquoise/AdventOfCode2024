#!/usr/bin/perl
use v5.38;
use warnings; 
use strict;

my @tiles = ();
my @visitedTiles = ();

open(my $in,  "<",  "input.txt")  or die "Can't open input.txt: $!";
my @spos = ( -1, -1);
my $lines = 0;
my $cols = 0;
my $dir = 0;
# 0 ^
# 1 >
# 2 v
# 3 <
while (<$in>) {
    my $sposx = index($_, "^");
    if($sposx != -1){
        print "found ^ at: ";
        @spos[0] = $lines;
        @spos[1] = $sposx;
        push(@visitedTiles, [@spos]);
        print "$_, " for @spos;
    }
    my @chars = split(//, $_);
    push(@tiles, [@chars]);
    $cols = @chars;
    $lines++;
}
print "\n";
while( $spos[0] >= 0 && $spos[0] < $lines && $spos[1] >= 0 && $spos[1] < $cols) {
    print "----------\n";
    print "at ";
    print "$_ " for @spos;
    print "\n";
    print "current is ";
    print $tiles[$spos[0]][$spos[1]];
    print "\n";
    print "next is ";
    if($dir==0){
        print $tiles[$spos[0] - 1][$spos[1]];
    } elsif($dir==1){
        print $tiles[$spos[0]][$spos[1] + 1];
    } elsif($dir==2){
        print $tiles[$spos[0] + 1][$spos[1]];
    } elsif($dir==3){
        print $tiles[$spos[0]][$spos[1] - 1];
    }
    print "\n";
    my $isin = 0;
    print "seen before: ";
    for(my $i = 0; $i <= $#visitedTiles; $i++){
        print "(${visitedTiles[$i][0]}, ${visitedTiles[$i][1]}) ";
        if($visitedTiles[$i][0] == $spos[0] && $visitedTiles[$i][1] == $spos[1]){
            $isin = 1;
        }
    }
    print "\n";
    if($isin == 0){
        my @currentpos = @spos;
        my $seenbeforecount = push(@visitedTiles, \@currentpos);
        print " - new tile\n";
    } else {
        print " - old tile\n";
    }
    if($dir == 0){
        if($tiles[$spos[0] - 1][$spos[1]] ne "#"){
            $spos[0]--;
        } else {
            $dir++;
            $dir %= 4;
        }
    } elsif($dir == 1){
        if($tiles[$spos[0]][$spos[1] + 1] ne "#"){
            $spos[1]++;
        } else {
            $dir++;
            $dir %= 4;
        }
    } elsif($dir == 2){
        if($tiles[$spos[0] + 1][$spos[1]] ne "#"){
            $spos[0]++;
        } else {
            $dir++;
            $dir %= 4;
        }
    } elsif($dir == 3){
        if($tiles[$spos[0]][$spos[1] - 1] ne "#"){
            $spos[1]--;
        } else {
            $dir++;
            $dir %= 4;
        }
    }
}

print $#visitedTiles + 1;