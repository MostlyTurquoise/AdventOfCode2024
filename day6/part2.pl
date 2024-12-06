#!/usr/bin/perl
use v5.38;
use warnings; 
use strict;

my @tiles = ();
my @basePathTiles = ();
my @basePathDirs = ();

open(my $in,  "<",  "input.txt")  or die "Can't open input.txt: $!";
my @spos = ( -1, -1);
my @ospos = ( -1, -1);
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
        @spos[0] = $lines;
        @spos[1] = $sposx;
        @ospos[0] = $lines;
        @ospos[1] = $sposx;
        push(@basePathTiles, [@spos]);
        push(@basePathDirs, $dir);
    }
    my @chars = split(//, $_);
    push(@tiles, [@chars]);
    $cols = @chars;
    $lines++;
}

print "Finding initial path\n";

while( $spos[0] >= 0 && $spos[0] < $lines && $spos[1] >= 0 && $spos[1] < $cols) {
    # print "----------\n";
    # print "at ";
    # print "$_ " for @spos;
    # print "\n";
    # print "current is ";
    # print $tiles[$spos[0]][$spos[1]];
    # print "\n";
    # print "next is ";
    # if($dir==0){
    #     print $tiles[$spos[0] - 1][$spos[1]];
    # } elsif($dir==1){
    #     print $tiles[$spos[0]][$spos[1] + 1];
    # } elsif($dir==2){
    #     print $tiles[$spos[0] + 1][$spos[1]];
    # } elsif($dir==3){
    #     print $tiles[$spos[0]][$spos[1] - 1];
    # }
    # print "\n";
    my @currentpos = @spos;
    push(@basePathTiles, \@currentpos);
    push(@basePathDirs, $dir);
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

print "loaded initial path ";
for(my $i = 0; $i <= $#basePathTiles; $i++){
    print "(${basePathTiles[$i][0]}, ${basePathTiles[$i][1]}) ";
}
print "\n";
for(my $i = 0; $i <= $#basePathDirs; $i++){
    print "(${basePathDirs[$i]}) ";
}
print "\n";

my %loops = {
};

for(my $i = 0; $i <= $#basePathTiles; $i++){
    my @blockedTile = ($basePathTiles[$i][0], $basePathTiles[$i][1]);
    print "&Checking ${basePathTiles[$i][0]}, ${basePathTiles[$i][1]}\t\t$i/$#basePathTiles\n";
    my $continuing = 1;
    $tiles[$blockedTile[0]][$blockedTile[1]] = "#";
    $dir = 0;
    @spos = @ospos;
    my @pathTiles = ();
    my @pathDirs = ();
    while( $spos[0] >= 0 && $spos[0] < $lines && $spos[1] >= 0 && $spos[1] < $cols && $continuing == 1) {
        # print "${spos[0]} ${spos[1]} facing ${dir}\n";
        my $isin = 0;
        for(my $i = 0; $i <= $#pathTiles; $i++){
            # if($spos[0] == 100 && $spos[1] == 105){
            #     print "vs ${pathTiles[$i][0]} ${pathTiles[$i][1]} facing ${pathDirs[$i]}\n";
            # }
            if($pathTiles[$i][0] == $spos[0] && $pathTiles[$i][1] == $spos[1] && $dir == $pathDirs[$i]){
                $isin = 1;
                # print "here";
            }
        }
        if($isin == 1){
            # print "loop ${blockedTile[0]} ${blockedTile[1]}\n";
            $loops{"${blockedTile[0]}_${blockedTile[1]}"} = 1;
            $continuing = 0;
        }
        my @currentpos = @spos;
        push(@pathTiles, \@currentpos);
        push(@pathDirs, $dir);
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
    $tiles[$blockedTile[0]][$blockedTile[1]] = ".";
}

print "\n";
my @keys = keys %loops;
print $#keys;