# Copyright (C) 2018 R2robot
#
# This program is free software; you can redistribute it and/or modify
# it under the terms of the GNU General Public License as published by
# the Free Software Foundation; either version 3 of the License, or
# (at your option) any later version.
#
# This program is distributed in the hope that it will be useful,
# but WITHOUT ANY WARRANTY; without even the implied warranty of
# MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
# GNU General Public License for more details.
#
# You should have received a copy of the GNU General Public License
# along with this program.  If not, see <http://www.gnu.org/licenses/>.

# Repo: https://github.com/R2robot/asciimotes

use strict;
use warnings;

my $SCRIPTNAME = 'Asciimotes';
my $AUTHOR = 'R2robot';
my $VERSION = '0.2.0';
my $LICENSE = 'GPL3';
my $DESCRIPTION = 'Text based emotes';

if(!weechat::register($SCRIPTNAME, $AUTHOR, $VERSION, $LICENSE, $DESCRIPTION, "", "") ) {
    weechat::print("", "Load Failed" );
}


my %emotes  = (
    army       => '(-(-_(-_-)_-)-)',
    cat        => '(= ФェФ=)',
    cry        => '(╥﹏╥)',
    cute       => '(｡◕‿‿◕｡)',
    cheers     => "（ ^_^）o自自o（^_^ ）",
    dead       => 'x_x',
    derp       => '☉ ‿ ⚆',
    dog        => '(◕ᴥ◕ʋ)',
    doh        => '(>_<)',
    dunno      => '¯\(°_o)/¯',
    tableflip  => "('°□°）╯︵ ┻━┻",
    tableflip2 => '┻━┻ ︵ヽ(`Д´)ﾉ︵ ┻━┻',
    tablereset => '┬─┬ノ( º _ ºノ)',
    flex       => 'ᕙ\(⇀‸↼‶)ᕗ',
    cute2      => '(｡◕‿◕｡)',
    dance      => '♪┏(・o･)┛♪┗ ( ･o･) ┓',
    deal       => '(•_•) ( •_•)>⌐■-■ (⌐■_■)',
    devious    => 'ಠ‿ಠ',
    facepalm   => '(－‸ლ)',
    fiteme     => 'ლ(｀ー´ლ)',
    fingers    => '╭∩╮(Ο_Ο)╭∩╮',
    fuckyou    => '┌П┐(ಠ_ಠ)',
    loda       => 'ಠ_ಠ',
    lol        => 'L(° O °L)',
    magic      => 'ヽ(｀Д´)⊃━☆ﾟ. * ･ ｡ﾟ,',
    metal      => '\m/,(> . <)_\m/',
    pretty     => 'ఠ_ఠ',
    punch      => "O=('-'Q)",
    runaway    => 'ε=ε=ε= ┌(;*´Д`)ﾉ',
    sad        => '(._.)',
    sadconf    => '¯\_(⊙︿⊙)_/¯',
    sellout    => '[̲̅$̲̅(̲̅ ͡° ͜ʖ ͡°̲̅)̲̅$̲̅]',
    shame      => '(；一_一)',
    shrug      => '¯\_(ツ)_/¯',
    sword      => 'o()xxxx[{::::::::::::::::::>',
    why        => 'щ（ﾟД ﾟщ）',
    yay        => '\(´▽`)/',
    pat        => '( T_T)＼(^-^ )',
    thicc      => 'ㄒ卄丨匚匚',
    ethicc     => '乇乂ㄒ尺卂 ㄒ卄丨匚匚',
    woo        => '＼(^o^)／',
);


sub list {
    my $buffer = shift;
    weechat::print($buffer, join(" ", keys(%emotes)));
}


sub command_cb {
    my ($data, $buffer, $args) = @_;

    my @a = split(" ", $args);
    my $s = $#a;

    if (exists $emotes{$a[0]}) {

        if ($s == 1) {
            weechat::command($buffer, $emotes{$a[0]});
        } else {
            my $message = join(" ", @a[1 .. $s]);
            weechat::command($buffer, $emotes{$a[0]} . " " . $message);
        }

    } elsif ($a[0] eq "list" ) {
        list($buffer);
    } else {
        weechat::print("", $a[0] . " is not an emote or command.");
    }

    return weechat::WEECHAT_RC_OK;
}


my $hook = weechat::hook_command("emo", "My collection of alias emotes in one command.",
            "<emote> [message]
                        list [full]",
            " list - show a list of emote names available\nlist full - show a list of emote names and the emotes\n",
             join("|", keys(%emotes)),
            "command_cb", "" );
